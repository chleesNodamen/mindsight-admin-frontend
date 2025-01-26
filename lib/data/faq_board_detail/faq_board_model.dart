import 'package:mindsight_admin_page/data/base_model.dart';

class FAQBoardDetailModel extends BaseModel {
  String? id;
  String? question;
  String? answer;
  DateTime? createdAt;
  DateTime? updatedAt;

  FAQBoardDetailModel({
    this.id,
    this.question,
    this.answer,
    this.createdAt,
    this.updatedAt,
  });

  factory FAQBoardDetailModel.fromJson(Map<String, dynamic> json) =>
      FAQBoardDetailModel(
        id: json["id"],
        question: json["question"],
        answer: json["answer"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );
}
