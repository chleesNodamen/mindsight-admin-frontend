class AdminPasswordReqPut {
  String? previousPassword;
  String? newPassword;

  AdminPasswordReqPut({
    this.previousPassword,
    this.newPassword,
  });

  AdminPasswordReqPut copyWith({
    String? previousPassword,
    String? newPassword,
  }) =>
      AdminPasswordReqPut(
        previousPassword: previousPassword ?? this.previousPassword,
        newPassword: newPassword ?? this.newPassword,
      );

  factory AdminPasswordReqPut.fromJson(Map<String, dynamic> json) =>
      AdminPasswordReqPut(
        previousPassword: json["previousPassword"],
        newPassword: json["newPassword"],
      );

  Map<String, dynamic> toJson() => {
        "previousPassword": previousPassword,
        "newPassword": newPassword,
      };
}
