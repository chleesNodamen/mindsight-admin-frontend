class AuthPasswordResetReqPost {
  String? email;
  String? password;
  String? code;

  AuthPasswordResetReqPost({
    this.email,
    this.password,
    this.code,
  });

  AuthPasswordResetReqPost copyWith({
    String? email,
    String? password,
    String? code,
  }) =>
      AuthPasswordResetReqPost(
        email: email ?? this.email,
        password: password ?? this.password,
        code: code ?? this.code,
      );

  factory AuthPasswordResetReqPost.fromJson(Map<String, dynamic> json) =>
      AuthPasswordResetReqPost(
        email: json["email"],
        password: json["password"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "code": code,
      };
}
