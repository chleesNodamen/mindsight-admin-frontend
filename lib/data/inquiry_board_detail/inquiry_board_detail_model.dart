import 'package:mindsight_admin_page/data/base_model.dart';

class InquiryBoardDetailModel extends BaseModel {
  String? id;
  String? subject;
  String? message;
  bool? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? masterId;
  String? masterEmail;
  String? masterNickname;
  String? response;

  InquiryBoardDetailModel({
    this.id,
    this.subject,
    this.message,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.masterId,
    this.masterEmail,
    this.masterNickname,
    this.response,
  });

  factory InquiryBoardDetailModel.fromJson(Map<String, dynamic> json) =>
      InquiryBoardDetailModel(
        id: json["id"],
        subject: json["subject"],
        message: json["message"],
        status: json["status"],
        masterId: json["masterId"],
        masterEmail: json["masterEmail"],
        masterNickname: json["masterNickname"],
        response: json["response"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );
}
