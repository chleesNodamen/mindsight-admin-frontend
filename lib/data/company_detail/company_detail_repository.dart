import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/company_detail/company_detail_model.dart';

class CompanyDetailRepository extends BaseRepository {
  Future<CompanyDetailModel> get(String id) async {
    // req
    String endpoint = "company/$id";
    Response response = await httpClient.getRequest(endpoint);

    // result
    CompanyDetailModel model = fetchJsonData<CompanyDetailModel>(
        response, CompanyDetailModel.fromJson);

    return model;
  }
}
