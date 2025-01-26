import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/free_board_detail/free_board_detail_model.dart';

class FreeBoardDetailRepository extends BaseRepository {
  Future<FreeBoardDetailModel> get(String id) async {
    // req
    String endpoint = "free-board/$id";
    Response response = await httpClient.getRequest(endpoint);

    // result
    FreeBoardDetailModel model = fetchJsonData<FreeBoardDetailModel>(
        response, FreeBoardDetailModel.fromJson);

    return model;
  }
}
