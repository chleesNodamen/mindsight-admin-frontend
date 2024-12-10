class ContentStatusReqPut {
  List<String>? contentIds;
  bool? status;

  ContentStatusReqPut({
    this.contentIds,
    this.status,
  });

  Map<String, dynamic> toJson() => {
        "contentIds": contentIds ?? [],
        "status": status,
      };
}
