import 'package:mindsight_admin_page/data/base_model.dart';

class ChallengesListModel extends BaseModel {
  List<String>? id;
  List<String>? goal;
  List<String>? name;
  List<int>? participants;
  List<int>? finished;
  List<int>? liked;
  List<bool>? status;
  List<bool>? exposure;
  int? total;

  ChallengesListModel({
    this.id,
    this.goal,
    this.name,
    this.participants,
    this.finished,
    this.liked,
    this.status,
    this.exposure,
    this.total,
  });

  ChallengesListModel copyWith({
    List<String>? id,
    List<String>? goal,
    List<String>? name,
    List<int>? participants,
    List<int>? finished,
    List<int>? liked,
    List<bool>? status,
    List<bool>? exposure,
    int? total,
  }) =>
      ChallengesListModel(
          id: id ?? this.id,
          goal: goal ?? this.goal,
          name: name ?? this.name,
          participants: participants ?? this.participants,
          finished: finished ?? this.finished,
          liked: liked ?? this.liked,
          status: status ?? this.status,
          exposure: exposure ?? this.exposure,
          total: total ?? this.total);

  factory ChallengesListModel.fromJson(Map<String, dynamic> json) =>
      ChallengesListModel(
        id: json["id"] == null
            ? []
            : List<String>.from(json["id"]!.map((x) => x)),
        goal: json["goal"] == null
            ? []
            : List<String>.from(json["goal"]!.map((x) => x)),
        name: json["name"] == null
            ? []
            : List<String>.from(json["name"]!.map((x) => x)),
        participants: json["participants"] == null
            ? []
            : List<int>.from(json["participants"]!.map((x) => x)),
        finished: json["finished"] == null
            ? []
            : List<int>.from(json["finished"]!.map((x) => x)),
        liked: json["liked"] == null
            ? []
            : List<int>.from(json["liked"].map((x) => x)),
        status: json["status"] == null
            ? []
            : List<bool>.from(json["status"]!.map((x) => x)),
        exposure: json["exposure"] == null
            ? []
            : List<bool>.from(json["exposure"]!.map((x) => x)),
        total: json["total"],
      );
}
