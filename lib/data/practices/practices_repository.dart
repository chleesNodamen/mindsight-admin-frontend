import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/practices/practices_model.dart';

class PracticesRepository extends BaseRepository {
  Future<PracticesModel> get(Map<String, dynamic>? query) async {
    Logger.log(query.toString());
    // req
    String endpoint = "contentes/practices?";
    endpoint += addGetParam(query);
    Response response = await httpClient.get(endpoint);

    // result
    PracticesModel model =
        fetchJsonData<PracticesModel>(response, PracticesModel.fromJson);
    model.length = model.id?.length ?? model.length;

    return model;
  }
}
