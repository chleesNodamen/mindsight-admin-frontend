import 'package:mindsight_admin_page/data/base_model.dart';

class AuthModel extends BaseModel {
  String? accessToken;
  String? refreshToken;
  int? attemptsLeft;

  AuthModel({
    this.accessToken,
    this.refreshToken,
    this.attemptsLeft,
  });

  AuthModel copyWith({
    String? accessToken,
    String? refreshToken,
    int? attemptsLeft,
  }) =>
      AuthModel(
        accessToken: accessToken ?? this.accessToken,
        refreshToken: refreshToken ?? this.refreshToken,
        attemptsLeft: attemptsLeft ?? this.attemptsLeft,
      );

  factory AuthModel.fromJson(Map<String, dynamic> json) =>
      AuthModel(
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
        attemptsLeft: json["attemptsLeft"],
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "refreshToken": refreshToken,
        "attemptsLeft": attemptsLeft,
      };
}
