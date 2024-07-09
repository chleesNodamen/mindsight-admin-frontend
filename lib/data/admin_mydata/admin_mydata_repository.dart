import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/admin_mydata/admin_mydata_model.dart';

class AdminMydataRepository extends BaseRepository {
  Future<AdminMyDataModel> get() async {
    // req
    String endpoint = "mydata";
    Response response = await httpClient.get(endpoint);

    // result
    AdminMyDataModel model =
        fetchJsonData<AdminMyDataModel>(response, AdminMyDataModel.fromJson);

    return model;
  }
}
