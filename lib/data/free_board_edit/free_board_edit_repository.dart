import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/free_board_edit/free_board_edit_req_put.dart';

class FreeBoardEditRepository extends BaseRepository {
  Future<BaseModel> put(String id, FreeBoardEditReqPut dto) async {
    // req
    String endpoint = "free-board/$id";
    Response response =
        await httpClient.putRequest(endpoint, body: dto.toJson());

    // result
    BaseModel model = fetchJsonData<BaseModel>(response, BaseModel.fromJson);

    return model;
  }
}
