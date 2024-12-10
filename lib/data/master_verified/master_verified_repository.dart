import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/master_verified/master_verified_req_put.dart';

class MasterVerifiedRepository extends BaseRepository {
  Future<BaseModel> put(MasterVerifiedReqPut dto) async {
    // req
    String endpoint = "master/verified";
    Response response =
        await httpClient.putRequest(endpoint, body: dto.toJson());

    // result
    BaseModel model = fetchJsonData<BaseModel>(response, BaseModel.fromJson);

    return model;
  }
}
