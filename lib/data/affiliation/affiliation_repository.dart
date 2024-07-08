import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/affiliation/affiliation_model.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';

class AffiliationRepository extends BaseRepository {
  Future<AffiliationModel> get() async {
    // req
    String endpoint = "contents/affiliation";
    Response response = await httpClient.get(endpoint);

    // result
    AffiliationModel model =
        fetchJsonData<AffiliationModel>(response, AffiliationModel.fromJson);
    model.length = model.affiliation?.length ?? model.length;

    return model;
  }
}
