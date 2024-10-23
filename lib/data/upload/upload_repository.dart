import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:mindsight_admin_page/constants/app_constant.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/utils/logger.dart';
import 'package:universal_html/html.dart';

class UploadRepository extends BaseRepository {
  Future<String> uploadFile(File file) async {
    final reader = FileReader();
    reader.readAsArrayBuffer(file);
    await reader.onLoadEnd.first;

    Uint8List fileBytes = reader.result as Uint8List;
    String fileName = file.name;

    final uri = Uri.parse('${httpClient.baseUrl}upload');
    final request = http.MultipartRequest('POST', uri)
      ..files.add(http.MultipartFile.fromBytes(
        'file',
        fileBytes,
        filename: fileName,
        // contentType: http.MediaType('application', 'octet-stream'),
      ));

    if (AppConstant.showHttpLog) {
      Logger.log('Uploading file to $uri');
      Logger.log('File name: $fileName');
    }

    try {
      final streamedResponse = await httpClient.client.send(request);
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseBody = jsonDecode(response.body);
        return responseBody['url'] ?? '';
      } else {
        Logger.log('Upload failed with status: ${response.statusCode}');
        return '';
      }
    } catch (e) {
      Logger.log('Upload failed: $e');
      return '';
    }
  }
}

// import 'package:get/get.dart';
// // ignore: avoid_web_libraries_in_flutter
// import 'dart:html';
// import 'dart:typed_data';
// import 'package:mindsight_admin_page/data/base_repository.dart';

// class UploadRepository extends BaseRepository {
//   Future<String> uploadFile(File file) async {
//     final reader = FileReader();
//     reader.readAsArrayBuffer(file);
//     await reader.onLoadEnd.first;

    // Uint8List fileBytes = reader.result as Uint8List;
    // final formData = FormData({
    //   // 'folder': 'body',
    //   'file': MultipartFile(fileBytes,
    //       filename: file.name, contentType: 'application/octet-stream')
    // });

    // String endpoint = "upload";
    // Response response =
    //     await httpClient.post<Map<String, dynamic>>(endpoint, formData);

//     if (response.isOk) {
//       return response.body['url'];
//     } else {
//       return "";
//     }
//   }
// }
