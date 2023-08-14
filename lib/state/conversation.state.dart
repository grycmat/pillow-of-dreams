import 'package:injectable/injectable.dart';

import 'package:bedtime/models/message.model.dart';

@singleton
class ConversationState {
  final List<Message> _messages = [];

  List<Message> get messages => _messages;

  void addMessage(Message message) {
    _messages.add(message);
  }
}