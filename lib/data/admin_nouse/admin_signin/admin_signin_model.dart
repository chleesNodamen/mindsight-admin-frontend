import 'package:mindsight_admin_page/data/base_model.dart';

class AdminSigninModel extends BaseModel {
  String? accessToken;
  String? id;

  AdminSigninModel({
    this.accessToken,
    this.id,
  });

  factory AdminSigninModel.fromJson(Map<String, dynamic> json) =>
      AdminSigninModel(
        accessToken: json["accessToken"],
        id: json["id"],
      );
}
