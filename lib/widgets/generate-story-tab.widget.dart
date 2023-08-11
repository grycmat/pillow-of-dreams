import 'package:bedtime/models/chat_completion.model.dart';
import 'package:bedtime/pages/generator.page.dart';
import 'package:bedtime/services/gpt.service.dart';
import 'package:bedtime/services/http.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:bedtime/injectable_initalizer.dart';
import 'package:http/http.dart';

class GenerateStoryTab extends StatelessWidget {
  const GenerateStoryTab(
      {Key? key,
      required this.age,
      required this.genre,
      required this.companion})
      : super(key: key);
  final Age? age;
  final Genre? genre;
  final Companion? companion;

  @override
  Widget build(BuildContext context) {
    print("Generating story for $age, $genre, $companion");
  return Center(child: FutureBuilder(
    future: getIt.get<HttpService>().sendPromptGetStream(),
    builder: (context, AsyncSnapshot<StreamedResponse> snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        print(snapshot.data);
        snapshot.data!.stream.listen((value) {
          print(value);
        });
      }

      return Container();
    },
  ),);
    // return Center(
    //   child: FutureBuilder(
    //     future: getIt.get<GptService>().generateStory(
    //         age: '2-3', genre: 'fantasy', companion: 'brave lion'),
    //     builder: (_, AsyncSnapshot<ChatCompletion> snapshot) {
    //       print(snapshot.connectionState);
    //       print(snapshot.data);
    //       if (snapshot.connectionState == ConnectionState.done &&
    //           snapshot.hasData) {
    //         return SingleChildScrollView(
    //           child: Padding(
    //             padding: const EdgeInsets.all(12.0),
    //             child: Text(
    //               snapshot.data!.choices[0].message.content,
    //               style: Theme.of(context).textTheme.displayMedium,
    //             ),
    //           ),
    //         );
    //       }
    //       return const SpinKitPumpingHeart(
    //         color: Colors.amber,
    //         duration: Duration(milliseconds: 800),
    //       );
    //     },
    //   ),
    // );
  }
}
