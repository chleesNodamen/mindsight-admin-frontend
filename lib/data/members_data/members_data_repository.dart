import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/members_data/members_data_model.dart';

class MembersDataRepository extends BaseRepository {
  Future<MembersDataModel> get(String id) async {
    // req
    String endpoint = "members/$id";
    Response response = await httpClient.get(endpoint);

    // result
    MembersDataModel model =
        fetchJsonData<MembersDataModel>(response, MembersDataModel.fromJson);

    return model;
  }
}
