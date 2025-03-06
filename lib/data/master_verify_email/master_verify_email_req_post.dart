class MasterVerifyEmailReqPost {
  String? email;
  String? type;

  MasterVerifyEmailReqPost({
    this.email,
    this.type,
  });

  Map<String, dynamic> toJson() => {
        "email": email,
        "type": type,
      };
}
