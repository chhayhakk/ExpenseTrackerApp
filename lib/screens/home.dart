import 'package:dio/dio.dart';
import 'package:expensetracker/controllers/expensecontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expensetracker/services/api_service_user.dart';
import 'package:intl/intl.dart';

import '../controllers/usercontroller.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

Widget myCategory(
    String myText, IconData myIcon, Color myColorIcon, Color myColorBox) {
  return SizedBox(
    width: 80,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 5),
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: myColorBox,
          ),
          child: Icon(
            myIcon,
            color: myColorIcon,
          ),
        ),
        Text(
          myText,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    ),
  );
}

class _HomeState extends State<Home> {
  final UserController userController = Get.put(UserController());
  final ExpenseController expenseController = Get.put(ExpenseController());
  double totalAmount = 0.0;
  @override
  void initState() {
    super.initState();
    _fetchExpense();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    ApiServiceUser apiServiceUser = ApiServiceUser(Dio());
    final profile = await apiServiceUser.getProfile();
    userController.setUserProfile(profile);
  }

  Future<void> _fetchExpense() async {
    expenseController.fetchExpenses();
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Entertainment':
        return Colors.blue.shade100;
      case 'Food':
        return Colors.green.shade100;
      case 'Electricity':
        return Colors.yellow.shade100;
      case 'Medical':
        return Colors.purple.shade100;
      case 'Shopping':
        return Colors.pink.shade100;
      case 'Housing':
        return Colors.brown.shade100;
      case 'Education':
        return Colors.red.shade100;
      case 'Insurance':
        return Colors.orange.shade100;
      default:
        return Colors.grey.shade100;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Entertainment':
        return Icons.tv;
      case 'Food':
        return Icons.fastfood;
      case 'Electricity':
        return Icons.bolt;
      case 'Medical':
        return Icons.medical_services;
      case 'Shopping':
        return Icons.shopping_cart;
      case 'Housing':
        return Icons.home;
      case 'Education':
        return Icons.school;
      case 'Insurance':
        return Icons.help;
      default:
        return Icons.category;
    }
  }

  Color _getIconColor(String category) {
    switch (category) {
      case 'Entertainment':
        return Colors.blue;
      case 'Food':
        return Colors.green;
      case 'Electricity':
        return Colors.yellow;
      case 'Medical':
        return Colors.purple;
      case 'Shopping':
        return Colors.pink;
      case 'Housing':
        return Colors.brown;
      case 'Education':
        return Colors.red;
      case 'Insurance':
        return Colors.orange;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    var expensesData = expenseController.expenses;

    return Scaffold(
      backgroundColor: Color(0xFFF3F3F3),
      body: Obx(() {
        if (userController.userProfile.isEmpty) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        double totalAmountExpense =
            expensesData.fold(0.0, (sum, expense) => sum + expense['amount']);
        return SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      color: Color(0xFF073063),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Welcome back,',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                userController.userProfile['username'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, top: 60),
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Icon(Icons.notifications_outlined,
                              color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    right: 0,
                    left: 0,
                    top: 140,
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.only(right: 20, left: 20),
                        height: 220,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFF001E42),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total Balance',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Icon(
                                    Icons.more_horiz,
                                    size: 32,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                              Text(
                                '\$2,548.00',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 32,
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            width: 25,
                                            height: 25,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color:
                                                  Colors.grey.withOpacity(0.1),
                                            ),
                                            child: Center(
                                                child: Icon(
                                              Icons.arrow_downward,
                                              color: Colors.white,
                                              size: 15,
                                            )),
                                          ),
                                          Text(
                                            'Income',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 15,
                                            ),
                                          )
                                        ],
                                      ),
                                      Text(
                                        '\$3490.99',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20,
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(right: 10),
                                            width: 25,
                                            height: 25,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color:
                                                  Colors.grey.withOpacity(0.1),
                                            ),
                                            child: Center(
                                                child: Icon(
                                              Icons.arrow_upward,
                                              color: Colors.white,
                                              size: 15,
                                            )),
                                          ),
                                          Text(
                                            'Expenses',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 15,
                                            ),
                                          )
                                        ],
                                      ),
                                      Text(
                                        '\$${totalAmountExpense}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 380),
                ],
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Category',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            'See all',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      endIndent: 10,
                      indent: 10,
                      color: Colors.grey.shade200,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          myCategory('Electricity', Icons.electric_bolt,
                              Colors.yellow.shade900, Colors.yellow.shade100),
                          myCategory('Food', Icons.food_bank,
                              Colors.green.shade900, Colors.green.shade100),
                          myCategory('Entertainment', Icons.tv,
                              Colors.blue.shade900, Colors.blue.shade100),
                          myCategory('Medical', Icons.local_hospital,
                              Colors.pink.shade900, Colors.pink.shade100),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          myCategory('Education', Icons.school,
                              Colors.red.shade900, Colors.red.shade100),
                          myCategory('Shopping', Icons.food_bank,
                              Colors.purple.shade900, Colors.purple.shade100),
                          myCategory('Housing', Icons.house,
                              Colors.blue.shade900, Colors.blue.shade100),
                          myCategory('Insurance', Icons.help,
                              Colors.orange.shade900, Colors.orange.shade100),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (expenseController.expenses.isNotEmpty) ...[
                Container(
                  margin: EdgeInsets.only(right: 20, left: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 20),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Recent Entries',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          thickness: 1,
                          endIndent: 10,
                          indent: 10,
                          color: Colors.grey.shade200,
                        ),
                        Expanded(
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: expenseController.expenses.length > 4
                                ? 3
                                : expenseController.expenses.length,
                            itemBuilder: (context, index) {
                              final sortedExpenses =
                                  expenseController.expenses.toList()
                                    ..sort((a, b) {
                                      // Parse the date strings to DateTime objects using DateFormat
                                      DateTime parseDate(String date) {
                                        final formatter = DateFormat(
                                            'MMM dd, yyyy'); // "Jan 28, 2025" format
                                        return formatter.parse(date);
                                      }

                                      // Compare the dates in descending order
                                      return parseDate(b['date'])
                                          .compareTo(parseDate(a['date']));
                                    });
                              final expense = sortedExpenses[index];
                              return Padding(
                                padding: EdgeInsets.only(
                                    right: 10, left: 10, bottom: 5),
                                child: ListTile(
                                  leading: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: _getCategoryColor(
                                          expense['category']),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Icon(
                                      _getCategoryIcon(expense['category']),
                                      size: 18,
                                      color: _getIconColor(expense['category']),
                                    ),
                                  ),
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(expense['category']),
                                          Text(
                                            expense['date'],
                                            style: TextStyle(
                                                color: Colors.grey.shade400),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        '-\$${expense['amount']}',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              SizedBox(
                height: 20,
              ),
            ],
          ),
        );
      }),
    );
  }
}
