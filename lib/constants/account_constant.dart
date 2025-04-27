import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/enum/account_role.dart';

class Account {
  static AccountRole role = AccountRole.master;
  static String email = "";
  static String signinTime = "";
  static String id = "";
  static bool _isLogined = false;

  static bool get isLogined {
    return _isLogined;
  }

  static bool get isAdmin {
    return role == AccountRole.admin;
  }

  static bool get isAdminWithMsg {
    bool result = isAdmin;

    if (!result) {
      showSimpleMessage("Permission이 없습니다");
    }

    return result;
  }

  static bool isMasterWithMsg(String compareEmail) {
    if (isMaster(compareEmail)) {
      return true;
    }

    showSimpleMessage("Permission이 없습니다");
    return false;
  }

  static bool isMaster(String compareEmail) {
    if (isAdmin) {
      return true;
    }
    if (email == compareEmail) {
      return true;
    }
    return false;
  }

  static void signOutSuccess() {
    _isLogined = false;
  }

  static void signInSuccess(String signInId, String signInEmail) {
    id = signInId;
    email = signInEmail;
    signinTime = DateTime.now().toString();
    _isLogined = true;

    if (isAdminCompareEmail(email)) {
      role = AccountRole.admin;
    } else {
      role = AccountRole.master;
    }
  }

  static bool isAdminCompareEmail(String compareEmail) {
    if (compareEmail == "mindsight@nodamen.com" ||
        compareEmail == "won@nodamen.com") {
      return true;
    }
    return false;
  }
}
