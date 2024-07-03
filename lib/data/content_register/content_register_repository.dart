import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/content_register/content_register_model.dart';

class ContentRegisterRepository extends BaseRepository {
  Future<ContentRegisterModel> post(Map<String, dynamic> body) async {
    // req
    String endpoint = "contents";
    Response response = await httpClient.post(endpoint, body);

    // result
    ContentRegisterModel model = fetchJsonData<ContentRegisterModel>(
        response, ContentRegisterModel.fromJson);

    return model;
  }
}
