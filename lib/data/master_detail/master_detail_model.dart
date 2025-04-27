// master_detail_response_dto.dart

import 'package:mindsight_admin_page/data/base_model.dart';

class MasterDetailModel extends BaseModel {
  // 개인 정보 필드
  final String? id;
  final String? email;
  final String? name;
  final String? nickname;
  final DateTime? createdAt;
  final bool? verified;
  final String? phoneNumber;
  final String? country;
  final String? address;
  final String? primaryLanguage;
  final String? secondaryLanguage;
  final String? intro;
  final double? currentProfitRate;
  final double? previousProfitRate;
  final String? photoUrl;
  final String? idPhotoUrl;

  // Company info 필드
  final String? companyName;
  final String? representative;
  final String? businessNumber;
  final String? companyPhone;
  final String? contactName;
  final String? contactEmail;
  final String? contactPhone;
  final String? contactAddress;

  MasterDetailModel({
    this.id,
    this.email,
    this.name,
    this.nickname,
    this.createdAt,
    this.verified,
    this.phoneNumber,
    this.country,
    this.address,
    this.primaryLanguage,
    this.secondaryLanguage,
    this.intro,
    this.currentProfitRate,
    this.previousProfitRate,
    // Company info 필드
    this.companyName,
    this.representative,
    this.businessNumber,
    this.companyPhone,
    this.contactName,
    this.contactEmail,
    this.contactPhone,
    this.contactAddress,
    this.photoUrl,
    this.idPhotoUrl,
  });

  factory MasterDetailModel.fromJson(Map<String, dynamic> json) {
    return MasterDetailModel(
      id: json['id'] as String?,
      email: json['email'] as String?,
      name: json['name'] as String?,
      nickname: json['nickname'] as String?,
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      verified: json['verified'] as bool?,
      phoneNumber: json['phoneNumber'] as String?,
      country: json['country'] as String?,
      address: json['address'] as String?,
      primaryLanguage: json['primaryLanguage'] as String?,
      secondaryLanguage: json['secondaryLanguage'] as String?,
      intro: json['intro'] as String?,
      currentProfitRate: json['currentProfitRate'] != null
          ? (json['currentProfitRate'] as num).toDouble()
          : null,
      previousProfitRate: json['previousProfitRate'] != null
          ? (json['previousProfitRate'] as num).toDouble()
          : null,
      // Company info 필드
      companyName: json['companyName'] as String?,
      representative: json['representative'] as String?,
      businessNumber: json['businessNumber'] as String?,
      companyPhone: json['companyPhone'] as String?,
      contactName: json['contactName'] as String?,
      contactEmail: json['contactEmail'] as String?,
      contactPhone: json['contactPhone'] as String?,
      contactAddress: json['contactAddress'] as String?,
      photoUrl: json['photoUrl'] as String?,
      idPhotoUrl: json['idPhotoUrl'] as String?,
    );
  }
}
