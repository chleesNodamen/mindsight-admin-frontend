import 'package:flutter/foundation.dart';

class Logger {
  static void info(dynamic data) {
    if (kDebugMode) {
      // 녹색
      print('\x1B[32m$data\x1B[0m');
    }
  }

  static void warning(dynamic data) {
    if (kDebugMode) {
      // 노란색
      print('\x1B[33m$data\x1B[0m');
    }
  }

  static void error(dynamic data) {
    if (kDebugMode) {
      // 빨간색
      print('\x1B[31m$data\x1B[0m');
    }
  }

  static void log(dynamic data) {
    if (kDebugMode) {
      // 기본, 파란색
      print("$data");
    }
  }
}
