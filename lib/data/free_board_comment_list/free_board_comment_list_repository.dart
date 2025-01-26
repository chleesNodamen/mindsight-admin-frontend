// lib/data/company_manage/company_repository.dart

import 'package:http/http.dart' as http;
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/free_board_comment_list/free_board_comment_list_model.dart';
import 'package:mindsight_admin_page/data/free_board_comment_list/free_board_comment_list_req_get.dart';

class FreeBoardCommentListRepository extends BaseRepository {
  Future<FreeBoardCommentListModel> get(
      String id, FreeBoardCommentListReqGet dto) async {
    // req
    String endpoint = "free-board/$id/comments";
    http.Response response =
        await httpClient.getRequest(endpoint, query: dto.toJson());

    // result
    FreeBoardCommentListModel model = fetchJsonData<FreeBoardCommentListModel>(
        response, FreeBoardCommentListModel.fromJson);

    model.length = model.comments?.length ?? model.length;

    return model;
  }
}
