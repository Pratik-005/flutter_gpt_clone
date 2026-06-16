class ChatMessageModel {
  final String role;
  final String content;

  ChatMessageModel({required this.role, required this.content});

  factory ChatMessageModel.fromJson(Map<String, dynamic> message) {
    return ChatMessageModel(content: message['content'], role: message['role']);
  }

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'parts': [
        {'text': content},
      ],
    };
  }
}
