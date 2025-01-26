import 'package:mindsight_admin_page/data/base_model.dart';

class FAQBoardListModel extends BaseModel {
  List<String>? id;
  List<String>? question;
  List<String>? answer;
  List<DateTime>? createdAt;
  List<DateTime>? updatedAt;
  List<int>? views;
  int? total;

  FAQBoardListModel({
    this.id,
    this.question,
    this.answer,
    this.createdAt,
    this.updatedAt,
    this.views,
    this.total,
  });

  factory FAQBoardListModel.fromJson(Map<String, dynamic> json) =>
      FAQBoardListModel(
        id: json["faqBoard"] == null
            ? []
            : List<String>.from(
                json["faqBoard"]!.map((x) => x["id"].toString())),
        question: json["faqBoard"] == null
            ? []
            : List<String>.from(
                json["faqBoard"]!.map((x) => x["question"].toString())),
        answer: json["faqBoard"] == null
            ? []
            : List<String>.from(
                json["faqBoard"]!.map((x) => x["answer"].toString())),
        createdAt: json["faqBoard"] == null
            ? []
            : List<DateTime>.from(
                json["faqBoard"]!.map((x) => DateTime.parse(x["createdAt"])),
              ),
        updatedAt: json["faqBoard"] == null
            ? []
            : List<DateTime>.from(
                json["faqBoard"]!.map((x) => DateTime.parse(x["updatedAt"])),
              ),
        views: json["faqBoard"] == null
            ? []
            : List<int>.from(json["faqBoard"]!.map((x) => x["views"] as int)),
        total: json["total"],
      );
}
