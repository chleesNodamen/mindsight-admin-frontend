import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:mindsight_admin_page/constants/app_constant.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/upload/upload_model.dart';
import 'package:mindsight_admin_page/utils/logger.dart';
import 'package:universal_html/html.dart';

class UploadRepository extends BaseRepository {
  // 공통 업로드 요청 처리 함수
  Future<UploadModel> _sendMultipartRequest({
    required String endpoint,
    required String fileName,
    required Uint8List fileBytes,
    bool isVideo = false,
  }) async {
    final uri = Uri.parse('${httpClient.baseUrl}$endpoint');
    final request = http.MultipartRequest('POST', uri)
      ..files.add(http.MultipartFile.fromBytes(
        'file',
        fileBytes,
        filename: fileName,
      ));

    if (AppConstant.showHttpLog) {
      Logger.info(
          'Uploading ${isVideo ? "video" : "file"} to $uri, File name: $fileName');
    }

    try {
      final streamedResponse = await httpClient.client.send(request);
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final responseBody = jsonDecode(response.body);
        Logger.log(
            '${isVideo ? "Video" : "File"} upload success: ${response.statusCode}');
        return UploadModel.fromJson(responseBody);
      } else {
        Logger.log(
            '${isVideo ? "Video" : "File"} upload failed with status: ${response.statusCode}');
        return UploadModel.fromJson({});
      }
    } catch (e) {
      Logger.log('${isVideo ? "Video" : "File"} upload failed: $e');
      return UploadModel.fromJson({});
    }
  }

  Future<UploadModel> uploadFile(File file, {String? blobName}) async {
    final reader = FileReader();
    reader.readAsArrayBuffer(file);
    await reader.onLoadEnd.first;

    Uint8List fileBytes = reader.result as Uint8List;
    return await _sendMultipartRequest(
      endpoint: 'upload',
      fileName: blobName ?? file.name,
      fileBytes: fileBytes,
      isVideo: false,
    );
  }

  // Future<UploadModel> uploadVideoFile(File file,
  //     {required String blobName}) async {
  //   final reader = FileReader();
  //   reader.readAsArrayBuffer(file);
  //   await reader.onLoadEnd.first;

  //   Uint8List fileBytes = reader.result as Uint8List;
  //   return await _sendMultipartRequest(
  //     endpoint: 'upload/media',
  //     fileName: blobName,
  //     fileBytes: fileBytes,
  //     isVideo: true,
  //   );
  // }

  Future<bool> uploadWithProgress({
    required File file,
    required String endpoint,
    required String fileName,
    required void Function(double progress) onProgress,
  }) {
    final completer = Completer<bool>();
    final reader = FileReader();
    reader.readAsArrayBuffer(file);
    reader.onLoadEnd.listen((_) {
      final blob = Blob([reader.result!], file.type);
      final xhr = HttpRequest();
      xhr.open('POST', '${httpClient.baseUrl}$endpoint');
      final form = FormData()..appendBlob('file', blob, fileName);

      // 진행률 리스너
      xhr.upload.onProgress.listen((e) {
        if (e.lengthComputable) {
          onProgress(e.loaded! / e.total!);
        }
      });

      // 완료 시점에 completer 완료
      xhr.onLoadEnd.listen((e) {
        final success = xhr.status == 200 || xhr.status == 201;
        completer.complete(success);
      });

      xhr.send(form);
    });

    return completer.future;
  }
}
