import 'package:mindsight_admin_page/data/challenge_details/challenge_day_detail.dart';

class ChallengeEditReqPut {
  String? name;
  String? goal;
  List<ChallengeDayDetailDto>? days;
  String? thumbnail;

  ChallengeEditReqPut({
    this.name,
    this.goal,
    this.days,
    this.thumbnail,
  });

  ChallengeEditReqPut copyWith({
    String? name,
    String? goal,
    List<ChallengeDayDetailDto>? days,
    String? thumbnail,
  }) =>
      ChallengeEditReqPut(
        name: name ?? this.name,
        goal: goal ?? this.goal,
        days: days ?? this.days,
        thumbnail: thumbnail ?? this.thumbnail,
      );

  factory ChallengeEditReqPut.fromJson(Map<String, dynamic> json) =>
      ChallengeEditReqPut(
        name: json["name"],
        goal: json["goal"],
        days: json["days"] == null
            ? []
            : List<ChallengeDayDetailDto>.from(json["days"].map((x) => x)),
        thumbnail: json["thumbnail"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "goal": goal,
        "days": days == null ? [] : List<dynamic>.from(days!.map((x) => x)),
        "thumbnail": thumbnail,
      };
}
