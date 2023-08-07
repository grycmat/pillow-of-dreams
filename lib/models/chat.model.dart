import 'dart:convert';

class Chat {
  String model;
  List<Message> messages;

  Chat({
    required this.model,
    required this.messages,
  });

  factory Chat.fromPrompt(String prompt) => Chat(
        model: "gpt-3.5-turbo",
        messages: [
          Message(role: 'user', content: prompt),
        ],
      );

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        model: json['model'],
        messages: List<Message>.from(
          json['messages'].map(
            (x) => Message.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        'model': model,
        'messages': List<dynamic>.from(
          messages.map(
            (x) => x.toJson(),
          ),
        ),
      };
}

class Message {
  String role;
  String content;

  Message({
    required this.role,
    required this.content,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        role: json['role'],
        content: json['content'],
      );

  Map<String, dynamic> toJson() => {
        'role': role,
        'content': content,
      };
}
