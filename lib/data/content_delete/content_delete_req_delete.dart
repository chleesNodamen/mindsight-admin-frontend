class AdminDeleteReqDelete {
  String? contentId;

  AdminDeleteReqDelete({
    this.contentId,
  });

  AdminDeleteReqDelete copyWith({
    String? contentId,
  }) =>
      AdminDeleteReqDelete(
        contentId: contentId ?? this.contentId,
      );

  factory AdminDeleteReqDelete.fromJson(Map<String, dynamic> json) =>
      AdminDeleteReqDelete(
        contentId: json["contentId"],
      );

  Map<String, dynamic> toJson() => {
        "contentId": contentId,
      };
}
