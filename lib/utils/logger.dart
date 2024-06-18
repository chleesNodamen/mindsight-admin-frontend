class Logger {
  static LogMode _logMode = LogMode.debug;

  static void init(LogMode mode) {
    Logger._logMode = mode;
  }

  // static void log(dynamic data, {StackTrace? stackTrace}) {
  //   if (_logMode == LogMode.debug) {
  //     print("Error: $data$stackTrace");
  //   }
  // }

  static void log(dynamic data) {
    if (_logMode == LogMode.debug) {
      // ignore: avoid_print
      print("$data");
    }
  }
}

enum LogMode { debug, live }
