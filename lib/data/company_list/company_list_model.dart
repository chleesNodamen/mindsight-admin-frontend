// lib/data/company_manage/company_list_model.dart

import 'package:mindsight_admin_page/data/base_model.dart';

class CompanyListModel extends BaseModel {
  List<String>? id;
  List<String>? companyName;
  List<String>? representative;
  List<String>? businessNumber;
  List<String>? phone;
  List<String>? contactName;
  List<String>? contactEmail;
  List<String>? contactPhone;
  List<String>? address;
  List<bool>? verified;
  List<DateTime>? createdAt;
  List<DateTime>? updatedAt;
  int? total;

  CompanyListModel({
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
    this.total,
  });

  CompanyListModel copyWith({
    List<String>? id,
    List<String>? companyName,
    List<String>? representative,
    List<String>? businessNumber,
    List<String>? phone,
    List<String>? contactName,
    List<String>? contactEmail,
    List<String>? contactPhone,
    List<String>? address,
    List<bool>? verified,
    List<DateTime>? createdAt,
    List<DateTime>? updatedAt,
    int? total,
  }) =>
      CompanyListModel(
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
        total: total ?? this.total,
      );

  factory CompanyListModel.fromJson(Map<String, dynamic> json) =>
      CompanyListModel(
        id: json["company"] == null
            ? []
            : List<String>.from(
                json["company"]!.map((x) => x["id"].toString())),
        companyName: json["company"] == null
            ? []
            : List<String>.from(
                json["company"]!.map((x) => x["companyName"] ?? "")),
        representative: json["company"] == null
            ? []
            : List<String>.from(
                json["company"]!.map((x) => x["representative"] ?? "")),
        businessNumber: json["company"] == null
            ? []
            : List<String>.from(
                json["company"]!.map((x) => x["businessNumber"] ?? "")),
        phone: json["company"] == null
            ? []
            : List<String>.from(json["company"]!.map((x) => x["phone"] ?? "")),
        contactName: json["company"] == null
            ? []
            : List<String>.from(
                json["company"]!.map((x) => x["contactName"] ?? "")),
        contactEmail: json["company"] == null
            ? []
            : List<String>.from(
                json["company"]!.map((x) => x["contactEmail"] ?? "")),
        contactPhone: json["company"] == null
            ? []
            : List<String>.from(
                json["company"]!.map((x) => x["contactPhone"] ?? "")),
        address: json["company"] == null
            ? []
            : List<String>.from(
                json["company"]!.map((x) => x["address"] ?? "")),
        verified: json["company"] == null
            ? []
            : List<bool>.from(json["company"]!.map((x) => x["verified"])),
        createdAt: json["company"] == null
            ? []
            : List<DateTime>.from(
                json["company"]!.map((x) => DateTime.parse(x["createdAt"])),
              ),
        updatedAt: json["company"] == null
            ? []
            : List<DateTime>.from(
                json["company"]!.map((x) => DateTime.parse(x["updatedAt"])),
              ),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "company": id == null
            ? []
            : List<dynamic>.from(id!.asMap().entries.map((entry) {
                int idx = entry.key;
                return {
                  "id": entry.value,
                  "companyName": companyName?[idx] ?? "",
                  "representative": representative?[idx] ?? "",
                  "businessNumber": businessNumber?[idx] ?? "",
                  "phone": phone?[idx] ?? "",
                  "contactName": contactName?[idx] ?? "",
                  "contactEmail": contactEmail?[idx] ?? "",
                  "contactPhone": contactPhone?[idx] ?? "",
                  "address": address?[idx] ?? "",
                  "verified": verified?[idx] ?? false,
                  "createdAt": createdAt?[idx]?.toIso8601String(),
                  "updatedAt": updatedAt?[idx]?.toIso8601String(),
                };
              })),
        "total": total,
      };
}
