import 'package:mindsight_admin_page/data/base_model.dart';

class AdminDetailsModel extends BaseModel {
  String? id;
  String? email;
  String? department;
  String? role;
  String? manager;
  String? phone;
  String? adminEmail;
  DateTime? lastActivity;
  AdminDetailsModel(
      {this.id,
      this.email,
      this.department,
      this.role,
      this.manager,
      this.phone,
      this.adminEmail,
      this.lastActivity});

  AdminDetailsModel copyWith({
    String? id,
    String? email,
    String? department,
    String? role,
    String? manager,
    String? phone,
    String? adminEmail,
    DateTime? lastActivity,
  }) =>
      AdminDetailsModel(
        id: id ?? this.id,
        email: email ?? this.email,
        department: department ?? this.department,
        role: role ?? this.role,
        manager: manager ?? this.manager,
        phone: phone ?? this.phone,
        adminEmail: adminEmail ?? this.adminEmail,
        lastActivity: lastActivity ?? this.lastActivity,
      );

  factory AdminDetailsModel.fromJson(Map<String, dynamic> json) =>
      AdminDetailsModel(
        id: json["id"],
        email: json["email"],
        department: json["department"],
        role: json["role"],
        manager: json["manager"],
        phone: json["phone"],
        adminEmail: json["adminEmail"],
        lastActivity: json["lastActivity"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "department": department,
        "role": role,
        "manager": manager,
        "phone": phone,
        "adminEmail": adminEmail,
        "lastActivity": lastActivity?.toIso8601String(),
      };
}
