import 'package:mindsight_admin_page/data/base_model.dart';

class InquiryBoardListModel extends BaseModel {
  List<String>? id;
  List<String>? subject;
  List<String>? message;
  List<bool>? status;
  List<String>? masterId;
  List<String>? masterNickname;
  List<String>? masterEmail;
  List<DateTime>? createdAt;
  List<DateTime>? updatedAt;
  List<int>? views;
  int? total;

  InquiryBoardListModel({
    this.id,
    this.subject,
    this.message,
    this.status,
    this.masterId,
    this.masterNickname,
    this.masterEmail,
    this.createdAt,
    this.updatedAt,
    this.views,
    this.total,
  });

  factory InquiryBoardListModel.fromJson(Map<String, dynamic> json) =>
      InquiryBoardListModel(
        id: json["inquiryBoard"] == null
            ? []
            : List<String>.from(
                json["inquiryBoard"]!.map((x) => x["id"].toString())),
        subject: json["inquiryBoard"] == null
            ? []
            : List<String>.from(
                json["inquiryBoard"]!.map((x) => x["subject"].toString())),
        message: json["inquiryBoard"] == null
            ? []
            : List<String>.from(
                json["inquiryBoard"]!.map((x) => x["message"].toString())),
        status: json["inquiryBoard"] == null
            ? []
            : List<bool>.from(
                json["inquiryBoard"]!.map((x) => x["status"] as bool)),
        masterId: json["inquiryBoard"] == null
            ? []
            : List<String>.from(
                json["inquiryBoard"]!.map((x) => x["masterId"].toString())),
        masterNickname: json["inquiryBoard"] == null
            ? []
            : List<String>.from(json["inquiryBoard"]!
                .map((x) => x["masterNickname"].toString())),
        masterEmail: json["inquiryBoard"] == null
            ? []
            : List<String>.from(
                json["inquiryBoard"]!.map((x) => x["masterEmail"].toString())),
        createdAt: json["inquiryBoard"] == null
            ? []
            : List<DateTime>.from(
                json["inquiryBoard"]!
                    .map((x) => DateTime.parse(x["createdAt"])),
              ),
        updatedAt: json["inquiryBoard"] == null
            ? []
            : List<DateTime>.from(
                json["inquiryBoard"]!
                    .map((x) => DateTime.parse(x["updatedAt"])),
              ),
        views: json["inquiryBoard"] == null
            ? []
            : List<int>.from(
                json["inquiryBoard"]!.map((x) => x["views"] as int)),
        total: json["total"],
      );
}
