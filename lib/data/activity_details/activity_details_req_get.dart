class ActivityDetailsReqGet {
  String? type;

  ActivityDetailsReqGet({
    this.type,
  });

  ActivityDetailsReqGet copyWith({String? type}) =>
      ActivityDetailsReqGet(type: type ?? this.type);

  factory ActivityDetailsReqGet.fromJson(Map<String, dynamic> json) =>
      ActivityDetailsReqGet(type: json["type"]);

  Map<String, dynamic> toJson() =>
      {"type": type}.map((key, value) => MapEntry(key, value.toString()));
}
