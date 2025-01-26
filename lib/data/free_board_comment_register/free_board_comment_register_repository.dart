// lib/data/company_register/company_register_repository.dart

import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/free_board_comment_register/free_board_comment_register_req_post.dart';

class FreeBoardCommentRegisterRepository extends BaseRepository {
  Future<BaseModel> post(String id, FreeBoardCommentRegisterReqPost dto) async {
    // req
    String endpoint = "free-board/$id/comment";
    Response response =
        await httpClient.postRequest(endpoint, body: dto.toJson());

    // result
    BaseModel model = fetchJsonData<BaseModel>(response, BaseModel.fromJson);

    return model;
  }
}
