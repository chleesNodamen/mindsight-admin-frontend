import 'package:intl/intl.dart';
import 'package:mindsight_admin_page/data/base_model.dart';

class ActivityDetailsModel extends BaseModel {
  String? id;
  String? email;
  String? username;
  DateTime? registrationDate;
  String? level;
  String? body;
  String? breath;
  String? title;
  String? goal;
  String? days;
  String? intro;
  String? type;
  String? recordOne;
  String? recordTwo;
  String? sessionId;
  DateTime? sessionStartDate;
  DateTime? sessionEndDate;
  String? chatbot;
  String? expertMessage;
  DateTime? expertMessageDate;

  ActivityDetailsModel({
    this.id,
    this.email,
    this.username,
    this.registrationDate,
    this.level,
    this.body,
    this.breath,
    this.title,
    this.goal,
    this.days,
    this.intro,
    this.type,
    this.recordOne,
    this.recordTwo,
    this.sessionId,
    this.sessionStartDate,
    this.sessionEndDate,
    this.chatbot,
    this.expertMessage,
    this.expertMessageDate,
  });

  ActivityDetailsModel copyWith(
          {String? id,
          String? email,
          String? username,
          DateTime? registrationDate,
          String? level,
          String? body,
          String? breath,
          String? title,
          String? goal,
          String? days,
          String? intro,
          String? type,
          String? recordOne,
          String? recordTwo,
          String? sessionId,
          DateTime? sessionStartDate,
          DateTime? sessionEndDate,
          String? chatbot,
          String? expertMessage,
          DateTime? expertMessageDate}) =>
      ActivityDetailsModel(
        id: id ?? this.id,
        email: email ?? this.email,
        username: username ?? this.username,
        registrationDate: registrationDate ?? this.registrationDate,
        level: level ?? this.level,
        body: body ?? this.body,
        breath: breath ?? this.breath,
        title: title ?? this.title,
        goal: goal ?? this.goal,
        days: days ?? this.days,
        intro: intro ?? this.intro,
        type: type ?? this.type,
        recordOne: recordOne ?? this.recordOne,
        recordTwo: recordTwo ?? this.recordTwo,
        sessionId: sessionId ?? this.sessionId,
        sessionStartDate: sessionStartDate ?? this.sessionStartDate,
        sessionEndDate: sessionEndDate ?? this.sessionEndDate,
        chatbot: chatbot ?? this.chatbot,
        expertMessage: expertMessage ?? this.expertMessage,
        expertMessageDate: expertMessageDate ?? this.expertMessageDate,
      );

  factory ActivityDetailsModel.fromJson(Map<String, dynamic> json) =>
      ActivityDetailsModel(
        id: json["id"],
        email: json["email"],
        username: json["username"],
        registrationDate: json["registrationDate"] == null
            ? null
            : DateTime.parse(json["registrationDate"]),
        level: json["level"],
        body: json["body"],
        breath: json["breath"],
        title: json["title"],
        goal: json["goal"],
        days: json["days"],
        intro: json["intro"],
        type: json["type"],
        recordOne: json["recordOne"],
        recordTwo: json["recordTwo"],
        sessionId: json["sessionId"],
        sessionStartDate: json["sessionStartDate"] == null
            ? null
            : DateTime.parse(json["sessionStartDate"]),
        sessionEndDate: json["sessionEndDate"] == null
            ? null
            : DateTime.parse(json["sessionEndDate"]),
        chatbot: json["chatbot"],
        expertMessage: json["expertMessage"],
        expertMessageDate: json["expertMessageDate"] == null
            ? null
            : DateTime.parse(json["expertMessageDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "username": username,
        "registrationDate": registrationDate?.toIso8601String(),
        "level": level,
        "body": body,
        "breath": breath,
        "title": title,
        "goal": goal,
        "days": days,
        "intro": intro,
        "type": type,
        "recordOne": recordOne,
        "recordTwo": recordTwo,
        "sessionId": sessionId,
        "sessionStartDate": sessionStartDate?.toIso8601String(),
        "sessionEndDate": sessionEndDate?.toIso8601String(),
        "chatbot": chatbot,
        "expertMessage": expertMessage,
        "expertMessageDate": expertMessageDate?.toIso8601String(),
      };
}
