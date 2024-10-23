import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/practice_details/practice_details_model.dart';

class PracticeDetailsRepository extends BaseRepository {
  Future<PracticeDetailsModel> get(String? id) async {
    // req
    String endpoint = "contents/practices/$id";
    Response response = await httpClient.getRequest(endpoint);

    // result
    PracticeDetailsModel model = fetchJsonData<PracticeDetailsModel>(
        response, PracticeDetailsModel.fromJson);

    return model;
  }
}
