class AdminEditReqPut {
  String? department;
  String? role;
  String? manager;
  String? phone;
  String? adminEmail;

  AdminEditReqPut({
    this.department,
    this.role,
    this.manager,
    this.phone,
    this.adminEmail,
  });

  AdminEditReqPut copyWith({
    String? department,
    String? role,
    String? manager,
    String? phone,
    String? adminEmail,
  }) =>
      AdminEditReqPut(
        department: department ?? this.department,
        role: role ?? this.role,
        manager: manager ?? this.manager,
        phone: phone ?? this.phone,
        adminEmail: adminEmail ?? this.adminEmail,
      );

  factory AdminEditReqPut.fromJson(Map<String, dynamic> json) =>
      AdminEditReqPut(
        department: json["department"],
        role: json["role"],
        manager: json["manager"],
        phone: json["phone"],
        adminEmail: json["adminEmail"],
      );

  Map<String, dynamic> toJson() => {
        "department": department,
        "role": role,
        "manager": manager,
        "phone": phone,
        "adminEmail": adminEmail,
      };
}
