import 'package:mindsight_admin_page/data/base_model.dart';

class MasterProfitRateListModel extends BaseModel {
  List<String>? id;
  List<String>? name;
  List<String>? email;
  List<String>? intro;
  List<double>? currentProfitRate;
  List<double>? previousProfitRate;
  int? total;

  MasterProfitRateListModel({
    this.id,
    this.name,
    this.email,
    this.intro,
    this.currentProfitRate,
    this.previousProfitRate,
    this.total,
  });

  MasterProfitRateListModel copyWith({
    List<String>? id,
    List<String>? name,
    List<String>? email,
    List<String>? intro,
    List<double>? currentProfitRate,
    List<double>? previousProfitRate,
    int? total,
  }) =>
      MasterProfitRateListModel(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        intro: intro ?? this.intro,
        currentProfitRate: currentProfitRate ?? this.currentProfitRate,
        previousProfitRate: previousProfitRate ?? this.previousProfitRate,
        total: total ?? this.total,
      );

  factory MasterProfitRateListModel.fromJson(Map<String, dynamic> json) =>
      MasterProfitRateListModel(
        id: json["id"] == null
            ? []
            : List<String>.from(json["id"]!.map((x) => x)),
        name: json["name"] == null
            ? []
            : List<String>.from(json["name"]!.map((x) => x)),
        email: json["email"] == null
            ? []
            : List<String>.from(json["email"]!.map((x) => x)),
        intro: json["intro"] == null
            ? []
            : List<String>.from(json["intro"]!.map((x) => x ?? "")),
        currentProfitRate: json["currentProfitRate"] == null
            ? []
            : List<double>.from(json["currentProfitRate"]!.map((x) => x)),
        previousProfitRate: json["previousProfitRate"] == null
            ? []
            : List<double>.from(json["previousProfitRate"]!.map((x) => x)),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? [] : List<dynamic>.from(id!.map((x) => x)),
        "name": name == null ? [] : List<dynamic>.from(name!.map((x) => x)),
        "email": email == null ? [] : List<dynamic>.from(email!.map((x) => x)),
        "intro": intro == null ? [] : List<dynamic>.from(intro!.map((x) => x)),
        "currentProfitRate": currentProfitRate == null
            ? []
            : List<dynamic>.from(currentProfitRate!.map((x) => x)),
        "previousProfitRate": previousProfitRate == null
            ? []
            : List<dynamic>.from(previousProfitRate!.map((x) => x)),
        "total": total,
      };
}
