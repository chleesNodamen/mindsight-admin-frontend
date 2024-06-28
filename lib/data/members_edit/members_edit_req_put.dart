class MembersEditReqPut {
  String? affiliation;
  String? department;
  String? position;
  String? firstName;
  String? lastName;
  String? gender;
  String? yearOfBirth;

  MembersEditReqPut({
    this.affiliation,
    this.department,
    this.position,
    this.firstName,
    this.lastName,
    this.gender,
    this.yearOfBirth,
  });

  MembersEditReqPut copyWith({
    String? affiliation,
    String? department,
    String? position,
    String? firstName,
    String? lastName,
    String? gender,
    String? yearOfBirth,
  }) =>
      MembersEditReqPut(
        affiliation: affiliation ?? this.affiliation,
        department: department ?? this.department,
        position: position ?? this.position,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        gender: gender ?? this.gender,
        yearOfBirth: yearOfBirth ?? this.yearOfBirth,
      );

  factory MembersEditReqPut.fromJson(Map<String, dynamic> json) =>
      MembersEditReqPut(
        affiliation: json["affiliation"],
        department: json["department"],
        position: json["position"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        gender: json["gender"],
        yearOfBirth: json["yearOfBirth"],
      );

  Map<String, dynamic> toJson() => {
        "affiliation": affiliation,
        "department": department,
        "position": position,
        "firstName": firstName,
        "lastName": lastName,
        "gender": gender,
        "yearOfBirth": yearOfBirth,
      };
}
