import 'package:mindsight_admin_page/data/base_model.dart';
import 'package:mindsight_admin_page/data/challenge_details/challenge_day_detail.dart';

class ChallengeDetailsModel extends BaseModel {
  String? id;
  String? name;
  String? goal;
  int? duration;
  String? intro;
  List<ChallengeDayDetailDto>? days;
  String? thumbnail;
  int? participants;
  int? challengers;
  int? completed;
  double? rating;

  ChallengeDetailsModel({
    this.id,
    this.name,
    this.goal,
    this.duration,
    this.intro,
    this.days,
    this.thumbnail,
    this.participants,
    this.challengers,
    this.completed,
    this.rating,
  });

  ChallengeDetailsModel copyWith({
    String? id,
    String? name,
    String? goal,
    int? duration,
    String? intro,
    List<ChallengeDayDetailDto>? days,
    String? thumbnail,
    int? participants,
    int? challengers,
    int? completed,
    double? rating,
  }) =>
      ChallengeDetailsModel(
        id: id ?? this.id,
        name: name ?? this.name,
        goal: goal ?? this.goal,
        duration: duration ?? this.duration,
        intro: intro ?? this.intro,
        days: days ?? this.days,
        thumbnail: thumbnail ?? this.thumbnail,
        participants: participants ?? this.participants,
        challengers: challengers ?? this.challengers,
        completed: completed ?? this.completed,
        rating: rating ?? this.rating,
      );

  factory ChallengeDetailsModel.fromJson(Map<String, dynamic> json) =>
      ChallengeDetailsModel(
        id: json["id"],
        name: json["name"],
        goal: json["goal"],
        duration: json["duration"],
        intro: json["intro"],
        days: json["days"] == null
            ? []
            : List<ChallengeDayDetailDto>.from(
                json["days"]!.map((x) => ChallengeDayDetailDto.fromJson(x))),
        thumbnail: json["thumbnail"],
        participants: json["participants"],
        challengers: json["challengers"],
        completed: json["completed"],
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "goal": goal,
        "duration": duration,
        "intro": intro,
        "days": days == null ? [] : List<dynamic>.from(days!.map((x) => x)),
        "thumbnail": thumbnail,
        "participants": participants,
        "challengers": challengers,
        "completed": completed,
        "rating": rating,
      };
}
