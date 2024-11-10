import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mindsight_admin_page/constants/app_constant.dart';
import 'package:mindsight_admin_page/utils/logger.dart';

class CustomHttpClient {
  final String baseUrl = AppConstant.apiServer;
  final http.Client client;

  // Test variables
  String forTest0 = "";
  String forTest1 = "";
  String forTest2 = "";

  CustomHttpClient({http.Client? c}) : client = c ?? http.Client() {
    Logger.log('Api: baseUrl 설정: $baseUrl');
  }

  // void setBaseUrl(String url) {
  //   // baseUrl은 final이므로 새로운 인스턴스를 생성해야 합니다.
  //   // 또는 baseUrl을 변경 가능한 변수로 변경할 수 있습니다.
  //   throw UnimplementedError('Base URL 변경은 지원되지 않습니다.');
  // }

  void setBearerAuthorization(String accessToken) {
    if (AppConstant.showHttpLog) {
      Logger.log('Api: setBearerAuthorization: $accessToken');
    }
    _headers['Authorization'] = "Bearer $accessToken";
  }

  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
  };

  String _buildQueryString(Map<String, dynamic>? query) {
    if (query == null || query.isEmpty) return '';

    List<String> parts = [];

    query.forEach((key, value) {
      if (value is List) {
        for (var item in value) {
          parts.add(
              '${Uri.encodeQueryComponent(key)}=${Uri.encodeQueryComponent(item.toString())}');
        }
      } else if (value != null) {
        parts.add(
            '${Uri.encodeQueryComponent(key)}=${Uri.encodeQueryComponent(value.toString())}');
      }
    });

    return parts.join('&');
  }

  Future<http.Response> getRequest(
    String endpoint, {
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {
    final queryString = _buildQueryString(query);
    final uri = Uri.parse(
        '$baseUrl$endpoint${queryString.isNotEmpty ? '?$queryString' : ''}');
    if (AppConstant.showHttpLog) {
      Logger.info('Api GET 요청: $uri');
    }

    forTest0 = "get: $uri";
    forTest1 = "query: ${query?.toString()}";
    forTest2 = "";

    try {
      final response =
          await client.get(uri, headers: {..._headers, ...?headers});
      if (AppConstant.showHttpLog) {
        Logger.log('Api GET 응답: ${response.statusCode} ${response.body}');
      }
      return response;
    } catch (e) {
      _exceptionHandler(e);
      rethrow;
    }
  }

  Future<http.Response> postRequest(
    String endpoint, {
    required dynamic body,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
  }) async {
    final uri = Uri.parse('$baseUrl$endpoint').replace(
        queryParameters: query?.map((k, v) => MapEntry(k, v.toString())));
    if (AppConstant.showHttpLog) {
      Logger.info('Api POST 요청: $uri');
      Logger.log('Api POST 바디: ${jsonEncode(body)}');
    }

    forTest0 = "post: $uri";
    forTest1 = "req body: ${jsonEncode(body)}";
    forTest2 = "";

    try {
      final response = await client.post(uri,
          headers: {..._headers, ...?headers}, body: jsonEncode(body));
      if (AppConstant.showHttpLog) {
        Logger.log('Api POST 응답: ${response.body}');
      }
      return response;
    } catch (e) {
      _exceptionHandler(e);
      rethrow;
    }
  }

  Future<http.Response> putRequest(
    String endpoint, {
    required dynamic body,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
  }) async {
    final uri = Uri.parse('$baseUrl$endpoint').replace(
        queryParameters: query?.map((k, v) => MapEntry(k, v.toString())));
    if (AppConstant.showHttpLog) {
      Logger.info('Api PUT 요청: $uri');
      Logger.log('Api PUT 바디: ${jsonEncode(body)}');
    }

    forTest0 = "put: $uri";
    forTest1 = "req body: ${jsonEncode(body)}";
    forTest2 = "";

    try {
      final response = await client.put(uri,
          headers: {..._headers, ...?headers}, body: jsonEncode(body));
      if (AppConstant.showHttpLog) {
        Logger.log('Api PUT 응답: ${response.statusCode} ${response.body}');
      }
      return response;
    } catch (e) {
      _exceptionHandler(e);
      rethrow;
    }
  }

  Future<http.Response> patchRequest(
    String endpoint, {
    required dynamic body,
    Map<String, String>? headers,
    Map<String, dynamic>? query,
  }) async {
    final uri = Uri.parse('$baseUrl$endpoint').replace(
        queryParameters: query?.map((k, v) => MapEntry(k, v.toString())));
    if (AppConstant.showHttpLog) {
      Logger.info('Api PATCH 요청: $uri');
      Logger.log('Api PATCH 바디: ${jsonEncode(body)}');
    }

    forTest0 = "patch: $uri";
    forTest1 = "req body: ${jsonEncode(body)}";
    forTest2 = "";

    try {
      final request = http.Request('PATCH', uri)
        ..headers.addAll({..._headers, ...?headers})
        ..body = jsonEncode(body);
      final streamedResponse = await client.send(request);
      final response = await http.Response.fromStream(streamedResponse);
      if (AppConstant.showHttpLog) {
        Logger.log('Api PATCH 응답: ${response.statusCode} ${response.body}');
      }
      return response;
    } catch (e) {
      _exceptionHandler(e);
      rethrow;
    }
  }

  Future<http.Response> deleteRequest(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? query,
  }) async {
    final uri = Uri.parse('$baseUrl$endpoint').replace(
        queryParameters: query?.map((k, v) => MapEntry(k, v.toString())));
    if (AppConstant.showHttpLog) {
      Logger.info('Api DELETE 요청: $uri');
    }

    forTest0 = "delete: $uri";
    forTest1 = "";
    forTest2 = "";

    try {
      final response =
          await client.delete(uri, headers: {..._headers, ...?headers});
      if (AppConstant.showHttpLog) {
        Logger.log('Api DELETE 응답: ${response.statusCode} ${response.body}');
      }
      return response;
    } catch (e) {
      _exceptionHandler(e);
      rethrow;
    }
  }

  // Map<String, String>? _encodeQueryParameters(Map<String, dynamic>? query) {
  //   if (query == null || query.isEmpty) return null;

  //   Map<String, List<String>> queryParametersAll = {};

  //   query.forEach((key, value) {
  //     if (value is List) {
  //       queryParametersAll[key] = value.map((e) => e.toString()).toList();
  //     } else if (value != null) {
  //       queryParametersAll[key] = [value.toString()];
  //     }
  //   });

  //   // Convert to queryParametersAll format
  //   return queryParametersAll.map((key, values) {
  //     return MapEntry(key, values.join(','));
  //   });
  // }

  void _exceptionHandler(dynamic e) {
    if (e is http.ClientException) {
      Logger.log('HttpClient 예외: ${e.message}');
    } else {
      Logger.log('HttpClient 예외: $e');
    }
  }

  void dispose() {
    client.close();
  }
}

