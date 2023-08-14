import 'package:bedtime/models/chat_completion.model.dart';
import 'package:bedtime/services/http.service.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

@singleton
class GptService {
  final HttpService http;

  GptService({required this.http});

  Future<StreamedResponse> generateStory(
      {String? age, String? genre, String? hero, String? companion}) async {
    final response = await http.sendPromptForStream(
        age: age, hero: hero, genre: genre, companion: companion);

    return response;
  }

  Future<ChatCompletion> getHeroOptions(String age, String genre) async {
    final response = await http.sendPrompt(
        "Answer as simple as possible. Create some heroes for bedtime story of genre $genre for child in age range $age. Answer in format 'name - few words of description'. Do not add comment");

    return response;
  }

  Future<ChatCompletion> getHeroCompanionOptions(
      String age, String genre, String hero) async {
    final response = await http.sendPrompt(
        "Answer as simple as possible. Create some companions for hero $hero of bedtime story of genre $genre for child in age range $age. Answer in format 'name - few words of description', separate with commas, not as list. Do not add comment");

    return response;
  }
}
