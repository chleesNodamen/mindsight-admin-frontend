import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/data/base_repository.dart';

class AuthPasswordResetRepository extends BaseRepository {
  Future<AuthPasswordResetModel> put(Map<String, dynamic> body) async {
    // req
    String endpoint = "auth/password-reset";
    Response response = await httpClient.put(endpoint, body);

    // result
    AuthPasswordResetModel model = fetchJsonData<AuthPasswordResetModel>(
        response, AuthPasswordResetModel.fromJson);

    if (model.isSuccess) {
      httpClient.setBearerAuthorization(model.accessToken!);
    }

    return model;
  }
}
