import 'dart:convert';

import 'package:bedtime/models/chat.model.dart';
import 'package:bedtime/models/chat_completion.model.dart';
import 'package:bedtime/state/conversation.state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@singleton
class HttpService {
  final Dio dio;
  final ConversationState conversationState;

  HttpService({required this.dio, required this.conversationState});

  Chat _createChatMessage(String prompt, {bool stream = false}) =>
      Chat.fromPrompt(prompt, stream: stream);

  Future<ChatCompletion> sendPrompt(String prompt) async {
    print('Prompt: $prompt');
    final chat = _createChatMessage(prompt);
    conversationState.addMessage(chat.firstMessage);
    final data = jsonEncode(chat);
    final response = await dio.post(
      dotenv.env['BASE_URL']!,
      data: data,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${dotenv.env['API_KEY']}"
        },
      ),
    );

    final chatCompletion = ChatCompletion.fromJson(response.data);
    conversationState.addMessage(chatCompletion.firstMessage);

    return chatCompletion;
  }

  Future<http.StreamedResponse> sendPromptForStream(String prompt) async {
    var url = Uri.parse(dotenv.env['BASE_URL']!);

    final chat = _createChatMessage(prompt, stream: true);
    final data = jsonEncode(chat);
    var request = http.Request('POST', url);
    request.body = data;
    request.headers["Content-Type"] = "application/json";
    request.headers["Authorization"] = "Bearer ${dotenv.env['API_KEY']}";


    return request.send();
  }
}
