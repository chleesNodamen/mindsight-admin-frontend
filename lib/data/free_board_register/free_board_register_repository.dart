// lib/data/company_register/company_register_repository.dart

import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/free_board_register/free_board_register_req_post.dart';

class FreeBoardRegisterRepository extends BaseRepository {
  Future<BaseModel> post(FreeBoardRegisterReqPost dto) async {
    // req
    String endpoint = "free-board";
    Response response =
        await httpClient.postRequest(endpoint, body: dto.toJson());

    // result
    BaseModel model = fetchJsonData<BaseModel>(response, BaseModel.fromJson);

    return model;
  }
}
