import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/member_detail/member_detail_model.dart';

class MemberDetailRepository extends BaseRepository {
  Future<MemberDetailModel> get(String id) async {
    // req
    String endpoint = "member/$id";
    Response response = await httpClient.getRequest(endpoint);

    // result
    MemberDetailModel model =
        fetchJsonData<MemberDetailModel>(response, MemberDetailModel.fromJson);

    return model;
  }
}
