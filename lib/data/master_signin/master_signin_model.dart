import 'package:mindsight_admin_page/data/base_model.dart';

class MasterSigninModel extends BaseModel {
  String? accessToken;
  String? id;

  MasterSigninModel({
    this.accessToken,
    this.id,
  });

  factory MasterSigninModel.fromJson(Map<String, dynamic> json) =>
      MasterSigninModel(
        accessToken: json["accessToken"],
        id: json["id"],
      );
}
