// lib/data/company_manage/company_repository.dart

import 'package:http/http.dart' as http;
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/notice_board_list/notice_board_list_model.dart';
import 'package:mindsight_admin_page/data/notice_board_list/notice_board_list_req_get.dart';

class NoticeBoardListRepository extends BaseRepository {
  Future<NoticeBoardListModel> get(NoticeBoardListReqGet dto) async {
    // req
    String endpoint = "notice-board";
    http.Response response =
        await httpClient.getRequest(endpoint, query: dto.toJson());

    // result
    NoticeBoardListModel model = fetchJsonData<NoticeBoardListModel>(
        response, NoticeBoardListModel.fromJson);

    model.length = model.id?.length ?? model.length;

    return model;
  }
}
