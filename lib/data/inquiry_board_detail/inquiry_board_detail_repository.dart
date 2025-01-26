import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/free_board_detail/free_board_detail_model.dart';
import 'package:mindsight_admin_page/data/inquiry_board_detail/inquiry_board_detail_model.dart';

class InquiryBoardDetailRepository extends BaseRepository {
  Future<InquiryBoardDetailModel> get(String id) async {
    // req
    String endpoint = "inquiry-board/$id";
    Response response = await httpClient.getRequest(endpoint);

    // result
    InquiryBoardDetailModel model = fetchJsonData<InquiryBoardDetailModel>(
        response, InquiryBoardDetailModel.fromJson);

    return model;
  }
}
