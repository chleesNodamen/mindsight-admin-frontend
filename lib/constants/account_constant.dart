import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/constants/enum/account_role.dart';

class Account {
  static AccountRole role = AccountRole.master;
  static String email = "";
  static String signinTime = "";
  static String id = "";

  static bool get isAdmin {
    return role == AccountRole.admin;
  }

  static bool get isAdminWithMsg {
    bool result = isAdmin;

    if (!result) {
      showSimpleMessage("권한이 없습니다");
    }

    return result;
  }

  static bool isMasterWithMsg(String compareEmail) {
    if (isAdmin) {
      return true;
    }
    if (email == compareEmail) {
      return true;
    }
    showSimpleMessage("권한이 없습니다");
    return false;
  }

  static void signinSuccess(String signInId, String signInEmail) {
    id = signInId;
    email = signInEmail;
    signinTime = DateTime.now().toString();

    if (email == AppConstant.adminEmail) {
      role = AccountRole.admin;
    } else {
      role = AccountRole.master;
    }
  }
}
