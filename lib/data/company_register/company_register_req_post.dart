// lib/data/company_register/company_register_req_post.dart

class CompanyRegisterReqPost {
  String? companyName;
  String? representative;
  String? businessNumber;
  String? phone;
  String? contactName;
  String? contactEmail;
  String? contactPhone;
  String? address;

  CompanyRegisterReqPost({
    this.companyName,
    this.representative,
    this.businessNumber,
    this.phone,
    this.contactName,
    this.contactEmail,
    this.contactPhone,
    this.address,
  });

  CompanyRegisterReqPost copyWith({
    String? companyName,
    String? representative,
    String? businessNumber,
    String? phone,
    String? contactName,
    String? contactEmail,
    String? contactPhone,
    String? address,
  }) =>
      CompanyRegisterReqPost(
        companyName: companyName ?? this.companyName,
        representative: representative ?? this.representative,
        businessNumber: businessNumber ?? this.businessNumber,
        phone: phone ?? this.phone,
        contactName: contactName ?? this.contactName,
        contactEmail: contactEmail ?? this.contactEmail,
        contactPhone: contactPhone ?? this.contactPhone,
        address: address ?? this.address,
      );

  factory CompanyRegisterReqPost.fromJson(Map<String, dynamic> json) =>
      CompanyRegisterReqPost(
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
