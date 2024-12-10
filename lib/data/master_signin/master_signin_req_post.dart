class MasterSigninReqPost {
  String? email;
  String? password;

  MasterSigninReqPost({
    this.email,
    this.password,
  });

  MasterSigninReqPost copyWith({
    String? email,
    String? password,
  }) =>
      MasterSigninReqPost(
        email: email ?? this.email,
        password: password ?? this.password,
      );

  factory MasterSigninReqPost.fromJson(Map<String, dynamic> json) =>
      MasterSigninReqPost(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
