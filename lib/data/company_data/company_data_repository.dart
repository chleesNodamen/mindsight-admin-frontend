import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/company_data/company_data_model.dart';

class CompanyDataRepository extends BaseRepository {
  Future<CompanyDataModel> get(String id) async {
    // req
    String endpoint = "companies/$id";
    Response response = await httpClient.getRequest(endpoint);

    // result
    CompanyDataModel model =
        fetchJsonData<CompanyDataModel>(response, CompanyDataModel.fromJson);

    return model;
  }
}
