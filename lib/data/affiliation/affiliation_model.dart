import 'package:mindsight_admin_page/data/base_model.dart';

class AffiliationModel extends BaseModel {
  List<String>? affiliation;

  AffiliationModel({
    this.affiliation,
  });

  AffiliationModel copyWith({
    List<String>? affiliation,
  }) =>
      AffiliationModel(
        affiliation: affiliation ?? this.affiliation,
      );

  factory AffiliationModel.fromJson(Map<String, dynamic> json) =>
      AffiliationModel(
        affiliation: json["affiliation"] == null
            ? []
            : List<String>.from(json["affiliation"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "affiliation": affiliation == null
            ? []
            : List<dynamic>.from(affiliation!.map((x) => x)),
      };
}
