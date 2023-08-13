import 'dart:convert';

import 'package:bedtime/services/gpt.service.dart';
import 'package:flutter/material.dart';
import 'package:bedtime/injectable_initalizer.dart';

class GenerateStoryTab extends StatefulWidget {
  const GenerateStoryTab(
      {Key? key, this.age, this.hero, this.genre, this.companion})
      : super(key: key);
  final String? age;
  final String? genre;
  final String? companion;
  final String? hero;

  @override
  State<GenerateStoryTab> createState() => _GenerateStoryTabState();
}

class _GenerateStoryTabState extends State<GenerateStoryTab> {
  String _text = '';
  late LineSplitter _splitter;

  @override
  void initState() {
    _splitter = const LineSplitter();
    getIt
        .get<GptService>()
        .generateStory(
            age: widget.age,
            genre: widget.genre,
            companion: widget.companion,
            hero: widget.hero)
        .then((streamedResponse) {
      streamedResponse.stream.transform(utf8.decoder).listen(
        (event) {
          // sometimes two data responses can be streamed in one chunk
          List<String> splittedText = _splitter.convert(event);
          for (var element in splittedText) {
            // when splitting, last element is always empty
            if (element.isNotEmpty) {
              // remove 'data: ' from the string
              var subs = element.substring(6);
              var json = jsonDecode(subs);
              setState(() {
                _text += json['choices'][0]['delta']['content'];
              });
            }
          }
        },
        onDone: () {
          // todo let user save generated story
        },
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Text(_text,
            style: Theme.of(context).textTheme.bodyLarge, softWrap: true),
      ),
    );
  }
}
