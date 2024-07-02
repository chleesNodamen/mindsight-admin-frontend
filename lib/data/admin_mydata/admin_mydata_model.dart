import 'package:mindsight_admin_page/data/base_model.dart';

class AdminMyDataModel extends BaseModel {
  String? id;
  String? department;
  String? role;
  String? manager;
  String? phone;
  String? adminEmail;
  DateTime? lastActivity;

  AdminMyDataModel({
    this.id,
    this.department,
    this.role,
    this.manager,
    this.phone,
    this.adminEmail,
    this.lastActivity,
  });

  AdminMyDataModel copyWith({
    String? id,
    String? department,
    String? role,
    String? manager,
    String? phone,
    String? adminEmail,
    DateTime? lastActivity,
  }) =>
      AdminMyDataModel(
          id: id ?? this.id,
          department: department ?? this.department,
          role: role ?? this.role,
          manager: manager ?? this.manager,
          phone: phone ?? this.phone,
          adminEmail: adminEmail ?? this.adminEmail,
          lastActivity: lastActivity ?? this.lastActivity);

  factory AdminMyDataModel.fromJson(Map<String, dynamic> json) =>
      AdminMyDataModel(
        id: json["id"],
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
        "department": department,
        "role": role,
        "manager": manager,
        "phone": phone,
        "adminEmail": adminEmail,
        "lastActivity": lastActivity?.toIso8601String(),
      };
}
