class ChatLog {
  String? role;
  String? content;

  ChatLog({
    this.role,
    this.content,
  });

  ChatLog copyWith({
    String? role,
    String? content,
  }) =>
      ChatLog(
        role: role ?? this.role,
        content: content ?? this.content,
      );

  factory ChatLog.fromJson(Map<String, dynamic> json) => ChatLog(
        role: json["role"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "role": role,
        "content": content,
      };
}
