import 'package:dio/dio.dart';
import 'package:expensetracker/services/api_service_user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class UserController extends GetxController {
  var userProfile = {}.obs;

  void setUserProfile(Map<String, dynamic> profile) {
    userProfile.value = profile;
  }
}
