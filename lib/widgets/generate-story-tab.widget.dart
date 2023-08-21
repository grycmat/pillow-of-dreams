import 'dart:convert';

import 'package:bedtime/injectable_initalizer.dart';
import 'package:bedtime/main.dart';
import 'package:bedtime/models/state/story.state.dart';
import 'package:bedtime/services/gpt.service.dart';
import 'package:flutter/material.dart';

class GenerateStoryTab extends StatefulWidget {
  const GenerateStoryTab(
      {Key? key,
      required this.locale,
      this.age,
      this.hero,
      this.genre,
      this.companion})
      : super(key: key);
  final Locale locale;
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
            locale: widget.locale,
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
                _text += _getDelta(json);
              });
            }
          }
        },
        onDone: () {
          ScaffoldMessenger.of(context).showMaterialBanner(
            MaterialBanner(
              content: Text('Story generated!'),
              actions: [
                IconButton(
                  onPressed: _save,
                  icon: Icon(Icons.save_alt),
                ),
              ],
            ),
          );
        },
      );
    });

    super.initState();
  }

  _getDelta(dynamic json) => json['choices'][0]['delta']['content'];

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

  void _save() {
    var story = StoryState()..content = _text;
    isar!.storyStates
        .put(story)
        .then((value) => ScaffoldMessenger.of(context).clearMaterialBanners());
  }
}
