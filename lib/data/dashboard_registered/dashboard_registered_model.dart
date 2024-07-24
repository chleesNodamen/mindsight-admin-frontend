import 'package:mindsight_admin_page/data/base_model.dart';

class DashboardRegisteredModel extends BaseModel {
  int? totalMembers;
  double? verifiedPercentage;
  double? unverifiedPercentage;
  double? disabledMembersPercentage;

  DashboardRegisteredModel({
    this.totalMembers,
    this.verifiedPercentage,
    this.unverifiedPercentage,
    this.disabledMembersPercentage,
  });

  DashboardRegisteredModel copyWith({
    int? totalMembers,
    double? verifiedPercentage,
    double? unverifiedPercentage,
    double? disabledMembersPercentage,
  }) =>
      DashboardRegisteredModel(
        totalMembers: totalMembers ?? this.totalMembers,
        verifiedPercentage: verifiedPercentage ?? this.verifiedPercentage,
        unverifiedPercentage: unverifiedPercentage ?? this.unverifiedPercentage,
        disabledMembersPercentage:
            disabledMembersPercentage ?? this.disabledMembersPercentage,
      );

  factory DashboardRegisteredModel.fromJson(Map<String, dynamic> json) =>
      DashboardRegisteredModel(
        totalMembers: json["totalMembers"],
        verifiedPercentage: json["verifiedPercentage"],
        unverifiedPercentage: json["unverifiedPercentage"],
        disabledMembersPercentage: json["disabledMembersPercentage"],
      );

  Map<String, dynamic> toJson() => {
        "totalMembers": totalMembers,
        "verifiedPercentage": verifiedPercentage,
        "unverifiedPercentage": unverifiedPercentage,
        "disabledMembersPercentage": disabledMembersPercentage,
      };
}
