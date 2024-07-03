import 'package:mindsight_admin_page/data/base_model.dart';

class ChallengesModel extends BaseModel {
  List<String>? id;
  List<String>? goal;
  List<String>? name;
  List<int>? participants;
  List<int>? finished;
  List<int>? liked;
  bool? status;
  List<int>? total;

  ChallengesModel({
    this.id,
    this.participants,
    this.finished,
    this.name,
    this.liked,
    this.status,
    this.total,
  });

  ChallengesModel copyWith({
    List<String>? id,
    List<int>? participants,
    List<int>? finished,
    List<String>? name,
    List<int>? liked,
    bool? status,
    List<int>? total,
  }) =>
      ChallengesModel(
          id: id ?? this.id,
          participants: participants ?? this.participants,
          finished: finished ?? this.finished,
          name: name ?? this.name,
          liked: liked ?? this.liked,
          status: status ?? this.status,
          total: total ?? this.total);

  factory ChallengesModel.fromJson(Map<String, dynamic> json) =>
      ChallengesModel(
        id: json["id"] == null
            ? []
            : List<String>.from(json["id"]!.map((x) => x)),
        participants: json["participants"] == null
            ? []
            : List<int>.from(json["participants"]!.map((x) => x)),
        finished: json["finished"] == null
            ? []
            : List<int>.from(json["finished"]!.map((x) => x)),
        name: json["name"] == null
            ? []
            : List<String>.from(json["name"]!.map((x) => x)),
        liked: json["liked"] == null
            ? []
            : List<int>.from(json["liked"].map((x) => x)),
        status: json["status"],
        total: json["total"] == null
            ? []
            : List<int>.from(json["total"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? [] : List<dynamic>.from(id!.map((x) => x)),
        "participants": participants == null
            ? []
            : List<dynamic>.from(participants!.map((x) => x)),
        "finished":
            finished == null ? [] : List<dynamic>.from(finished!.map((x) => x)),
        "name": name == null ? [] : List<dynamic>.from(name!.map((x) => x)),
        "liked": liked == null ? [] : List<dynamic>.from(liked!.map((x) => x)),
        "status": status,
        "total": total == null ? [] : List<dynamic>.from(total!.map((x) => x)),
      };
}
