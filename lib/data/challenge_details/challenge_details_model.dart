import 'package:mindsight_admin_page/data/base_model.dart';

class ChallengeDetailDay {
  String? id;
  int? day;
  String? name;
  List<String>? contentNames;

  ChallengeDetailDay({
    required this.id,
    required this.day,
    required this.name,
    required this.contentNames,
  });

  factory ChallengeDetailDay.fromJson(Map<String, dynamic> json) {
    return ChallengeDetailDay(
      id: json['id'] as String,
      day: json['day'] as int,
      name: json['name'] as String,
      contentNames: json['contentNames'] != null
          ? List<String>.from(json['contentNames'])
          : [],
    );
  }
}

class ChallengeDetailsModel extends BaseModel {
  String? id;
  String? name;
  String? goal;
  int? duration;
  String? intro;
  List<ChallengeDetailDay>? days;
  String? thumbnail;
  String? masterNickname;
  int? participants;
  int? challengers;
  int? completed;
  double? rating;
  bool? status;
  bool? exposure;

  ChallengeDetailsModel({
    this.id,
    this.name,
    this.goal,
    this.duration,
    this.intro,
    this.days,
    this.thumbnail,
    this.masterNickname,
    this.participants,
    this.challengers,
    this.completed,
    this.status,
    this.exposure,
    this.rating,
  });

  factory ChallengeDetailsModel.fromJson(Map<String, dynamic> json) =>
      ChallengeDetailsModel(
        id: json["id"],
        name: json["name"],
        goal: json["goal"],
        duration: json["duration"],
        intro: json["intro"],
        days: json["days"] == null
            ? []
            : List<ChallengeDetailDay>.from(
                json["days"]!.map((x) => ChallengeDetailDay.fromJson(x))),
        thumbnail: json["thumbnail"],
        masterNickname: json["masterNickname"],
        participants: json["participants"],
        challengers: json["challengers"],
        completed: json["completed"],
        rating: json["rating"],
        status: json["status"],
        exposure: json["exposure"],
      );
}
