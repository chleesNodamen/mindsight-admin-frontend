import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/members_detail/members_detail_model.dart';

class MembersDetailRepository extends BaseRepository {
  Future<MembersDetailModel> get(String id) async {
    // req
    String endpoint = "members/$id";
    Response response = await httpClient.getRequest(endpoint);

    // result
    MembersDetailModel model = fetchJsonData<MembersDetailModel>(
        response, MembersDetailModel.fromJson);

    return model;
  }
}
