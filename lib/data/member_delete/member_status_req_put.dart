class MemberDeleteReqPut {
  List<String>? ids;
  bool? delete;

  MemberDeleteReqPut({
    this.ids,
    this.delete,
  });

  Map<String, dynamic> toJson() => {
        "ids": ids ?? [],
        "delete": delete,
      };
}
