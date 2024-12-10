// lib/models/challenge_register_req.dart

class ChallengeRegisterDay {
  final int day;
  final String name;
  final List<String> contentIds;

  ChallengeRegisterDay({
    required this.day,
    required this.name,
    required this.contentIds,
  });

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'name': name,
      'contentIds': contentIds,
    };
  }
}

class ChallengeRegisterReqPost {
  final String name;
  final String goal;
  final String intro;
  final String image;
  final int days;
  final List<ChallengeRegisterDay> challengeDays;

  ChallengeRegisterReqPost({
    required this.name,
    required this.goal,
    required this.intro,
    required this.image,
    required this.days,
    required this.challengeDays,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'goal': goal,
      'intro': intro,
      'image': image,
      'days': days,
      'challengeDays': challengeDays.map((day) => day.toJson()).toList(),
    };
  }
}
