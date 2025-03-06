import 'package:mindsight_admin_page/app_export.dart';

class BaseModel {
  bool _isOk = false;
  String _errorCode = "";
  String _errorMessage = "";
  int length = 0;

  BaseModel();

  void handleStatus({bool? isOk, String? errorCode, String? errorMessage}) {
    _isOk = isOk ?? false;
    _errorCode = errorCode ?? "";
    _errorMessage = errorMessage ?? "";
  }

  bool get isEmpty {
    if (length <= 0) {
      return true;
    }

    return false;
  }

  bool get isNotEmpty {
    return !isEmpty;
  }

  bool get isSuccess {
    return _isOk;
  }

  String getErrorCode() {
    return _errorCode;
  }

  String getErrorMessage() {
    return _errorMessage;
  }

  bool isErrorCode(String code) {
    if (code == _errorCode) {
      return true;
    }

    return false;
  }

  void testSuccess() {
    Logger.log("Api 테스트로 강제로 성공 시킴: ${toString()}");

    _isOk = true;
  }

  factory BaseModel.fromJson(Map<String, dynamic> json) => BaseModel();
}
