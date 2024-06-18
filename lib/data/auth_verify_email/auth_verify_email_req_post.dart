class AuthVerifyEmailReqPost {
  String? email;
  String? type;

  AuthVerifyEmailReqPost({
    this.email,
    this.type,
  });

  AuthVerifyEmailReqPost copyWith({
    String? email,
    String? type,
  }) =>
      AuthVerifyEmailReqPost(
        email: email ?? this.email,
        type: type ?? this.type,
      );

  factory AuthVerifyEmailReqPost.fromJson(Map<String, dynamic> json) =>
      AuthVerifyEmailReqPost(
        email: json["email"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "type": type,
      };
}
