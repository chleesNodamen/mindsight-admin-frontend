// master_detail_response_dto.dart

import 'package:mindsight_admin_page/data/base_model.dart';

class MasterDetailModel extends BaseModel {
  // 개인 정보 필드
  final String id;
  final String email;
  final String name;
  final String nickname;
  final DateTime createdAt;
  final bool verified;
  final String phoneNumber;
  final String country;
  final String address;
  final String primaryLanguage;
  final String? secondaryLanguage;
  final String intro;
  final double currentProfitRate;
  final double previousProfitRate;
  final String? photoUrl;
  final String? idPhotoUrl;

  // 회사 정보 필드 (클래스 하단으로 이동)
  final String? companyName;
  final String? representative;
  final String? businessNumber;
  final String? companyPhone;
  final String? contactName;
  final String? contactEmail;
  final String? contactPhone;
  final String? contactAddress;

  MasterDetailModel({
    required this.id,
    required this.email,
    required this.name,
    required this.nickname,
    required this.createdAt,
    required this.verified,
    required this.phoneNumber,
    required this.country,
    required this.address,
    required this.primaryLanguage,
    this.secondaryLanguage,
    required this.intro,
    required this.currentProfitRate,
    required this.previousProfitRate,
    // 회사 정보 필드
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
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      nickname: json['nickname'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      verified: json['verified'] as bool,
      phoneNumber: json['phoneNumber'] as String,
      country: json['country'] as String,
      address: json['address'] as String,
      primaryLanguage: json['primaryLanguage'] as String,
      secondaryLanguage: json['secondaryLanguage'] as String?,
      intro: json['intro'] as String,
      currentProfitRate: (json['currentProfitRate'] as num).toDouble(),
      previousProfitRate: (json['previousProfitRate'] as num).toDouble(),
      // 회사 정보 필드
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
