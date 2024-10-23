import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/content_register/content_register_model.dart';
import 'package:mindsight_admin_page/data/content_register/content_register_req_post.dart';

class ContentRegisterRepository extends BaseRepository {
  Future<ContentRegisterModel> post(ContentRegisterReqPost dto) async {
    // req
    String endpoint = "contents";
    Response response =
        await httpClient.postRequest(endpoint, body: dto.toJson());

    // result
    ContentRegisterModel model = fetchJsonData<ContentRegisterModel>(
        response, ContentRegisterModel.fromJson);

    return model;
  }
}
