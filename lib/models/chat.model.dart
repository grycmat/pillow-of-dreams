import 'dart:convert';

import 'package:bedtime/models/message.model.dart';


class Chat {
  String model;
  bool? stream;
  List<Message> messages;

  Chat({required this.model, required this.messages, this.stream});

  // could be sent as array, but most of the times we need only first message
  get firstMessage => messages.first;

  factory Chat.fromPrompt(String prompt, {bool stream = false}) => Chat(
        model: "gpt-3.5-turbo",
        stream: stream,
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
        'stream': stream,
        'messages': List<dynamic>.from(
          messages.map(
            (x) => x.toJson(),
          ),
        ),
      };
}

