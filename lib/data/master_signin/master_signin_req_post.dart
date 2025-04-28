class MasterSigninReqPost {
  String? email;
  String? password;
  int? version;
  bool? isThirdParty;

  MasterSigninReqPost({
    this.email,
    this.password,
    this.version,
    this.isThirdParty,
  });

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "version": version,
        "isThirdParty": isThirdParty,
      };
}
