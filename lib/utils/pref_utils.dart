import 'package:mindsight_admin_page/app_export.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefUtils {
  static PrefUtils get to => Get.find<PrefUtils>();
  SharedPreferences? _sharedPreferences;

  PrefUtils() {
    SharedPreferences.getInstance().then((value) {
      _sharedPreferences = value;
      Logger.info('PrefUtils: SharedPreference Initialized');

      if (AppConstant.testClearPref) {
        clearPreferencesData();
      }
    });
  }

  bool isInited() {
    if (_sharedPreferences == null) {
      return false;
    }

    return true;
  }

  void clearPreferencesData() async {
    try {
      _sharedPreferences!.clear();
    } catch (e) {
      Logger.log("익셉션: clearPreferencesData");
    }
    Logger.log("완료: clearPreferencesData");
  }

  // 유져 정보 저장
  Future<bool> setSigninId(String id) {
    return _sharedPreferences!.setString("SigninId", id);
  }

  Future<bool> setSigninPassword(String password) {
    return _sharedPreferences!.setString("SigninPassword", password);
  }

  String getSigninId() {
    try {
      return _sharedPreferences!.getString("SigninId") ?? "";
    } catch (e) {
      Logger.log("익셉션: getSigninId");
      return "";
    }
  }

  String getSigninPassword() {
    try {
      return _sharedPreferences!.getString("SigninPassword") ?? "";
    } catch (e) {
      Logger.log("익셉션: getSigninPassword");
      return "";
    }
  }

  Future<bool> setSigninTime() {
    return _sharedPreferences!
        .setString("SigninTime", DateTime.now().toString());
  }

  String getSigninTime() {
    try {
      return _sharedPreferences!.getString("SigninTime") ?? "";
    } catch (e) {
      Logger.log("익셉션: SigninTime");
      return "";
    }
  }

  Future<bool> setUserName(String userName) {
    return _sharedPreferences!.setString("UserName", userName);
  }

  String getUserName() {
    try {
      return _sharedPreferences!.getString("UserName") ?? "";
    } catch (e) {
      Logger.log("익셉션: UserName");
      return "";
    }
  }

  Future<bool> setIsLogined(bool value) {
    return _sharedPreferences!.setBool("IsLogined", value);
  }
}
