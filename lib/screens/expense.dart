import 'package:expensetracker/screens/add_expense.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../controllers/expensecontroller.dart';
import 'package:intl/intl.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({super.key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

DateTime _focusedDay = DateTime.now();
DateTime? _selectedDay;
final List<String> listDown = [
  'All',
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Oct',
  'Nov',
  'Dec'
];
String _selectList = 'All';

class _ExpenseScreenState extends State<ExpenseScreen> {
  final ExpenseController expenseController = Get.put(ExpenseController());

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
        return Colors.blue.shade900;
      case 'Food':
        return Colors.green.shade900;
      case 'Electricity':
        return Colors.yellow.shade900;
      case 'Medical':
        return Colors.purple.shade900;
      case 'Shopping':
        return Colors.pink.shade900;
      case 'Housing':
        return Colors.brown.shade900;
      case 'Education':
        return Colors.red.shade900;
      case 'Insurance':
        return Colors.orange.shade900;
      default:
        return Colors.black;
    }
  }

  DateTime _parseDate(String dateStr) {
    final format = DateFormat('MMM dd, yyyy');
    return format.parse(dateStr);
  }

  @override
  void initState() {
    super.initState();
    _fetchExpense();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchExpense();
  }

  Future<void> _fetchExpense() async {
    await expenseController.fetchExpenses();
    setState(() {});
  }

  int _getMonthIndex(String month) {
    switch (month) {
      case 'Jan':
        return 1;
      case 'Feb':
        return 2;
      case 'Mar':
        return 3;
      case 'Apr':
        return 4;
      case 'May':
        return 5;
      case 'Jun':
        return 6;
      case 'Jul':
        return 7;
      case 'Aug':
        return 8;
      case 'Sep':
        return 9;
      case 'Oct':
        return 10;
      case 'Nov':
        return 11;
      case 'Dec':
        return 12;
      default:
        return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 50),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Expenses',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: double.infinity,
                            child: TableCalendar(
                              daysOfWeekStyle: DaysOfWeekStyle(
                                weekdayStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                weekendStyle: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                              firstDay: DateTime.utc(2000, 1, 1),
                              lastDay: DateTime.utc(2100, 12, 31),
                              focusedDay: _focusedDay,
                              selectedDayPredicate: (day) {
                                return isSameDay(_selectedDay, day);
                              },
                              onDaySelected: (selectedDay, focusedDay) {
                                setState(() {
                                  _selectedDay = selectedDay;
                                  _focusedDay = focusedDay;
                                });
                              },
                              calendarFormat: CalendarFormat.week,
                              startingDayOfWeek: StartingDayOfWeek.monday,
                              headerStyle: HeaderStyle(
                                formatButtonVisible: false,
                                titleCentered: true,
                                leftChevronMargin: EdgeInsets.only(left: 60),
                                rightChevronMargin: EdgeInsets.only(right: 60),
                              ),
                              calendarStyle: CalendarStyle(
                                weekendTextStyle: TextStyle(color: Colors.red),
                                holidayTextStyle:
                                    TextStyle(color: Colors.green),
                                todayDecoration: BoxDecoration(
                                  color: Color(0xFF073063),
                                  shape: BoxShape.circle,
                                ),
                                selectedDecoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  shape: BoxShape.circle,
                                ),
                                todayTextStyle: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 20, right: 20),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.2,
                            child: DropdownButtonFormField(
                                menuMaxHeight: 200,
                                borderRadius: BorderRadius.circular(5),
                                dropdownColor: Colors.white,
                                value: _selectList,
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 8),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(5),
                                    )),
                                items: listDown.map((value) {
                                  return DropdownMenuItem(
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade700),
                                    ),
                                    value: value,
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectList = value!;
                                    _fetchExpense();
                                  });
                                }),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.54,
                        child: Obx(() {
                          final groupExpenses =
                              <String, List<Map<String, dynamic>>>{};
                          for (var expense in expenseController.expenses) {
                            final date = expense['date'];
                            final expenseDate = _parseDate(date);

                            final formattedDate = DateFormat('MMM dd, yyyy')
                                .format(expenseDate); // Format date

                            if (_selectList != 'All') {
                              final selectedMonthIndex =
                                  _getMonthIndex(_selectList);
                              if (expenseDate.month != selectedMonthIndex) {
                                continue;
                              }
                            }

                            if (!groupExpenses.containsKey(formattedDate)) {
                              groupExpenses[formattedDate] = [];
                            }
                            groupExpenses[formattedDate]!.add(expense);
                          }
                          return ListView.builder(
                              itemCount: groupExpenses.length,
                              itemBuilder: (context, index) {
                                final date =
                                    groupExpenses.keys.elementAt(index);
                                final expenses = groupExpenses[date]!;
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                      ),
                                      child: Text(
                                        date,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    ...expenses.map((expense) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            right: 10, left: 10, bottom: 5),
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          color: Colors.white,
                                          child: ListTile(
                                            contentPadding: EdgeInsets.only(
                                                right: 10,
                                                left: 10,
                                                top: 5,
                                                bottom: 5),
                                            leading: Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: _getCategoryColor(
                                                    expense['category']),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Icon(
                                                _getCategoryIcon(
                                                    expense['category']),
                                                size: 18,
                                                color: _getIconColor(
                                                    expense['category']),
                                              ),
                                            ),
                                            title: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(expense['category']),
                                                  ],
                                                ),
                                                Text(
                                                  '-\$${expense['amount']}',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            trailing: Icon(
                                              Icons.arrow_forward_ios,
                                              size: 18,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ],
                                );
                              });
                        }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF073063),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: () async {
                await Get.to(() => AddExpense());
                _fetchExpense();
              },
              child: Center(
                child: Container(
                  width: double.infinity,
                  height: 50,
                  child: Center(
                    child: Text(
                      'Add Expense',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
