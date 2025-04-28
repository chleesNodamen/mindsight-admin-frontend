class MasterRegisterReqPost {
  String? email;
  String? name;
  String? lastName; // ✅ 추가
  String? gender; // ✅ 추가
  String? birthDate; // ✅ 추가
  String? nickname;
  String? password;
  String? photoUrl;
  String? phoneNumber;
  String? idPhotoUrl;
  String? country;
  String? address;
  String? primaryLanguage;
  String? secondaryLanguage;
  String? intro;
  String? companyId;

  MasterRegisterReqPost({
    this.email,
    this.name,
    this.lastName, // ✅ 추가
    this.gender, // ✅ 추가
    this.birthDate, // ✅ 추가
    this.nickname,
    this.password,
    this.photoUrl,
    this.phoneNumber,
    this.idPhotoUrl,
    this.country,
    this.address,
    this.primaryLanguage,
    this.secondaryLanguage,
    this.intro,
    this.companyId,
  });

  MasterRegisterReqPost copyWith({
    String? email,
    String? name,
    String? lastName, // ✅ 추가
    String? gender, // ✅ 추가
    String? birthDate, // ✅ 추가
    String? nickname,
    String? password,
    String? photoUrl,
    String? phoneNumber,
    String? idPhotoUrl,
    String? country,
    String? address,
    String? primaryLanguage,
    String? secondaryLanguage,
    String? intro,
    String? companyId,
  }) =>
      MasterRegisterReqPost(
        email: email ?? this.email,
        name: name ?? this.name,
        lastName: lastName ?? this.lastName,
        gender: gender ?? this.gender,
        birthDate: birthDate ?? this.birthDate,
        nickname: nickname ?? this.nickname,
        password: password ?? this.password,
        photoUrl: photoUrl ?? this.photoUrl,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        idPhotoUrl: idPhotoUrl ?? this.idPhotoUrl,
        country: country ?? this.country,
        address: address ?? this.address,
        primaryLanguage: primaryLanguage ?? this.primaryLanguage,
        secondaryLanguage: secondaryLanguage ?? this.secondaryLanguage,
        intro: intro ?? this.intro,
        companyId: companyId ?? this.companyId,
      );

  factory MasterRegisterReqPost.fromJson(Map<String, dynamic> json) =>
      MasterRegisterReqPost(
        email: json["email"],
        name: json["name"],
        lastName: json["lastName"], // ✅ 추가
        gender: json["gender"], // ✅ 추가
        birthDate: json["birthDate"], // ✅ 추가
        nickname: json["nickname"],
        password: json["password"],
        photoUrl: json["photoUrl"],
        phoneNumber: json["phoneNumber"],
        idPhotoUrl: json["idPhotoUrl"],
        country: json["country"],
        address: json["address"],
        primaryLanguage: json["primaryLanguage"],
        secondaryLanguage: json["secondaryLanguage"],
        intro: json["intro"],
        companyId: json["companyId"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "name": name,
        "lastName": lastName, // ✅ 추가
        "gender": gender, // ✅ 추가
        "birthDate": birthDate, // ✅ 추가
        "nickname": nickname,
        "password": password,
        "photoUrl": photoUrl,
        "phoneNumber": phoneNumber,
        "idPhotoUrl": idPhotoUrl,
        "country": country,
        "address": address,
        "primaryLanguage": primaryLanguage,
        "secondaryLanguage": secondaryLanguage,
        "intro": intro,
        "companyId": companyId,
      };
}
