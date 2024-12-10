import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/master_detail/master_detail_model.dart';

class MasterDetailRepository extends BaseRepository {
  Future<MasterDetailModel> get(String id) async {
    // req
    String endpoint = "master/$id";
    Response response = await httpClient.getRequest(endpoint);

    // result
    MasterDetailModel model =
        fetchJsonData<MasterDetailModel>(response, MasterDetailModel.fromJson);

    return model;
  }
}
