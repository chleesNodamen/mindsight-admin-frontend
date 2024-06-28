import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/members_edit/members_edit_model.dart';

class MembersEditRepository extends BaseRepository {
  Future<MembersEditModel> put(String id, Map<String, dynamic> body) async {
    // req
    String endpoint = "members/$id";
    Response response = await httpClient.put(endpoint, body);

    // result
    MembersEditModel model =
        fetchJsonData<MembersEditModel>(response, MembersEditModel.fromJson);

    return model;
  }
}
