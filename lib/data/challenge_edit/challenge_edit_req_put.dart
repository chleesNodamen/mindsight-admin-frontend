import 'package:mindsight_admin_page/data/challenge_details/challenge_detail_days.dart';

class ChallengeEditReqPut {
  String? name;
  String? goal;
  String? intro;
  List<ChallengeDetailDays>? days;
  String? thumbnail;

  ChallengeEditReqPut({
    this.name,
    this.goal,
    this.intro,
    this.days,
    this.thumbnail,
  });

  ChallengeEditReqPut copyWith({
    String? name,
    String? goal,
    String? intro,
    List<ChallengeDetailDays>? days,
    String? thumbnail,
  }) =>
      ChallengeEditReqPut(
        name: name ?? this.name,
        goal: goal ?? this.goal,
        intro: intro ?? this.intro,
        days: days ?? this.days,
        thumbnail: thumbnail ?? this.thumbnail,
      );

  factory ChallengeEditReqPut.fromJson(Map<String, dynamic> json) =>
      ChallengeEditReqPut(
        name: json["name"],
        goal: json["goal"],
        intro: json["intro"],
        days: json["days"] == null
            ? []
            : List<ChallengeDetailDays>.from(
                json["days"].map((x) => ChallengeDetailDays.fromJson(x))),
        thumbnail: json["thumbnail"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "goal": goal,
        "intro": intro,
        "days": days ?? [],
        "thumbnail": thumbnail,
      };
}
