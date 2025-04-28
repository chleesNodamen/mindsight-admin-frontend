import 'package:firebase_auth/firebase_auth.dart';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/enum/account_role.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  static Future<void> signInSuccess(String signInId, String signInEmail,
      String password, bool isThirdParty) async {
    id = signInId;
    email = signInEmail;
    signinTime = DateTime.now().toString();
    _isLogined = true;

    await PrefUtils.to.setSigninId(signInEmail);
    await PrefUtils.to.setSigninPassword(password);
    await PrefUtils.to.setSigninIsThirdPart(isThirdParty);

    if (isAdminCompareEmail(email)) {
      role = AccountRole.admin;
    } else {
      role = AccountRole.master;
    }
  }

  static Future<void> signInClear() async {
    await PrefUtils.to.setSigninId("");
    await PrefUtils.to.setSigninPassword("");

    _isLogined = false;

    try {
      // ✅ Firebase 인증 로그아웃
      await FirebaseAuth.instance.signOut();

      // ✅ Google 로그아웃 (GoogleSignIn 사용)
      final googleSignIn = GoogleSignIn();
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.signOut();
        await googleSignIn.disconnect();
      }

      Logger.log('로그아웃 성공');
    } catch (e) {
      Logger.log('로그아웃 실패: $e');
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
