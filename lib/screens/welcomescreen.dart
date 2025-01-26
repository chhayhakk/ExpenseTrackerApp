import 'package:expensetracker/screens/signin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Welcomescreen extends StatelessWidget {
  const Welcomescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 80, right: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('assets/logos/expense_logo.png'),
                    height: 100,
                    width: 100,
                  ),
                  Text(
                    'Tonaire',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
            ),
            Image(
              image: AssetImage('assets/images/tracker.jpg'),
              height: 500,
              width: 500,
            ),
            Text(
              'Track Down Expenses',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w800,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Daily note your expenses to',
              style: TextStyle(
                color: Colors.grey.shade400,
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
            Text(
              'help manage money',
              style: TextStyle(
                color: Colors.grey.shade400,
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => Signin());
                  },
                  child: Text(
                    'Let\'s Get Started',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.only(top: 15, bottom: 15),
                      backgroundColor: Color(0xFF1C41F8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      )),
                ))
          ],
        ),
      ),
    );
  }
}
