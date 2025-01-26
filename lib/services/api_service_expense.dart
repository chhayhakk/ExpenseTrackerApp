import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:expensetracker/utils/api_config.dart';

class ApiServiceExpense {
  final Dio _dio;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  ApiServiceExpense(this._dio);

  String get baseUrl => ApiConfig.getBaseUrl();

  Future<Map<String, dynamic>> fetchExpense() async {
    try {
      final token = await secureStorage.read(key: 'token');
      if (token == null) {
        return {'error': 'User is not logged in'};
      }

      final response = await _dio.get('$baseUrl/expenses',
          options: Options(
            headers: {
              'Authorization': "Bearer $token",
            },
          ));

      if (response.statusCode == 200) {
        return response.data;
      } else {
        return {'error': response.data['error']};
      }
    } catch (e) {
      throw Exception('Failed to fetch expenses: $e');
    }
  }

  Future<Map<String, dynamic>> addExpense(
      String description, double amount, String date) async {
    try {
      final token = await secureStorage.read(key: 'token');
      if (token == null) {
        return {'error': 'User is not logged in'};
      }

      final response = await _dio.post('$baseUrl/expenses',
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));

      if (response.statusCode == 201) {
        return {'message': 'Expenses added successfully'};
      } else {
        return {'error': response.data['error'] ?? 'Unknown error occurred'};
      }
    } catch (e) {
      throw Exception('Failed to add expense: $e');
    }
  }
}
