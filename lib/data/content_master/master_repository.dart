import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/content_master/master_model.dart';

class MasterRepository extends BaseRepository {
  Future<MasterModel> get() async {
    // req
    String endpoint = "contents/master/list";
    Response response = await httpClient.getRequest(endpoint);

    // result
    MasterModel model =
        fetchJsonData<MasterModel>(response, MasterModel.fromJson);
    model.length = model.id?.length ?? model.length;

    return model;
  }
}
