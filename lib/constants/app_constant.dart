import 'package:mindsight_admin_page/constants/enum/account_role.dart';

class AppConstant {
  static String version = "1.0.6";
  // static String apiServer = "https://mindsight.im/api/v1/admin/";
  static String apiServer = "http://localhost:8080/api/v1/admin/";
  // static String apiServer = "https://dev.mindsight.im/api/v1/admin/";

  static bool showHttpLog = true;

  static String defaultEmail = "mindsight@nodamen.com";
  static String defaultPassword = "1111";

  // 테스트 용
  static bool test = false;
  static String testEmail = "hundrill@naver.com";
  static String testPassword = "1111";
  static bool testClearPref = false;

  static AccountRole accountRole = AccountRole.master;
}
