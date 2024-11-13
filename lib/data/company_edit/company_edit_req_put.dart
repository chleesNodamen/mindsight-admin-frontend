import 'package:mindsight_admin_page/data/base_model.dart';

class CompanyEditReqPut extends BaseModel {
  String? companyName;
  String? representative;
  String? businessNumber;
  String? phone;
  String? contactName;
  String? contactEmail;
  String? contactPhone;
  String? address;

  CompanyEditReqPut({
    this.companyName,
    this.representative,
    this.businessNumber,
    this.phone,
    this.contactName,
    this.contactEmail,
    this.contactPhone,
    this.address,
  });

  CompanyEditReqPut copyWith({
    String? companyName,
    String? representative,
    String? businessNumber,
    String? phone,
    String? contactName,
    String? contactEmail,
    String? contactPhone,
    String? address,
  }) =>
      CompanyEditReqPut(
        companyName: companyName ?? this.companyName,
        representative: representative ?? this.representative,
        businessNumber: businessNumber ?? this.businessNumber,
        phone: phone ?? this.phone,
        contactName: contactName ?? this.contactName,
        contactEmail: contactEmail ?? this.contactEmail,
        contactPhone: contactPhone ?? this.contactPhone,
        address: address ?? this.address,
      );

  factory CompanyEditReqPut.fromJson(Map<String, dynamic> json) =>
      CompanyEditReqPut(
        companyName: json["companyName"],
        representative: json["representative"],
        businessNumber: json["businessNumber"],
        phone: json["phone"],
        contactName: json["contactName"],
        contactEmail: json["contactEmail"],
        contactPhone: json["contactPhone"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "companyName": companyName,
        "representative": representative,
        "businessNumber": businessNumber,
        "phone": phone,
        "contactName": contactName,
        "contactEmail": contactEmail,
        "contactPhone": contactPhone,
        "address": address,
      };
}
