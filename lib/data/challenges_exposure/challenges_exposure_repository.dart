import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/challenges_exposure/challenges_exposure_req_put.dart';

class ChallengesExposureRepository extends BaseRepository {
  Future<BaseModel> put(ChallengesExposureReqPut dto) async {
    // req
    String endpoint = "contents/challenge-exposure";
    Response response =
        await httpClient.putRequest(endpoint, body: dto.toJson());

    // result
    BaseModel model = fetchJsonData<BaseModel>(response, BaseModel.fromJson);

    return model;
  }
}
