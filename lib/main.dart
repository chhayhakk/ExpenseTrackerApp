import 'package:dio/dio.dart';
import 'package:expensetracker/screens/expense.dart';
import 'package:expensetracker/screens/home.dart';
import 'package:expensetracker/screens/navigation.dart';
import 'package:expensetracker/screens/register.dart';
import 'package:expensetracker/screens/signin.dart';
import 'package:expensetracker/screens/welcomescreen.dart';
import 'package:expensetracker/services/api_service_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  MyApp(this.isLoggedIn);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? Navigation() : Signin(),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ApiServiceUser apiServiceUser = ApiServiceUser(Dio());
  bool isLoggedIn = await apiServiceUser.isLoggedIn();
  await Future.delayed(Duration(seconds: 2));

  runApp(MyApp(isLoggedIn));
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom],
  );
}
