import 'package:mindsight_admin_page/data/base_model.dart';

class DashboardRegisteredModel extends BaseModel {
  int? totalMembers;
  double? verifiedPercentage;
  double? unverifiedPercentage;

  DashboardRegisteredModel({
    this.totalMembers,
    this.verifiedPercentage,
    this.unverifiedPercentage,
  });

  DashboardRegisteredModel copyWith({
    int? totalMembers,
    double? verifiedPercentage,
    double? unverifiedPercentage,
  }) =>
      DashboardRegisteredModel(
        totalMembers: totalMembers ?? this.totalMembers,
        verifiedPercentage: verifiedPercentage ?? this.verifiedPercentage,
        unverifiedPercentage: unverifiedPercentage ?? this.unverifiedPercentage,
      );

  factory DashboardRegisteredModel.fromJson(Map<String, dynamic> json) =>
      DashboardRegisteredModel(
        totalMembers: json["totalMembers"],
        verifiedPercentage: json["verifiedPercentage"],
        unverifiedPercentage: json["unverifiedPercentage"],
      );

  Map<String, dynamic> toJson() => {
        "totalMembers": totalMembers,
        "verifiedPercentage": verifiedPercentage,
        "unverifiedPercentage": unverifiedPercentage,
      };
}
