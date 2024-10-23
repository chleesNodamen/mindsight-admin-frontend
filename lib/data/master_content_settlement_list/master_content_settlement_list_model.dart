import 'package:mindsight_admin_page/data/base_model.dart';

class MasterContentSettlementListModel extends BaseModel {
  List<String>? name;
  List<int>? playCount;
  int? total;

  MasterContentSettlementListModel({
    this.name,
    this.playCount,
    this.total,
  });

  MasterContentSettlementListModel copyWith({
    List<String>? name,
    List<int>? playCount,
    int? total,
  }) =>
      MasterContentSettlementListModel(
        name: name ?? this.name,
        playCount: playCount ?? this.playCount,
        total: total ?? this.total,
      );

  factory MasterContentSettlementListModel.fromJson(
          Map<String, dynamic> json) =>
      MasterContentSettlementListModel(
        name: json["name"] == null
            ? []
            : List<String>.from(json["name"]!.map((x) => x)),
        playCount: json["playCount"] == null
            ? []
            : List<int>.from(json["playCount"]!.map((x) => x)),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? [] : List<dynamic>.from(name!.map((x) => x)),
        "playCount": playCount == null
            ? []
            : List<dynamic>.from(playCount!.map((x) => x)),
        "total": total,
      };
}
