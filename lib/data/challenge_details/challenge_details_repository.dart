import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/challenge_details/challenge_details_model.dart';

class ChallengeDetailsRepository extends BaseRepository {
  Future<ChallengeDetailsModel> get(String id) async {
    // req
    String endpoint = "contents/challenge/$id";
    Response response = await httpClient.getRequest(endpoint);

    // result
    ChallengeDetailsModel model = fetchJsonData<ChallengeDetailsModel>(
        response, ChallengeDetailsModel.fromJson);

    if (model.isSuccess) {
      model.length = model.days?.length ?? 0;
    }
    return model;
  }
}
