class PracticeStatusReqPut {
  List<String>? ids;
  bool? status;

  PracticeStatusReqPut({
    this.ids,
    this.status,
  });

  Map<String, dynamic> toJson() => {
        "ids": ids ?? [],
        "status": status,
      };
}
