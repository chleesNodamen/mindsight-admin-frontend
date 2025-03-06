import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:mindsight_admin_page/constants/app_constant.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/upload/upload_model.dart';
import 'package:mindsight_admin_page/utils/logger.dart';
import 'package:universal_html/html.dart';

class UploadRepository extends BaseRepository {
  Future<UploadModel> uploadFileBytes(String blobName, Uint8List fileBytes,
      {String? folder}) async {
    final uri = Uri.parse('${httpClient.baseUrl}upload');
    final request = http.MultipartRequest('POST', uri)
      ..files.add(http.MultipartFile.fromBytes(
        'file',
        fileBytes,
        filename: blobName,
        // contentType: http.MediaType('application', 'octet-stream'),
      ));

    if (folder != null) {
      request.fields['folder'] = folder;
    }

    if (AppConstant.showHttpLog) {
      Logger.info('Uploading file to $uri, File name: $blobName');
    }

    try {
      final streamedResponse = await httpClient.client.send(request);
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseBody = jsonDecode(response.body);

        Logger.log('Upload success: ${response.statusCode}');

        return UploadModel.fromJson(responseBody);
      } else {
        Logger.log('Upload failed with status: ${response.statusCode}');
        return UploadModel.fromJson({});
      }
    } catch (e) {
      Logger.log('Upload failed: $e');
      return UploadModel.fromJson({});
    }
  }

  Future<UploadModel> uploadFile(File file, {String? blobName}) async {
    final reader = FileReader();
    reader.readAsArrayBuffer(file);
    await reader.onLoadEnd.first;

    Uint8List fileBytes = reader.result as Uint8List;

    return await uploadFileBytes(blobName ?? file.name, fileBytes);
  }
}
