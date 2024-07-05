import 'package:mindsight_admin_page/data/base_model.dart';

class AuthModel extends BaseModel {
  String? accessToken;

  AuthModel({
    this.accessToken,
  });

  AuthModel copyWith({
    String? accessToken,
  }) =>
      AuthModel(
        accessToken: accessToken ?? this.accessToken,
      );

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        accessToken: json["accessToken"],
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
      };
}
