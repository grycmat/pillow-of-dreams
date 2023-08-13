import 'package:bedtime/models/chat_completion.model.dart';
import 'package:injectable/injectable.dart';

@singleton
class ConversationState {
  final List<Message> _messages = [];

  List<Message> get messages => _messages;

  void addMessage(Message message) {
    _messages.add(message);
  }
}