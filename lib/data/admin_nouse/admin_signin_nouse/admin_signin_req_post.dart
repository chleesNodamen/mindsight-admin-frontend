// class AdminSigninReqPost {
//   String? email;
//   String? password;

//   AdminSigninReqPost({
//     this.email,
//     this.password,
//   });

//   AdminSigninReqPost copyWith({
//     String? email,
//     String? password,
//   }) =>
//       AdminSigninReqPost(
//         email: email ?? this.email,
//         password: password ?? this.password,
//       );

//   factory AdminSigninReqPost.fromJson(Map<String, dynamic> json) =>
//       AdminSigninReqPost(
//         email: json["email"],
//         password: json["password"],
//       );

//   Map<String, dynamic> toJson() => {
//         "email": email,
//         "password": password,
//       };
// }