/*
import 'package:get/get.dart';
import 'package:mindsight_admin_page/constants/app_constant.dart';
import 'package:mindsight_admin_page/utils/logger.dart';

class CustomHttpClient extends GetConnect {
  final String baseUrl = AppConstant.apiServer;

  static CustomHttpClient get to => Get.find<CustomHttpClient>();
  String forTest0 = "";
  String forTest1 = "";
  String forTest2 = "";

  @override
  void onInit() {
    super.onInit();

    httpClient
      ..baseUrl = baseUrl
      ..defaultContentType = 'application/json'
      ..timeout = const Duration(seconds: 10);

    Logger.log('Api: baseUrl 셋팅: ${httpClient.baseUrl}');
  }

  void setBaseUrl(String url) {
    httpClient.baseUrl = url;
  }

  void setBearerAuthorization(String accessToken) {
    if (AppConstant.showHttpLog) {
      Logger.log('Api: setBearerAuthorization: $accessToken');
    }

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
    if (AppConstant.showHttpLog) {
      Logger.log('Api patch endpoint: ${httpClient.baseUrl}$url');
      Logger.log('Api patch body: ${body.toString()}');
    }

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

      Logger.log(
          'PATCH Response: ${response.statusCode} ${response.body} ${response.isOk}');

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
    if (AppConstant.showHttpLog) {
      Logger.log('Api put endpoint: ${httpClient.baseUrl}$url');
      Logger.log('Api put body: ${body.toString()}');
    }

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
    if (AppConstant.showHttpLog) {
      Logger.log('Api post endpoint: ${httpClient.baseUrl}$url');
      Logger.log('Api post body: ${body.toString()}');
    }

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
    if (AppConstant.showHttpLog) {
      Logger.log('Api delete: ${httpClient.baseUrl}$url');
    }

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
    if (AppConstant.showHttpLog) {
      Logger.log('Api get: ${httpClient.baseUrl}$url');
      Logger.log('Api query: ${query?.toString()}');
    }

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
*/