import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/inquiry_board_edit/inquiry_board_edit_req_put.dart';

class InquiryBoardEditRepository extends BaseRepository {
  Future<BaseModel> put(String id, InquiryBoardEditReqPut dto) async {
    // req
    String endpoint = "inquiry-board/$id";
    Response response =
        await httpClient.putRequest(endpoint, body: dto.toJson());

    // result
    BaseModel model = fetchJsonData<BaseModel>(response, BaseModel.fromJson);

    return model;
  }
}
