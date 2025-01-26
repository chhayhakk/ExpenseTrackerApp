import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:expensetracker/utils/api_config.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../screens/signin.dart';

class ApiServiceUser {
  final Dio _dio;
  ApiServiceUser(this._dio) {
    _dio.options.validateStatus = (status) {
      return status! < 500;
    };
  }
  String get baseUrl => ApiConfig.getBaseUrl();
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  Future<Map<String, dynamic>> signup(
      String username, String email, String password) async {
    try {
      final response = await _dio.post('$baseUrl/signup', data: {
        'username': username,
        'email': email,
        'password': password,
      });

      if (response.statusCode == 201) {
        print("User registered successfully");
        if (response.data is String) {
          return {'message': response.data};
        }
        return {'message': 'User registered successfully'};
      } else {
        return {'error': response.data['error'] ?? 'Unknown error occurred'};
      }
    } catch (e) {
      throw Exception('Fail to sign up: $e');
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _dio.post('$baseUrl/login', data: {
        'email': email,
        'password': password,
      });
      if (response.statusCode == 200) {
        final token = response.data['token'];
        final refreshToken = response.data['refreshToken'];

        await secureStorage.write(key: 'token', value: token);
        await secureStorage.write(key: 'refreshToken', value: refreshToken);
        return response.data;
      } else {
        throw Exception('Failed to login: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  Future<Map<String, dynamic>> getProfile() async {
    final token = await secureStorage.read(key: 'token');

    if (token == null || JwtDecoder.isExpired(token)) {
      throw Exception('No token available, please login first');
    }
    try {
      final response = await _dio.get('$baseUrl/profile',
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to fetch profile: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching profile: $e');
    }
  }

  Future<bool> isLoggedIn() async {
    try {
      String? token = await secureStorage.read(key: 'token');
      if (token != null && token.isNotEmpty) {
        bool isExpired = JwtDecoder.isExpired(token);

        if (!isExpired) {
          return true;
        } else {
          String? refreshToken = await secureStorage.read(key: 'refreshToken');
          if (refreshToken != null && refreshToken.isNotEmpty) {
            final refreshedToken = await _refreshToken(refreshToken);
            if (refreshedToken != null) {
              await secureStorage.write(key: 'token', value: refreshedToken);
              return true;
            }
          }
        }
      }
      return false;
    } catch (e) {
      print('Error checking login status: $e');
      return false;
    }
  }

  Future<String?> _refreshToken(String refreshToken) async {
    try {
      final response = await _dio.post(
        '$baseUrl/refresh-token',
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode == 200) {
        return response.data['token'];
      } else {
        print('${response.data['error']}');
        return null;
      }
    } catch (e) {
      print('Error refreshing token: $e');
      return null;
    }
  }

  Future<void> logOut() async {
    try {
      await secureStorage.delete(key: 'token');
    } catch (e) {
      throw Exception('Failed to logout $e');
    }
  }
}
