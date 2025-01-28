import 'package:dio/dio.dart';
import 'package:expensetracker/services/api_service_expense.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import 'expense.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  DateTime _focusDay = DateTime.now();
  DateTime? _selectedDay;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController categoryController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  String? selectedCategory;
  List<String> categories = [
    'Food',
    'Entertainment',
    'Medical',
    'Education',
    'Electricity',
    'Housing',
    'Insurance',
    'Shopping',
  ];

  void _updateDateField() {
    if (_selectedDay != null) {
      // dateController.text =
      //     '${_selectedDay!.year}-${_selectedDay!.month.toString().padLeft(2, '0')}-${_selectedDay!.day}';
      final DateFormat formatter = DateFormat('MMM dd, yyyy');
      dateController.text = formatter.format(_selectedDay!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F5F6),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(Icons.arrow_back, size: 24)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 9),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Add Expenses',
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
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(right: 20, left: 20, bottom: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TableCalendar(
                  daysOfWeekVisible: true,
                  daysOfWeekStyle: DaysOfWeekStyle(
                      weekendStyle: TextStyle(
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.bold),
                      weekdayStyle: TextStyle(
                          color: Colors.grey.shade400,
                          fontWeight: FontWeight.bold)),
                  calendarStyle: CalendarStyle(
                    defaultTextStyle: TextStyle(fontWeight: FontWeight.bold),
                    weekendTextStyle: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                    holidayTextStyle: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                    todayDecoration: BoxDecoration(
                      color: Color(0xFF073063),
                      shape: BoxShape.circle,
                    ),
                  ),
                  headerStyle: HeaderStyle(
                      titleTextStyle:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
                      leftChevronIcon: Icon(
                        Icons.arrow_back_ios_new,
                        size: 17,
                        color: Colors.grey.shade400,
                      ),
                      rightChevronIcon: Icon(
                        Icons.arrow_forward_ios,
                        size: 17,
                        color: Colors.grey.shade400,
                      ),
                      titleCentered: true,
                      formatButtonVisible: false,
                      leftChevronPadding: EdgeInsets.only(left: 80),
                      rightChevronPadding: EdgeInsets.only(right: 80)),
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusDay = focusDay;
                      _updateDateField();
                    });
                  },
                  focusedDay: _focusDay,
                  firstDay: DateTime.utc(2010, 1, 1),
                  lastDay: DateTime.utc(2100, 1, 1)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Expense Category',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField<String>(
                        menuMaxHeight: 200,
                        hint: Center(
                          child: Text(
                            'Category',
                            style: TextStyle(color: Colors.grey.shade400),
                          ),
                        ),
                        dropdownColor: Colors.white,
                        value: selectedCategory,
                        onChanged: (value) {
                          selectedCategory = value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a category';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          suffixIcon: Icon(
                            Icons.category,
                            size: 16,
                            color: Colors.grey.shade400,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        items: categories.map((category) {
                          return DropdownMenuItem<String>(
                            value: category,
                            child: Text(
                              category,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Column for "Amount"
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Amount',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your amount';
                                    }
                                    final regex = RegExp(r'^\d+(\.\d+)?$');
                                    if (!regex.hasMatch(value)) {
                                      return 'Please enter a valid number';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  controller: amountController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    suffixIcon: Icon(
                                      Icons.money_outlined,
                                      size: 16,
                                      color: Colors.grey.shade400,
                                    ),
                                    hintText: 'Amount',
                                    hintStyle:
                                        TextStyle(color: Colors.grey.shade400),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Choose Date',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(height: 10),
                                TextFormField(
                                  validator: (value) {
                                    final regex =
                                        RegExp(r'^[A-Za-z]{3} \d{1,2}, \d{4}$');

                                    if (value == null ||
                                        value.isEmpty ||
                                        !regex.hasMatch(value)) {
                                      return 'Select date from calendar.';
                                    }
                                    return null;
                                  },
                                  readOnly: true,
                                  controller: dateController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    suffixIcon: Icon(
                                      Icons.calendar_today_outlined,
                                      size: 16,
                                      color: Colors.grey.shade400,
                                    ),
                                    hintText: 'Select a date from calendar',
                                    hintStyle: TextStyle(
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Add Note',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: noteController,
                        maxLines: 5,
                        decoration: InputDecoration(
                            hintStyle: TextStyle(color: Colors.grey.shade400),
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none)),
                      )
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 20, top: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF073063),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: () async {
                  try {
                    if (_formKey.currentState!.validate()) {
                      final category = selectedCategory!;
                      final amount = double.parse(amountController.text.trim());
                      final date = dateController.text.trim();
                      final notes = noteController.text.trim();
                      final apiService = ApiServiceExpense(Dio());
                      final response = await apiService.addExpense(
                          amount, date, category, notes);
                      if (response.containsKey('success')) {
                        setState(() {
                          selectedCategory = null;
                        });
                        dateController.text = 'Select a date from calander';
                        amountController.clear();
                        noteController.clear();
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.success,
                          text: 'Expense Added Successfully!',
                          confirmBtnColor: Color(0xFF073063),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Failed added new expense')));
                      }
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            'Your token has expired. Please log in again to regenerate.')));
                  }
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
      ),
    );
  }
}
