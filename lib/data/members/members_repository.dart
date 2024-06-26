import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/members/members_model.dart';

class MembersRepository extends BaseRepository {
  Future<MembersModel> get(Map<String, dynamic>? query) async {
    Logger.log(query.toString());
    // req
    String endpoint = "members";
    endpoint += addGetParam(query);
    Response response = await httpClient.get(endpoint);

    // result
    MembersModel model =
        fetchJsonData<MembersModel>(response, MembersModel.fromJson);
    model.length = model.id?.length ?? model.length;

    return model;
  }
}
