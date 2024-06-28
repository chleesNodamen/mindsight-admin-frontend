import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/members_status/members_status_model.dart';

class MembersStatusRepository extends BaseRepository {
  Future<MembersStatusModel> put(Map<String, dynamic> body) async {
    // req
    String endpoint = "members/status";
    Response response = await httpClient.put(endpoint, body);

    // result
    MembersStatusModel model = fetchJsonData<MembersStatusModel>(
        response, MembersStatusModel.fromJson);

    return model;
  }
}
