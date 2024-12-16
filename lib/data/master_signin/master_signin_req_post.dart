class MasterSigninReqPost {
  String? email;
  String? password;
  int? version;

  MasterSigninReqPost({
    this.email,
    this.password,
    this.version,
  });

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "version": version,
      };
}
