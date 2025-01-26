import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';

class FreeBoardDeleteRepository extends BaseRepository {
  Future<BaseModel> delete(String id) async {
    // req
    String endpoint = "free-board/$id";
    Response response = await httpClient.deleteRequest(endpoint);

    // result
    BaseModel model = fetchJsonData<BaseModel>(response, BaseModel.fromJson);

    return model;
  }
}
