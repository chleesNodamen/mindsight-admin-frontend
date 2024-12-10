import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/content_exposure/content_exposure_req_put.dart';

class ContentExposureRepository extends BaseRepository {
  Future<BaseModel> put(ContentExposureReqPut dto) async {
    // req
    String endpoint = "contents/exposure";
    Response response =
        await httpClient.putRequest(endpoint, body: dto.toJson());

    // result
    BaseModel model = fetchJsonData<BaseModel>(response, BaseModel.fromJson);

    return model;
  }
}
