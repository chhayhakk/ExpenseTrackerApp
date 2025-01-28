import 'package:dio/dio.dart';
import 'package:expensetracker/services/api_service_expense.dart';
import 'package:get/get.dart';

import '../services/api_service_user.dart';

class ExpenseController extends GetxController {
  RxList<Map<String, dynamic>> expenses = RxList<Map<String, dynamic>>([]);

  Future<void> fetchExpenses() async {
    try {
      final response = await ApiServiceExpense(Dio()).fetchExpense();

      if (response.containsKey('expenses')) {
        expenses.value = List<Map<String, dynamic>>.from(response['expenses']);
        expenses.refresh();
      } else {
        print('Error: ${response['error']}');
      }
    } catch (e) {
      print('Error fetching expenses: $e');
    }
  }

  void setExpenses(List<Map<String, dynamic>> expenseList) {
    expenses.value = expenseList;
    expenses.refresh();
  }
}
