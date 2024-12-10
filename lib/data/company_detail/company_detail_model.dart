import 'package:mindsight_admin_page/data/base_model.dart';

class CompanyDetailModel extends BaseModel {
  String? id;
  String? companyName;
  String? representative;
  String? businessNumber;
  String? phone;
  String? contactName;
  String? contactEmail;
  String? contactPhone;
  String? address;
  bool? verified;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? createMasterId;
  String? createMasterEmail;
  String? createMasterNickname;

  CompanyDetailModel({
    this.id,
    this.companyName,
    this.representative,
    this.businessNumber,
    this.phone,
    this.contactName,
    this.contactEmail,
    this.contactPhone,
    this.address,
    this.verified,
    this.createdAt,
    this.updatedAt,
    this.createMasterId,
    this.createMasterEmail,
    this.createMasterNickname,
  });

  factory CompanyDetailModel.fromJson(Map<String, dynamic> json) =>
      CompanyDetailModel(
        id: json["id"],
        companyName: json["companyName"],
        representative: json["representative"],
        businessNumber: json["businessNumber"],
        phone: json["phone"],
        contactName: json["contactName"],
        contactEmail: json["contactEmail"],
        contactPhone: json["contactPhone"],
        address: json["address"],
        verified: json["verified"],
        createMasterId: json["createMasterId"],
        createMasterEmail: json["createMasterEmail"],
        createMasterNickname: json["createMasterNickname"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );
}
