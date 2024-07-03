import 'package:mindsight_admin_page/data/base_model.dart';

class MasterModel extends BaseModel {
  List<String>? id;
  List<String>? name;

  MasterModel({
    this.id,
    this.name,
  });

  MasterModel copyWith({
    List<String>? id,
    List<String>? name,
  }) =>
      MasterModel(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory MasterModel.fromJson(Map<String, dynamic> json) => MasterModel(
        id: json["id"] == null
            ? []
            : List<String>.from(json["id"]!.map((x) => x)),
        name: json["name"] == null
            ? []
            : List<String>.from(json["name"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? [] : List<dynamic>.from(id!.map((x) => x)),
        "name": name == null ? [] : List<dynamic>.from(name!.map((x) => x)),
      };
}
