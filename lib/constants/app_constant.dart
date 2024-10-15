import 'package:mindsight_admin_page/routes/app_routes.dart';

class AppConstant {
  static String version = "1.0.6";
  static String apiServer = "https://dev.mindsight.im/api/v1/admin/";
  // static String apiServer = "http://localhost:8080/api/v1/admin/";

  // static const String initialRoute = AppRoutes.bottomNavi;
  static const String initialRoute = AppRoutes.auth;

  // 테스트 용
  static bool chleesTest = true;
  static String chleesTestEmail = "admin@mindsight.com";
  static String chleesTestPassword = "1234";
  static bool clearPref = false;
}
