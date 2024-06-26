import 'package:mindsight_admin_page/routes/app_routes.dart';

class AppConstant {
  static bool isProdServer = true;
  static String version = "1.0.6";
  // static const String initialRoute = AppRoutes.bottomNavi;
  static const String initialRoute = AppRoutes.auth;

  // 테스트 용
  static bool chleesTest = false;
  // static String chleesTestEmail = "test@gmail.com";
  // static String chleesTestPassword = "123";
  // static String chleesTestEmail = "chlee@nodamen.com";
  static String chleesTestEmail = "hundrill@naver.com";
  static String chleesTestPassword = "1111aaaaA!";
  static bool clearPref = false;
}
