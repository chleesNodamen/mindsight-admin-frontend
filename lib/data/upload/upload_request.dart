import 'package:get/get.dart';
import 'dart:html';
import 'dart:typed_data';
import 'package:mindsight_admin_page/data/base_repository.dart';

class UploadRepository extends BaseRepository {
  Future<String> uploadFile(File file, String endpoint) async {
    final reader = FileReader();
    reader.readAsArrayBuffer(file);
    await reader.onLoadEnd.first;

    Uint8List fileBytes = reader.result as Uint8List;
    final formData = FormData({
      'file': MultipartFile(fileBytes,
          filename: file.name, contentType: 'application/octet-stream')
    });

    Response response =
        await httpClient.post<Map<String, dynamic>>(endpoint, formData);

    if (response.statusCode == 200 && response.body != null) {
      return response.body!['url'];
    } else {
      return "";
    }
  }
}
