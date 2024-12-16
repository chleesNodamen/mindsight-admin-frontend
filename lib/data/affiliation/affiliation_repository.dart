import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/affiliation/affiliation_model.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';

class AffiliationRepository extends BaseRepository {
  Future<AffiliationModel> get() async {
    // req
    String endpoint = "member/affiliation";
    Response response = await httpClient.getRequest(endpoint);

    // result
    AffiliationModel model =
        fetchJsonData<AffiliationModel>(response, AffiliationModel.fromJson);
    model.length = model.affiliation?.length ?? model.length;

    return model;
  }
}
