class MasterEditReqPut {
  String? name;
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

  MasterEditReqPut({
    this.name,
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

  Map<String, dynamic> toJson() {
    return {
      "name": name,
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
}
