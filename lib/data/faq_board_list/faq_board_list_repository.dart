// lib/data/company_manage/company_repository.dart

import 'package:http/http.dart' as http;
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/faq_board_list/faq_board_list_model.dart';
import 'package:mindsight_admin_page/data/faq_board_list/faq_board_list_req_get.dart';

class FAQBoardListRepository extends BaseRepository {
  Future<FAQBoardListModel> get(FAQBoardListReqGet dto) async {
    // req
    String endpoint = "faq-board";
    http.Response response =
        await httpClient.getRequest(endpoint, query: dto.toJson());

    // result
    FAQBoardListModel model =
        fetchJsonData<FAQBoardListModel>(response, FAQBoardListModel.fromJson);

    model.length = model.id?.length ?? model.length;

    return model;
  }
}
