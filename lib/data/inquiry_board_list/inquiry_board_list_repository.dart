// lib/data/company_manage/company_repository.dart

import 'package:http/http.dart' as http;
import 'package:mindsight_admin_page/constants/account_constant.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/inquiry_board_list/inquiry_board_list_model.dart';
import 'package:mindsight_admin_page/data/inquiry_board_list/inquiry_board_list_req_get.dart';

class InquiryBoardListRepository extends BaseRepository {
  Future<InquiryBoardListModel> get(InquiryBoardListReqGet dto) async {
    if (!Account.isAdmin) {
      dto.masterId = Account.id;
    }

    // req
    String endpoint = "inquiry-board";
    http.Response response =
        await httpClient.getRequest(endpoint, query: dto.toJson());

    // result
    InquiryBoardListModel model = fetchJsonData<InquiryBoardListModel>(
        response, InquiryBoardListModel.fromJson);

    model.length = model.id?.length ?? model.length;

    return model;
  }
}
