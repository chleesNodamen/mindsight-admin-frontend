class MemberEditReqPut {
  String? affiliation;
  String? department;
  String? position;
  String? firstName;
  String? lastName;
  String? username;
  String? gender;
  int? yearOfBirth;

  MemberEditReqPut({
    this.affiliation,
    this.department,
    this.position,
    this.firstName,
    this.lastName,
    this.username,
    this.gender,
    this.yearOfBirth,
  });

  Map<String, dynamic> toJson() => {
        "affiliation": affiliation,
        "department": department,
        "position": position,
        "firstName": firstName,
        "lastName": lastName,
        "username": username,
        "gender": gender,
        "yearOfBirth": yearOfBirth,
      };
}
