import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/faq_board_edit/faq_board_edit_req_put.dart';

class FAQBoardEditRepository extends BaseRepository {
  Future<BaseModel> put(String id, FAQBoardEditReqPut dto) async {
    // req
    String endpoint = "faq-board/$id";
    Response response =
        await httpClient.putRequest(endpoint, body: dto.toJson());

    // result
    BaseModel model = fetchJsonData<BaseModel>(response, BaseModel.fromJson);

    return model;
  }
}
