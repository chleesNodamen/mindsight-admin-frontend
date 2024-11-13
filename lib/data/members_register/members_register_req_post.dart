class MembersRegisterReqPost {
  String? affiliation;
  String? department;
  String? position;
  String? firstName;
  String? lastName;
  String? gender;
  int? yearOfBirth;
  String? email;

  MembersRegisterReqPost({
    this.affiliation,
    this.department,
    this.position,
    this.firstName,
    this.lastName,
    this.gender,
    this.yearOfBirth,
    this.email,
  });

  MembersRegisterReqPost copyWith({
    String? affiliation,
    String? department,
    String? position,
    String? firstName,
    String? lastName,
    String? gender,
    int? yearOfBirth,
    String? email,
  }) =>
      MembersRegisterReqPost(
        affiliation: affiliation ?? this.affiliation,
        department: department ?? this.department,
        position: position ?? this.position,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        gender: gender ?? this.gender,
        yearOfBirth: yearOfBirth ?? this.yearOfBirth,
        email: gender ?? this.email,
      );

  factory MembersRegisterReqPost.fromJson(Map<String, dynamic> json) =>
      MembersRegisterReqPost(
        affiliation: json["affiliation"],
        department: json["department"],
        position: json["position"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        gender: json["gender"],
        yearOfBirth: json["yearOfBirth"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "affiliation": affiliation,
        "department": department,
        "position": position,
        "firstName": firstName,
        "lastName": lastName,
        "gender": gender,
        "yearOfBirth": yearOfBirth,
        "email": email,
      };
}
