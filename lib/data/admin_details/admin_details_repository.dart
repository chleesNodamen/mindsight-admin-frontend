import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/admin_details/admin_details_model.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';

class AdminDetailsRepository extends BaseRepository {
  Future<AdminDetailsModel> get(String? id) async {
    // req
    String endpoint = "$id";
    Response response = await httpClient.get(endpoint);

    // result
    AdminDetailsModel model =
        fetchJsonData<AdminDetailsModel>(response, AdminDetailsModel.fromJson);

    return model;
  }
}
