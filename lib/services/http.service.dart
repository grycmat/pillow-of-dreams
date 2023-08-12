import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bedtime/models/chat.model.dart';
import 'package:bedtime/models/chat_completion.model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

@singleton
class HttpService {
  final Dio dio;

  HttpService({required this.dio});

  Chat _createChatMessage(String prompt, {bool stream = false}) => Chat.fromPrompt(prompt, stream: stream);

  Future<ChatCompletion> sendPrompt(String prompt) async {
      final chat = _createChatMessage(prompt);
      final data = jsonEncode(chat);
      final response = await dio.post(dotenv.env['BASE_URL']!,
          data: data,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${dotenv.env['API_KEY']}"
          }));
      final chatCompletion = ChatCompletion.fromJson(response.data);

      return chatCompletion;

  }
  
   Future<http.StreamedResponse> sendPromptForStream() async {
    var url = Uri.parse(dotenv.env['BASE_URL']!);

    final chat = _createChatMessage("Write me a bedtime story about a dragon who is very small", stream: true);
    final data = jsonEncode(chat);
    var request = http.Request('POST', url);
    request.body = data;
    request.headers["Content-Type"] = "application/json";
    request.headers["Authorization"] = "Bearer ${dotenv.env['API_KEY']}";

    return request.send();
  }
}
