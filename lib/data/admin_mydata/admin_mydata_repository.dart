import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/admin_mydata/admin_mydata_model.dart';

class AdminMydataRepository extends BaseRepository {
  Future<AdminMyDataModel> get() async {
    // req
    String endpoint = "admin/mydata";
    Response response = await httpClient.getRequest(endpoint);

    // result
    AdminMyDataModel model =
        fetchJsonData<AdminMyDataModel>(response, AdminMyDataModel.fromJson);

    return model;
  }
}
