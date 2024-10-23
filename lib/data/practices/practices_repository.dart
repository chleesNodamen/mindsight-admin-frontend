import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/practices/practices_model.dart';
import 'package:mindsight_admin_page/data/practices/practices_req_get.dart';

class PracticesRepository extends BaseRepository {
  Future<PracticesModel> get(PracticesReqGet dto) async {
    // Logger.log(query.toString());
    // req
    String endpoint = "contents/practices";
    // endpoint += addGetParam(query);
    Response response =
        await httpClient.getRequest(endpoint, query: dto.toJson());

    // result
    PracticesModel model =
        fetchJsonData<PracticesModel>(response, PracticesModel.fromJson);
    model.length = model.id?.length ?? model.length;

    return model;
  }
}
