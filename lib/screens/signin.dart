import 'package:dio/dio.dart';
import 'package:expensetracker/controllers/usercontroller.dart';
import 'package:expensetracker/screens/home.dart';
import 'package:expensetracker/screens/navigation.dart';
import 'package:expensetracker/screens/register.dart';
import 'package:expensetracker/services/api_service_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final UserController userController = Get.put(UserController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? message;
  bool _obsecureTextValue = true;
  IconData _openCloseEyeIcon = Icons.remove_red_eye_outlined;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFBFBFB),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            children: [
              Center(
                child: Image(
                  image: AssetImage('assets/logos/expense_logo.png'),
                  width: 250,
                  height: 250,
                ),
              ),
              Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required';
                            }
                            if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              errorText: message != null ? message : null,
                              filled: true,
                              fillColor: Color(0xFFF4F5F6),
                              prefixIcon: Icon(Icons.person),
                              label: Text(
                                'Email',
                                style: TextStyle(color: Colors.grey.shade400),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is require';
                            }
                            if (value != passwordController.text) {
                              return 'Password do not match';
                            }
                            return null;
                          },
                          obscureText: _obsecureTextValue,
                          obscuringCharacter: '*',
                          decoration: InputDecoration(
                              errorText: message != null ? message : null,
                              filled: true,
                              fillColor: Color(0xFFF4F5F6),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    _obsecureTextValue = !_obsecureTextValue;
                                    _openCloseEyeIcon = _obsecureTextValue
                                        ? Icons.remove_red_eye_outlined
                                        : Icons.remove_red_eye;
                                    setState(() {});
                                  },
                                  icon: Icon(
                                    _openCloseEyeIcon,
                                    color: Colors.grey.shade400,
                                  )),
                              prefixIcon: Icon(Icons.lock),
                              label: Text(
                                'Password',
                                style: TextStyle(color: Colors.grey.shade400),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              )),
                        ),
                        const Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Forget Password?',
                            style: TextStyle(
                              color: Color(0xFF1C40F6),
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 25),
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF1C40F7),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  )),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  final email = emailController.text.trim();
                                  final password =
                                      passwordController.text.trim();
                                  try {
                                    final apiService = ApiServiceUser(Dio());
                                    final response =
                                        await apiService.login(email, password);
                                    if (response.containsKey('token')) {
                                      final profileData =
                                          await apiService.getProfile();
                                      userController
                                          .setUserProfile(profileData);
                                      Get.to(() => Navigation());
                                    } else if (response.containsKey('error')) {
                                      setState(() {
                                        message = response['error'];
                                      });
                                    }
                                  } catch (e) {
                                    setState(() {
                                      message = 'Sign in failed: $e';
                                    });
                                    print(message);
                                  }
                                }
                              },
                              child: Text(
                                'LOGIN',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    letterSpacing: 1),
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.grey.shade600,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(() => Register());
                              },
                              child: const Text(
                                'Register Now',
                                style: TextStyle(
                                  color: Color(0xFF1C40F6),
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
