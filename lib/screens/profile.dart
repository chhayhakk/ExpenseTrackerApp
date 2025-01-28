import 'package:dio/dio.dart';
import 'package:expensetracker/screens/empty.dart';
import 'package:expensetracker/screens/home.dart';
import 'package:expensetracker/screens/signin.dart';
import 'package:expensetracker/services/api_service_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

Widget _NaviationItem(String myText, IconData myIcon) {
  return ListTile(
    leading: Icon(
      myIcon,
      size: 34,
    ),
    title: Text(
      myText,
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 19,
      ),
    ),
  );
}

Future<void> _logout(BuildContext context) async {
  showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 250,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(right: 20, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Are you sure you want to log out?',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 22,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      height: 55,
                      child: Container(
                        height: 55,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFECECEC),
                          ),
                          onPressed: () {
                            Navigator.pop(context); // Close the bottom sheet
                          },
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.brown,
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Container(
                      height: 55,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          onPressed: () {
                            final apiService = ApiServiceUser(Dio());
                            apiService.logOut();
                            Get.offAll(() => Signin());
                          },
                          child: Text(
                            'Yes, logout',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          )),
                    ))
                  ],
                )
              ],
            ),
          ),
        );
      });
}

final List<Map<String, dynamic>> _NavigationListItem = [
  {
    'icon': Icons.person_outline,
    'title': 'Your profile',
  },
  {
    'icon': Icons.settings_outlined,
    'title': 'Settings',
  },
  {
    'icon': Icons.help_outline,
    'title': 'Help Center',
  },
  {
    'icon': Icons.lock_outline,
    'title': 'Privacy Policy',
  },
  {
    'icon': Icons.group_outlined,
    'title': 'Invite Friends',
  },
  {
    'icon': Icons.logout,
    'title': 'Log out',
  },
];

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Color(0xFF073063),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15)),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 50),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 9),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              'Profile',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    right: 0,
                    left: 0,
                    top: 150,
                    child: Center(
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Image(
                          image: AssetImage(
                            'assets/logos/expense_logo.png',
                          ),
                          fit: BoxFit.cover,
                          width: 150,
                          height: 150,
                        ),
                      ),
                    )),
                SizedBox(
                  height: 330,
                ),
              ],
            ),
            Text(
              'Kourk Chhay Hak',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 22,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          if (_NavigationListItem[index]['title'] ==
                              'Log out') {
                            await _logout(context);
                          } else if (_NavigationListItem[index]['title'] ==
                              'Your Profile') {
                            Get.to(() => Empty());
                          } else if (_NavigationListItem[index]['title'] ==
                              'Settings') {
                            Get.to(() => Empty());
                          } else if (_NavigationListItem[index]['title'] ==
                              'Help Center') {
                            Get.to(() => Empty());
                          } else if (_NavigationListItem[index]['title'] ==
                              'Privacy Policy') {
                            Get.to(() => Empty());
                          } else if (_NavigationListItem[index]['title'] ==
                              'Invite Friends') {
                            Get.to(() => Empty());
                          }
                        },
                        child: _NaviationItem(
                          _NavigationListItem[index]['title'],
                          _NavigationListItem[index]['icon'],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(
                          thickness: 1,
                          color: Colors.grey.shade300,
                          indent: 20,
                          endIndent: 20,
                        ),
                    itemCount: _NavigationListItem.length),
              ),
            )
          ],
        ),
      ),
    );
  }
}
