import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/practices_data/practices_data_model.dart';

class PracticesDataRepository extends BaseRepository {
  Future<PracticesDataModel> post(Map<String, dynamic> body) async {
    // req
    String endpoint = "contents/practices";
    Response response = await httpClient.post(endpoint, body);

    // result
    PracticesDataModel model = fetchJsonData<PracticesDataModel>(
        response, PracticesDataModel.fromJson);

    return model;
  }
}
