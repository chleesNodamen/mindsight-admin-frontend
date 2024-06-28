import 'package:mindsight_admin_page/data/activity_chat.dart/chat_log.dart';
import 'package:mindsight_admin_page/data/base_model.dart';

class ActivityChatModel extends BaseModel {
  String? reaction;
  DateTime? createdAt;
  List<ChatLog>? chatlog;

  ActivityChatModel({
    this.reaction,
    this.createdAt,
    this.chatlog,
  });

  ActivityChatModel copyWith({
    String? reaction,
    String? id,
    String? type,
    DateTime? createdAt,
    List<ChatLog>? chatlog,
  }) =>
      ActivityChatModel(
        reaction: reaction ?? this.reaction,
        createdAt: createdAt ?? this.createdAt,
        chatlog: chatlog ?? this.chatlog,
      );

  factory ActivityChatModel.fromJson(Map<String, dynamic> json) =>
      ActivityChatModel(
        reaction: json["reaction"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        chatlog: json["chatlog"] == null
            ? []
            : List<ChatLog>.from(
                json["chatlog"]!.map((x) => ChatLog.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "reaction": reaction,
        "createdAt": createdAt?.toIso8601String(),
        "chatlog": chatlog == null
            ? []
            : List<dynamic>.from(chatlog!.map((x) => x.toJson())),
      };
}
