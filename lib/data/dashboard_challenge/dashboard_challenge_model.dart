import 'package:mindsight_admin_page/data/base_model.dart';

class DashboardChallengeModel extends BaseModel {
  List<String>? id;
  List<String>? image;
  List<String>? name;
  List<String>? duration;
  List<int>? daysTotal;
  List<int>? participants;

  DashboardChallengeModel({
    this.id,
    this.image,
    this.name,
    this.duration,
    this.daysTotal,
    this.participants,
  });

  DashboardChallengeModel copyWith({
  List<String>? id,
  List<String>? image,
  List<String>? name,
  List<String>? duration,
  List<int>? daysTotal,
  List<int>? participants,
  }) =>
      DashboardChallengeModel(
        id: id ?? this.id,
        image: image ?? this.image,
        name: name ?? this.name,
        duration: duration ?? this.duration,
        daysTotal: daysTotal ?? this.daysTotal,
        participants: participants ?? this.participants,
      );

  factory DashboardChallengeModel.fromJson(Map<String, dynamic> json) =>
      DashboardChallengeModel(
        id: json["id"] == null
            ? []
            : List<String>.from(json["id"]!.map((x) => x)),
        image: json["image"] == null
            ? []
            : List<String>.from(json["image"]!.map((x) => x)),
        name: json["name"] == null
            ? []
            : List<String>.from(json["name"]!.map((x) => x)),
        duration: json["duration"] == null
            ? []
            : List<String>.from(json["duration"]!.map((x) => x)),
        daysTotal: json["daysTotal"] == null
            ? []
            : List<int>.from(json["daysTotal"]!.map((x) => x)),
        participants: json["participants"] == null
            ? []
            : List<int>.from(json["participants"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? [] : List<dynamic>.from(id!.map((x) => x)),
        "image": image == null ? [] : List<dynamic>.from(image!.map((x) => x)),
        "name": name == null ? [] : List<dynamic>.from(name!.map((x) => x)),
        "duration": duration == null ? [] : List<dynamic>.from(duration!.map((x) => x)),
        "daysTotal": daysTotal == null
            ? []
            : List<dynamic>.from(daysTotal!.map((x) => x)),
        "participants": participants == null
            ? []
            : List<dynamic>.from(participants!.map((x) => x)),
      };
}
