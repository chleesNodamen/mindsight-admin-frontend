import 'package:mindsight_admin_page/app_export.dart';
import 'base_model.dart';

class BaseRepository {
  final CustomHttpClient httpClient = Get.find<CustomHttpClient>();

  T fetchJsonData<T extends BaseModel>(
      Response response, T Function(Map<String, dynamic>) fromJson) {
    T model;

    try {
      if (response.isOk) {
        model = fromJson(response.body ?? {});
      } else {
        model = fromJson({});
      }

      model.handleStatus(
          isOk: response.isOk,
          errorCode: _getErrorCode(response),
          data: response.body);
    } catch (e) {
      Logger.log("------------------ Repository 익셉션 ${toString()}");

      model = fromJson({});
      model.handleStatus(isOk: response.isOk, data: response.body);
    }

    _handleLog(response);
    return model;
  }

  T fetchListJsonData<T extends BaseModel>(
      Response response, T Function(List<dynamic>) fromJson) {
    T model;

    try {
      if (response.isOk) {
        List<dynamic> list = response.body as List;
        model = fromJson(list);
      } else {
        model = fromJson([]);
      }

      model.handleStatus(
          isOk: response.isOk,
          errorCode: _getErrorCode(response),
          data: response.body);
    } catch (e) {
      Logger.log("------------------ Repository 익셉션 ${toString()}");

      model = fromJson([]);
      model.handleStatus(isOk: response.isOk, data: response.body);
    }

    _handleLog(response);
    return model;
  }

  void _handleLog(Response response) {
    httpClient.forTest2 = "Api response body: ${response.body.toString()}";
    Logger.log(httpClient.forTest2);

    // 임시 테스트

    if (!response.isOk) {
      _showExceptionDialog(response.statusCode, response.body.toString());
    }
  }

  String _getErrorCode(Response response) {
    String errorCode = "";

    if (response.body is Map) {
      var message = response.body?["message"];
      if (message is Map) {
        errorCode = message["errorCode"] ?? "";
      }
    }

    return errorCode;
  }

  String addGetParam(Map<String, dynamic>? query) {
    String add = "";

    query?.forEach((key, value) {
      if (value is List) {
        if (value.isEmpty) {
          return;
        }
        for (int i = 0; i < value.length; i++) {
          add += "$key=${value[i]}&";
        }
      } else if (value == null || value == "null" || value == "[]") {
        return;
      } else {
        add += "$key=$value&";
      }
    });

    Logger.log(add);

    return add;
  }

  // 임시 테스트 창
  void _showExceptionDialog(int? statusCode, dynamic message) {
    // return;
    Get.defaultDialog(
      title: "[TEST] Exception", // 다이얼로그 제목
      titleStyle: CustomTextStyles.titleLargeBlack,
      titlePadding: EdgeInsets.only(top: 20.h),
      content: Column(
        children: [
          Text(
            httpClient.forTest0,
            style: CustomTextStyles.bodyMediumBlack,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20.v,
          ),
          Text(
            httpClient.forTest1,
            style: CustomTextStyles.bodyMediumBlack,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20.v,
          ),
          Text(
            httpClient.forTest2,
            style: CustomTextStyles.bodyMediumBlack,
            textAlign: TextAlign.center,
          ),
        ],
      ), // 다이얼로그 내용
      contentPadding:
          EdgeInsets.only(top: 10.v, left: 20.h, right: 20.h, bottom: 20.v),
      // textConfirm: "Send email",
      textCancel: "Ok",
      buttonColor: Colors.blue, // 확인 및 취소 버튼 배경색
      cancelTextColor: Colors.black, // 취소 버튼 텍스트 색상
    );
  }
}
