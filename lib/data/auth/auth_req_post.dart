class AuthReqPost {
  String? email;
  String? password;

  AuthReqPost({
    this.email,
    this.password,
  });

  AuthReqPost copyWith({
    String? email,
    String? password,
  }) =>
      AuthReqPost(
        email: email ?? this.email,
        password: password ?? this.password,
      );

  factory AuthReqPost.fromJson(Map<String, dynamic> json) =>
      AuthReqPost(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
