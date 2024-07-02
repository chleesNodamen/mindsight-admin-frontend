import 'package:mindsight_admin_page/data/base_model.dart';

class ContentDeleteModel extends BaseModel {
  String? type;
  String? id;

  ContentDeleteModel({
    this.type,
    this.id,
  });

  ContentDeleteModel copyWith({
    String? type,
    String? id,
  }) =>
      ContentDeleteModel(
        type: type ?? this.type,
        id: id ?? this.id,
      );

  factory ContentDeleteModel.fromJson(Map<String, dynamic> json) =>
      ContentDeleteModel(
        type: json["type"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
      };
}
