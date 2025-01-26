import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/notice_board_edit/notice_board_edit_req_put.dart';

class NoticeBoardEditRepository extends BaseRepository {
  Future<BaseModel> put(String id, NoticeBoardEditReqPut dto) async {
    // req
    String endpoint = "notice-board/$id";
    Response response =
        await httpClient.putRequest(endpoint, body: dto.toJson());

    // result
    BaseModel model = fetchJsonData<BaseModel>(response, BaseModel.fromJson);

    return model;
  }
}
