import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/admin_nouse/admin_details/admin_details_model.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';

class AdminDetailsRepository extends BaseRepository {
  Future<AdminDetailsModel> get(String? id) async {
    // req
    String endpoint = "admin/$id";
    Response response = await httpClient.getRequest(endpoint);

    // result
    AdminDetailsModel model =
        fetchJsonData<AdminDetailsModel>(response, AdminDetailsModel.fromJson);

    return model;
  }
}
