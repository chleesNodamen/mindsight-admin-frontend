class AdminRegisterReqPost {
  String? id;
  String? email;
  String? password;
  String? department;
  String? role;
  String? manager;
  String? phone;
  String? adminEmail;

  AdminRegisterReqPost({
    this.id,
    this.email,
    this.password,
    this.department,
    this.role,
    this.manager,
    this.phone,
    this.adminEmail,
  });

  AdminRegisterReqPost copyWith(
          {String? id,
          String? email,
          String? password,
          String? department,
          String? role,
          String? manager,
          String? phone,
          String? adminEmail}) =>
      AdminRegisterReqPost(
        id: id ?? this.id,
        email: email ?? this.email,
        password: password ?? this.password,
        department: department ?? this.department,
        role: role ?? this.role,
        manager: manager ?? this.manager,
        phone: phone ?? this.phone,
        adminEmail: adminEmail ?? this.adminEmail,
      );

  factory AdminRegisterReqPost.fromJson(Map<String, dynamic> json) =>
      AdminRegisterReqPost(
        id: json["id"],
        email: json["email"],
        password: json["password"],
        department: json["department"],
        role: json["role"],
        manager: json["manager"],
        phone: json["phone"],
        adminEmail: json["adminEmail"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "password": password,
        "department": department,
        "role": role,
        "manager": manager,
        "phone": phone,
        "adminEmail": adminEmail
      };
}
