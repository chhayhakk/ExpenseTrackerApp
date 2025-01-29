import 'package:dio/dio.dart';
import 'package:expensetracker/screens/signin.dart';
import 'package:expensetracker/services/api_service_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _obsecureTextValue = true;
  IconData _openCloseEyeIcon = Icons.remove_red_eye_outlined;

  bool _obsecureTextValue_forConfirm = true;
  IconData _openCloseEyeIcon_forConfirm = Icons.remove_red_eye_outlined;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? message;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
              Center(
                child: Text(
                  'Creating Your New Account',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
              ),
              SizedBox(
                height: 25,
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
                              prefixIcon: Icon(Icons.email),
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Username is required';
                            }
                            if (value.length < 6) {
                              return 'Username must have at least 6 characters';
                            }
                            if (value.length > 20) {
                              return 'Username exceeds limit characters';
                            }
                            return null;
                          },
                          controller: usernameController,
                          decoration: InputDecoration(
                              // errorText: message != null ? message : null,
                              filled: true,
                              fillColor: Color(0xFFF4F5F6),
                              prefixIcon: Icon(Icons.person),
                              label: Text(
                                'Username',
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 character';
                            }
                            return null;
                          },
                          controller: passwordController,
                          obscureText: _obsecureTextValue,
                          obscuringCharacter: '*',
                          decoration: InputDecoration(
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
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: confirmController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Confirm password is required';
                            }
                            if (value != passwordController.text) {
                              return 'Password do not match';
                            }
                            return null;
                          },
                          obscureText: _obsecureTextValue_forConfirm,
                          obscuringCharacter: '*',
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFFF4F5F6),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    _obsecureTextValue_forConfirm =
                                        !_obsecureTextValue_forConfirm;
                                    _openCloseEyeIcon_forConfirm =
                                        _obsecureTextValue_forConfirm
                                            ? Icons.remove_red_eye_outlined
                                            : Icons.remove_red_eye;
                                    setState(() {});
                                  },
                                  icon: Icon(
                                    _openCloseEyeIcon_forConfirm,
                                    color: Colors.grey.shade400,
                                  )),
                              prefixIcon: Icon(Icons.lock),
                              label: Text(
                                'Confirm Password',
                                style: TextStyle(color: Colors.grey.shade400),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              )),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 25),
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF1C40F7),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  )),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  final email = emailController.text.trim();
                                  final username =
                                      usernameController.text.trim();
                                  final password =
                                      passwordController.text.trim();
                                  final confirmPassword =
                                      confirmController.text.trim();

                                  try {
                                    final apiService = ApiServiceUser(Dio());
                                    final response = await apiService.signup(
                                        username, email, password);
                                    if (response.containsKey('message')) {
                                      emailController.clear();
                                      usernameController.clear();
                                      passwordController.clear();
                                      confirmController.clear();
                                      Get.off(() => Signin());
                                    } else if (response.containsKey('error')) {
                                      setState(() {
                                        message = response['error'];
                                      });
                                    }
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('Sign up failed: $e')),
                                    );
                                  }
                                }
                              },
                              child: Text(
                                'SIGN UP',
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
                              'Already have an account?',
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
                                Get.to(() => Signin());
                              },
                              child: const Text(
                                'Sign in',
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
