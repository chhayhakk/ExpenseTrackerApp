import 'dart:io';

class ApiConfig {
  static String getBaseUrl() {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:3000';
    } else if (Platform.isIOS) {
      return 'http://localhost:3000';
    } else {
      return 'http://192.168.136.1:3000'; // This is my network IP Address. You may replace with your machine's IP for testing on physical device;
    }
  }
}
