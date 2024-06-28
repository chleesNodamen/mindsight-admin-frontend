import 'package:mindsight_admin_page/data/base_model.dart';

class ActivityModel extends BaseModel {
  List<String>? type;
  List<String>? memberId;
  List<String>? email;
  List<String>? sessionId;
  List<String>? sessionName;
  List<String>? recordId;
  List<String>? record;
  List<bool>? feedback;
  int? total;

  ActivityModel({
    this.type,
    this.memberId,
    this.email,
    this.sessionId,
    this.sessionName,
    this.recordId,
    this.record,
    this.feedback,
    this.total,
  });

  ActivityModel copyWith(
          {List<String>? type,
          List<String>? memberId,
          List<String>? email,
          List<String>? sessionId,
          List<String>? sessionName,
          List<String>? recordId,
          List<String>? record,
          List<bool>? feedback,
          int? total}) =>
      ActivityModel(
        type: type ?? this.type,
        memberId: memberId ?? this.memberId,
        email: email ?? this.email,
        sessionId: sessionId ?? this.sessionId,
        sessionName: sessionName ?? this.sessionName,
        recordId: recordId ?? this.recordId,
        record: record ?? this.record,
        feedback: feedback ?? this.feedback,
        total: total ?? this.total,
      );

  factory ActivityModel.fromJson(Map<String, dynamic> json) => ActivityModel(
        type: json["type"] == null
            ? []
            : List<String>.from(json["type"]!.map((x) => x)),
        memberId: json["memberId"] == null
            ? []
            : List<String>.from(json["memberId"]!.map((x) => x)),
        email: json["email"] == null
            ? []
            : List<String>.from(json["email"]!.map((x) => x)),
        sessionId: json["sessionId"] == null
            ? []
            : List<String>.from(json["sessionId"]!.map((x) => x)),
        sessionName: json["sessionName"] == null
            ? []
            : List<String>.from(json["sessionName"]!.map((x) => x)),
        recordId: json["recordId"] == null
            ? []
            : List<String>.from(json["recordId"]!.map((x) => x)),
        record: json["record"] == null
            ? []
            : List<String>.from(json["record"]!.map((x) => x)),
        feedback: json["feedback"] == null
            ? []
            : List<bool>.from(json["feedback"]!.map((x) => x)),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? [] : List<dynamic>.from(type!.map((x) => x)),
        "memberId":
            memberId == null ? [] : List<dynamic>.from(memberId!.map((x) => x)),
        "email": email == null ? [] : List<dynamic>.from(email!.map((x) => x)),
        "sessionId": sessionId == null
            ? []
            : List<dynamic>.from(sessionId!.map((x) => x)),
        "sessionName": sessionName == null
            ? []
            : List<dynamic>.from(sessionName!.map((x) => x)),
        "recordId":
            recordId == null ? [] : List<dynamic>.from(recordId!.map((x) => x)),
        "record":
            record == null ? [] : List<dynamic>.from(record!.map((x) => x)),
        "feedback":
            feedback == null ? [] : List<dynamic>.from(feedback!.map((x) => x)),
        "total": total,
      };
}
