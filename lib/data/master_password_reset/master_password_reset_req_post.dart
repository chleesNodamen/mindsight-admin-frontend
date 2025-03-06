class MasterPasswordResetReqPost {
  String? email;
  String? password;
  String? code;

  MasterPasswordResetReqPost({
    this.email,
    this.password,
    this.code,
  });

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "code": code,
      };
}
