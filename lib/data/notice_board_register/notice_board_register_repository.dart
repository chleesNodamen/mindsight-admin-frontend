// lib/data/company_register/company_register_repository.dart

import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/notice_board_register/notice_board_register_req_post.dart';

class NoticeBoardRegisterRepository extends BaseRepository {
  Future<BaseModel> post(NoticeBoardRegisterReqPost dto) async {
    // req
    String endpoint = "notice-board";
    Response response =
        await httpClient.postRequest(endpoint, body: dto.toJson());

    // result
    BaseModel model = fetchJsonData<BaseModel>(response, BaseModel.fromJson);

    return model;
  }
}
