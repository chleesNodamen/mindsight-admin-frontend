import 'package:mindsight_admin_page/data/base_model.dart';

class CompanyDataModel extends BaseModel {
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

  CompanyDataModel({
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
  });

  CompanyDataModel copyWith({
    String? id,
    String? companyName,
    String? representative,
    String? businessNumber,
    String? phone,
    String? contactName,
    String? contactEmail,
    String? contactPhone,
    String? address,
    bool? verified,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      CompanyDataModel(
        id: id ?? this.id,
        companyName: companyName ?? this.companyName,
        representative: representative ?? this.representative,
        businessNumber: businessNumber ?? this.businessNumber,
        phone: phone ?? this.phone,
        contactName: contactName ?? this.contactName,
        contactEmail: contactEmail ?? this.contactEmail,
        contactPhone: contactPhone ?? this.contactPhone,
        address: address ?? this.address,
        verified: verified ?? this.verified,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory CompanyDataModel.fromJson(Map<String, dynamic> json) =>
      CompanyDataModel(
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
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id,
        "companyName": companyName,
        "representative": representative,
        "businessNumber": businessNumber,
        "phone": phone,
        "contactName": contactName,
        "contactEmail": contactEmail,
        "contactPhone": contactPhone,
        "address": address,
        "verified": verified,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
