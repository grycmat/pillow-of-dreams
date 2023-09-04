import 'dart:ui';

import 'package:bedtime/models/chat_completion.model.dart';
import 'package:bedtime/services/http.service.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

@singleton
class GptService {
  final HttpService http;

  GptService({required this.http});

  Future<StreamedResponse> generateStory(
      {required Locale locale,
      String? age,
      String? genre,
      String? hero,
      String? companion}) async {
    final prompt = locale.toString() == 'pl'
        ? "Napisz bajkę na dobranoc z gatunku $genre dla dziecka w wieku $age z bohaterem '$hero' i jego towarzyszem '$companion'."
        : "Write a $genre bedtime story for child of age $age with hero '$hero' and they companion '$companion'.";
    final response = await http.sendPromptForStream(prompt);

    return response;
  }

  Future<ChatCompletion> getHeroOptions(
      {required Locale locale,
      required String age,
      required String genre}) async {
    final prompt = locale.toString() == 'pl'
        ? "Odpowiedz jak najprościej. Stwórz bohaterów do bajki na dobranoc z gatunku $genre dla dziecka w wieku $age. Odpowiadaj w formacie json, gdzie klucze to 'name, description', a klucz główny to 'heroes'."
        : "Answer as simple as possible. Create some heroes for bedtime story of genre $genre for child in age range $age. Answer in json format with keys 'name, description' and root key is 'heroes.";
    final response = await http.sendPrompt(prompt);

    return response;
  }

  Future<ChatCompletion> getHeroCompanionOptions(
      {required Locale locale,
      required String age,
      required String genre,
      required String hero}) async {
    final prompt = locale.toString() == 'pl'
        ? "Odpowiedz jak najprościej. Stwórz towarzyszy dla bohatera '$hero' z bajki na dobranoc z gatunku $genre dla dziecka w wieku $age. Odpowiedz w formacie json gdzie klucze to 'name, description', a klucz główny to 'companions'."
        : "Answer as simple as possible. Create some companions for hero '$hero' of bedtime story of genre $genre for child in age range $age. Answer in json format with keys 'name, description', and root key is 'companions'. Do not add comment";
    final response = await http.sendPrompt(prompt);

    return response;
  }
}
