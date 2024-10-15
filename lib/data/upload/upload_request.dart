import 'package:get/get.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:typed_data';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/members_edit/members_edit_model.dart';

class UploadRepository extends BaseRepository {
  Future<String> uploadFile(File file, String endpoint) async {
    final reader = FileReader();
    reader.readAsArrayBuffer(file);
    await reader.onLoadEnd.first;

    Uint8List fileBytes = reader.result as Uint8List;
    final formData = FormData({
      'folder': 'body',
      'file': MultipartFile(fileBytes,
          filename: file.name, contentType: 'application/octet-stream')
    });

    Response response =
        await httpClient.post<Map<String, dynamic>>(endpoint, formData);

    if (response.isOk) {
      return response.body['url'];
    } else {
      // ignore: unused_local_variable
      MembersEditModel model =
          fetchJsonData<MembersEditModel>(response, MembersEditModel.fromJson);
      return "";
    }
  }
}
