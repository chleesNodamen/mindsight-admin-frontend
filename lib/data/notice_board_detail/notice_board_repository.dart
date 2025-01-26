import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/notice_board_detail/notice_board_model.dart';

class NoticeBoardDetailRepository extends BaseRepository {
  Future<NoticeBoardDetailModel> get(String id) async {
    // req
    String endpoint = "notice-board/$id";
    Response response = await httpClient.getRequest(endpoint);

    // result
    NoticeBoardDetailModel model = fetchJsonData<NoticeBoardDetailModel>(
        response, NoticeBoardDetailModel.fromJson);

    return model;
  }
}
