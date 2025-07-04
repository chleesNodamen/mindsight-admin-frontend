import 'package:http/http.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';
import 'package:mindsight_admin_page/data/content_details/content_details_model.dart';

class ContentDetailsRepository extends BaseRepository {
  Future<ContentDetailsModel> get(String? id) async {
    // req
    String endpoint = "contents/$id";
    Response response = await httpClient.getRequest(endpoint);

    // result
    ContentDetailsModel model = fetchJsonData<ContentDetailsModel>(
        response, ContentDetailsModel.fromJson);

    return model;
  }
}
