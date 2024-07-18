import 'package:mindsight_admin_page/data/base_model.dart';

class MembersDataModel extends BaseModel {
  String? id;
  String? affiliation;
  String? department;
  String? position;
  String? firstName;
  String? lastName;
  String? gender;
  int? yearOfBirth;
  DateTime? createdAt;
  DateTime? lastLogin;
  String? username;
  String? email;
  int? mindfulStreak;
  int? mindfulDays;
  int? sessionsCompleted;
  int? minutesMeditated;

  MembersDataModel({
    this.id,
    this.affiliation,
    this.department,
    this.position,
    this.firstName,
    this.lastName,
    this.gender,
    this.yearOfBirth,
    this.createdAt,
    this.lastLogin,
    this.username,
    this.email,
    this.mindfulStreak,
    this.mindfulDays,
    this.sessionsCompleted,
    this.minutesMeditated,
  });

  MembersDataModel copyWith({
    String? id,
    String? affiliation,
    String? department,
    String? position,
    String? firstName,
    String? lastName,
    String? gender,
    int? yearOfBirth,
    DateTime? createdAt,
    DateTime? lastLogin,
    String? username,
    String? email,
    int? mindfulStreak,
    int? mindfulDays,
    int? sessionsCompleted,
    int? minutesMeditated,
  }) =>
      MembersDataModel(
        id: id ?? this.id,
        affiliation: affiliation ?? this.affiliation,
        department: department ?? this.department,
        position: position ?? this.position,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        gender: gender ?? this.gender,
        yearOfBirth: yearOfBirth ?? this.yearOfBirth,
        createdAt: createdAt ?? this.createdAt,
        lastLogin: lastLogin ?? this.lastLogin,
        username: username ?? this.username,
        email: email ?? this.email,
        mindfulStreak: mindfulStreak ?? this.mindfulStreak,
        mindfulDays: mindfulDays ?? this.mindfulDays,
        sessionsCompleted: sessionsCompleted ?? this.sessionsCompleted,
        minutesMeditated: minutesMeditated ?? this.minutesMeditated,
      );

  factory MembersDataModel.fromJson(Map<String, dynamic> json) =>
      MembersDataModel(
        id: json["id"],
        affiliation: json["affiliation"],
        department: json["department"],
        position: json["position"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        gender: json["gender"],
        yearOfBirth: json["yearOfBirth"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        lastLogin: json["lastLogin"] == null
            ? null
            : DateTime.parse(json["lastLogin"]),
        username: json["username"],
        email: json["email"],
        mindfulStreak: json["mindfulStreak"],
        mindfulDays: json["mindfulDays"],
        sessionsCompleted: json["sessionsCompleted"],
        minutesMeditated: json["minutesMeditated"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "affiliation": affiliation,
        "department": department,
        "position": position,
        "firstName": firstName,
        "lastName": lastName,
        "gender": gender,
        "yearOfBirth": yearOfBirth,
        "createdAt": createdAt!.toIso8601String(),
        "lastLogin": lastLogin!.toIso8601String(),
        "username": username,
        "email": email,
        "mindfulStreak": mindfulStreak,
        "mindfulDays": mindfulDays,
        "sessionsCompleted": sessionsCompleted,
        "minutesMeditated": minutesMeditated,
      };
}
