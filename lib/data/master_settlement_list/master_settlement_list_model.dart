import 'package:mindsight_admin_page/data/base_model.dart';

class MasterSettlementListModel extends BaseModel {
  List<String>? id;
  List<String>? name;
  List<String>? intro;
  List<int>? currentProfitRate;
  List<int>? previousProfitRate;
  int? total;

  MasterSettlementListModel({
    this.id,
    this.name,
    this.intro,
    this.currentProfitRate,
    this.previousProfitRate,
    this.total,
  });

  MasterSettlementListModel copyWith({
    List<String>? id,
    List<String>? name,
    List<String>? intro,
    List<int>? currentProfitRate,
    List<int>? previousProfitRate,
    int? total,
  }) =>
      MasterSettlementListModel(
        id: id ?? this.id,
        name: name ?? this.name,
        intro: intro ?? this.intro,
        currentProfitRate: currentProfitRate ?? this.currentProfitRate,
        previousProfitRate: previousProfitRate ?? this.previousProfitRate,
        total: total ?? this.total,
      );

  factory MasterSettlementListModel.fromJson(Map<String, dynamic> json) =>
      MasterSettlementListModel(
        id: json["id"] == null
            ? []
            : List<String>.from(json["id"]!.map((x) => x)),
        name: json["name"] == null
            ? []
            : List<String>.from(json["name"]!.map((x) => x)),
        intro: json["intro"] == null
            ? []
            : List<String>.from(json["intro"]!.map((x) => x ?? "-")),
        currentProfitRate: json["currentProfitRate"] == null
            ? []
            : List<int>.from(json["currentProfitRate"]!.map((x) => x)),
        previousProfitRate: json["previousProfitRate"] == null
            ? []
            : List<int>.from(json["previousProfitRate"]!.map((x) => x)),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? [] : List<dynamic>.from(id!.map((x) => x)),
        "name": name == null ? [] : List<dynamic>.from(name!.map((x) => x)),
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
