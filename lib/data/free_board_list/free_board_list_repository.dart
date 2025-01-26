// lib/data/company_manage/company_repository.dart

import 'package:http/http.dart' as http;
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/free_board_list/free_board_list_model.dart';
import 'package:mindsight_admin_page/data/free_board_list/free_board_list_req_get.dart';

class FreeBoardListRepository extends BaseRepository {
  Future<FreeBoardListModel> get(FreeBoardListReqGet dto) async {
    // req
    String endpoint = "free-board";
    http.Response response =
        await httpClient.getRequest(endpoint, query: dto.toJson());

    // result
    FreeBoardListModel model = fetchJsonData<FreeBoardListModel>(
        response, FreeBoardListModel.fromJson);

    model.length = model.id?.length ?? model.length;

    return model;
  }
}
