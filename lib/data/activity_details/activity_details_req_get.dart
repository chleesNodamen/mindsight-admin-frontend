class ActivityDetailsReqGet {
  String? type;

  ActivityDetailsReqGet({
    this.type,
  });

  Map<String, dynamic> toJson() => {"type": type};
}
