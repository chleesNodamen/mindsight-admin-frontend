class ChallengeEditDay {
  final String id;
  final int day;
  final String name;

  ChallengeEditDay({
    required this.id,
    required this.day,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'day': day,
      'name': name,
    };
  }
}

class ChallengeEditReqPut {
  String? name;
  String? goal;
  String? intro;
  List<ChallengeEditDay>? challengeDays;
  String? image;
  bool? status;
  bool? exposure;

  ChallengeEditReqPut({
    this.name,
    this.goal,
    this.intro,
    this.challengeDays,
    this.image,
    this.status,
    this.exposure,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "goal": goal,
        "intro": intro,
        "image": image,
        "status": status,
        "exposure": exposure,
        'challengeDays': challengeDays!.map((day) => day.toJson()).toList(),
      };
}
