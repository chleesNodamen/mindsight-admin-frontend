import 'package:mindsight_admin_page/data/base_model.dart';

class AuthPasswordResetModel extends BaseModel {
  String? accessToken;
  String? refreshToken;

  AuthPasswordResetModel({
    this.accessToken,
    this.refreshToken,
  });

  AuthPasswordResetModel copyWith({
    String? accessToken,
    String? refreshToken,
  }) =>
      AuthPasswordResetModel(
        accessToken: accessToken ?? this.accessToken,
        refreshToken: refreshToken ?? this.refreshToken,
      );

  factory AuthPasswordResetModel.fromJson(Map<String, dynamic> json) =>
      AuthPasswordResetModel(
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "refreshToken": refreshToken,
      };
}
