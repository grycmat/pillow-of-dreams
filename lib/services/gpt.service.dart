import 'package:bedtime/models/chat_completion.model.dart';
import 'package:bedtime/services/http.service.dart';
import 'package:injectable/injectable.dart';

@singleton
class GptService {
  final HttpService http;

  GptService({required this.http});

  Future<ChatCompletion> generateStory(
      {required String age,
      required String genre,
      required String companion}) async {
    final response = await http.sendPrompt(
        "Generate fantasy bedtime story for 3 year old about a superhero with a loyal friend");

    return response;
  }

  getHeroOptions() {

  }
}
