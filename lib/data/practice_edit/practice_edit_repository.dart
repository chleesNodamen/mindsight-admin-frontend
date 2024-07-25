import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/practice_edit/practice_edit_model.dart';

class PracticeEditRepository extends BaseRepository {
  Future<PracticeEditModel> put(String? id, Map<String, dynamic> body) async {
    // req
    String endpoint = "contents/practices/$id";
    Response response = await httpClient.put(endpoint, body);

    // result
    PracticeEditModel model =
        fetchJsonData<PracticeEditModel>(response, PracticeEditModel.fromJson);

    return model;
  }
}
