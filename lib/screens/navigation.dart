import 'package:expensetracker/screens/expense.dart';
import 'package:expensetracker/screens/home.dart';
import 'package:expensetracker/screens/profile.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  var _currentIndex = 0.obs;

  void onItemTapped(int index) {
    _currentIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: _currentIndex.value,
          selectedItemColor: const Color(0xFF001E42),
          type: BottomNavigationBarType.fixed,
          onTap: onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.credit_card),
              label: 'Expense',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        );
      }),
      body: Obx(() {
        switch (_currentIndex.value) {
          case 0:
            return Home();
          case 1:
            return ExpenseScreen();
          case 2:
            return Profile();
          default:
            return Home();
        }
      }),
    );
  }
}
