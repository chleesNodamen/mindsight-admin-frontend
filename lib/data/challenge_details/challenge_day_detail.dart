class ChallengeDayDetailDto {
  String? id;
  int? day;
  String? name;
  List<String>? contents;

  ChallengeDayDetailDto({
    this.id,
    this.day,
    this.name,
    this.contents,
  });

  ChallengeDayDetailDto copyWith({
    String? id,
    int? day,
    String? name,
    List<String>? contents,
  }) =>
      ChallengeDayDetailDto(
        id: id ?? this.id,
        day: day ?? this.day,
        name: name ?? this.name,
        contents: contents ?? this.contents,
      );

  factory ChallengeDayDetailDto.fromJson(Map<String, dynamic> json) =>
      ChallengeDayDetailDto(
        id: json["id"],
        day: json["day"],
        name: json["name"],
        contents: json["contents"] == null
            ? []
            : List<String>.from(json["contents"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "day": day,
        "name": name,
        "contents":
            contents == null ? [] : List<dynamic>.from(contents!.map((x) => x)),
      };
}
