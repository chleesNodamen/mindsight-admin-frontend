import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/practices_data/practices_data_model.dart';
import 'package:mindsight_admin_page/data/practices_data/practices_data_req_post.dart';

class PracticesDataRepository extends BaseRepository {
  Future<PracticesDataModel> post(PracticesDataReqPost dto) async {
    // req
    String endpoint = "contents/practices";
    Response response =
        await httpClient.postRequest(endpoint, body: dto.toJson());

    // result
    PracticesDataModel model = fetchJsonData<PracticesDataModel>(
        response, PracticesDataModel.fromJson);

    return model;
  }
}
