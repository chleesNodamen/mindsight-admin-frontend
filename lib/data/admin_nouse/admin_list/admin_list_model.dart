import 'package:mindsight_admin_page/data/base_model.dart';

class AdminListModel extends BaseModel {
  List<String>? id;
  List<String>? email;
  List<String>? department;
  List<String>? role;
  List<String>? manager;

  AdminListModel({
    this.id,
    this.email,
    this.department,
    this.role,
    this.manager,
  });

  AdminListModel copyWith({
    List<String>? id,
    List<String>? email,
    List<String>? department,
    List<String>? role,
    List<String>? manager,
  }) =>
      AdminListModel(
        id: id ?? this.id,
        email: email ?? this.email,
        department: department ?? this.department,
        role: role ?? this.role,
        manager: manager ?? this.manager,
      );

  factory AdminListModel.fromJson(Map<String, dynamic> json) => AdminListModel(
        id: json["id"] == null
            ? []
            : List<String>.from(json["id"]!.map((x) => x)),
        department: json["department"] == null
            ? []
            : List<String>.from(json["department"]!.map((x) => x)),
        role: json["role"] == null
            ? []
            : List<String>.from(json["role"]!.map((x) => x)),
        manager: json["manager"] == null
            ? []
            : List<String>.from(json["manager"]!.map((x) => x)),
        email: json["email"] == null
            ? []
            : List<String>.from(json["email"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? [] : List<dynamic>.from(id!.map((x) => x)),
        "department": department == null
            ? []
            : List<dynamic>.from(department!.map((x) => x)),
        "role": role == null ? [] : List<dynamic>.from(role!.map((x) => x)),
        "manager":
            manager == null ? [] : List<dynamic>.from(manager!.map((x) => x)),
        "email": email == null ? [] : List<dynamic>.from(email!.map((x) => x)),
      };
}
