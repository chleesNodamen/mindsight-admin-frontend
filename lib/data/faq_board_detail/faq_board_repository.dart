import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/faq_board_detail/faq_board_model.dart';

class FAQBoardDetailRepository extends BaseRepository {
  Future<FAQBoardDetailModel> get(String id) async {
    // req
    String endpoint = "faq-board/$id";
    Response response = await httpClient.getRequest(endpoint);

    // result
    FAQBoardDetailModel model = fetchJsonData<FAQBoardDetailModel>(
        response, FAQBoardDetailModel.fromJson);

    return model;
  }
}
