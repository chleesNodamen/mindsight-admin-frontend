import 'package:get/get.dart';
import 'package:mindsight_admin_page/constants/app_constant.dart';
import 'package:mindsight_admin_page/utils/logger.dart';

class CustomHttpClient extends GetConnect {
  final String _baseUrl = AppConstant.apiServer;

  static CustomHttpClient get to => Get.find<CustomHttpClient>();
  String forTest0 = "";
  String forTest1 = "";
  String forTest2 = "";

  @override
  void onInit() {
    super.onInit();

    httpClient
      ..baseUrl = _baseUrl
      ..defaultContentType = 'application/json'
      ..timeout = const Duration(seconds: 10);

    Logger.log('Api: baseUrl 셋팅: ${httpClient.baseUrl}');
  }

  void setBaseUrl(String url) {
    httpClient.baseUrl = url;
  }

  void setBearerAuthorization(String accessToken) {
    Logger.log('Api: setBearerAuthorization: $accessToken');

    httpClient.addRequestModifier<dynamic>((request) {
      request.headers["Authorization"] = "Bearer $accessToken";
      return request;
    });
  }

  @override
  Future<Response<T>> patch<T>(String url, body,
      {String? contentType,
      Map<String, String>? headers,
      Map<String, dynamic>? query,
      Decoder<T>? decoder,
      Progress? uploadProgress}) async {
    Logger.log('Api patch endpoint: ${httpClient.baseUrl}$url');
    Logger.log('Api patch body: ${body.toString()}');

    forTest0 = "patch: ${httpClient.baseUrl}$url";
    forTest1 = "req body: ${body.toString()}";
    forTest2 = "";

    try {
      Response<T> response = await super.patch(url, body,
          contentType: contentType,
          headers: headers,
          query: query,
          decoder: decoder,
          uploadProgress: uploadProgress);

      return response;
    } catch (e) {
      _exceptionHandler(e);
    }
    return Response<T>();
  }

  @override
  Future<Response<T>> put<T>(String url, body,
      {String? contentType,
      Map<String, String>? headers,
      Map<String, dynamic>? query,
      Decoder<T>? decoder,
      Progress? uploadProgress}) async {
    Logger.log('Api put endpoint: ${httpClient.baseUrl}$url');
    Logger.log('Api put body: ${body.toString()}');

    forTest0 = "put: ${httpClient.baseUrl}$url";
    forTest1 = "req body: ${body.toString()}";
    forTest2 = "";

    try {
      Response<T> response = await super.put(url, body,
          contentType: contentType,
          headers: headers,
          query: query,
          decoder: decoder,
          uploadProgress: uploadProgress);

      return response;
    } catch (e) {
      _exceptionHandler(e);
    }
    return Response<T>();
  }

  @override
  Future<Response<T>> post<T>(String? url, body,
      {String? contentType,
      Map<String, String>? headers,
      Map<String, dynamic>? query,
      Decoder<T>? decoder,
      Progress? uploadProgress}) async {
    Logger.log('Api post endpoint: ${httpClient.baseUrl}$url');
    Logger.log('Api post body: ${body.toString()}');

    forTest0 = "post: ${httpClient.baseUrl}$url";
    forTest1 = "req body: ${body.toString()}";
    forTest2 = "";

    try {
      Response<T> response = await super.post(url, body,
          contentType: contentType,
          headers: headers,
          query: query,
          decoder: decoder,
          uploadProgress: uploadProgress);

      return response;
    } catch (e) {
      _exceptionHandler(e);
    }
    return Response<T>();
  }

  @override
  Future<Response<T>> delete<T>(String url,
      {Map<String, String>? headers,
      String? contentType,
      Map<String, dynamic>? query,
      Decoder<T>? decoder}) async {
    Logger.log('Api delete: ${httpClient.baseUrl}$url');

    forTest0 = "get: ${httpClient.baseUrl}$url";
    forTest1 = "";
    forTest2 = "";

    try {
      Response<T> response = await super.delete(url,
          headers: headers,
          contentType: contentType,
          query: query,
          decoder: decoder);

      return response;
    } catch (e) {
      _exceptionHandler(e);
    }

    return Response<T>();
  }

  @override
  Future<Response<T>> get<T>(String url,
      {Map<String, String>? headers,
      String? contentType,
      Map<String, dynamic>? query,
      Decoder<T>? decoder}) async {
    Logger.log('Api get: ${httpClient.baseUrl}$url');
    Logger.log('Api query: ${query?.toString()}');

    forTest0 = "get: ${httpClient.baseUrl}$url";
    forTest1 = "query: ${query?.toString()}";
    forTest2 = "";

    try {
      Response<T> response = await super.get(url,
          headers: headers,
          contentType: contentType,
          query: query,
          decoder: decoder);

      return response;
    } catch (e) {
      _exceptionHandler(e);
    }

    return Response<T>();
  }

  void _exceptionHandler(dynamic e) {
    Logger.log('HttpClient 익셉션: $e');
    Logger.log(e.body.toString());
    Logger.log(e.message.toString());
  }
}
