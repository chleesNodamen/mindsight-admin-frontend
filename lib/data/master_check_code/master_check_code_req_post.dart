class MasterCheckCodeReqPost {
  String? email;
  String? code;

  MasterCheckCodeReqPost({
    this.email,
    this.code,
  });

  Map<String, dynamic> toJson() => {
        "email": email,
        "code": code,
      };
}
