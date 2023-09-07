import 'dart:async';
import 'dart:convert';

import 'package:bedtime/injectable_initalizer.dart';
import 'package:bedtime/main.dart';
import 'package:bedtime/models/state/story.state.dart';
import 'package:bedtime/services/gpt.service.dart';
import 'package:bedtime/widgets/save-story-dialog.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:isar/isar.dart';

import '../generated/l10n.dart';

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

class _GenerateStoryTabState extends State<GenerateStoryTab> {String _text = '';
  late LineSplitter _splitter;
  StreamSubscription<String>? listener;

  @override
  void initState() {
    _splitter = const LineSplitter();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      getIt
          .get<GptService>()
          .generateStory(
              locale: widget.locale,
              age: widget.age,
              genre: widget.genre,
              companion: widget.companion,
              hero: widget.hero)
          .then((streamedResponse) {
        listener = streamedResponse.stream.transform(utf8.decoder).listen(
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
            _showSaveBanner(context);
          },
        );
      });
    });

    super.initState();
  }

  @override
  dispose() {
    listener?.cancel();

    super.dispose();
  }

  ScaffoldFeatureController<MaterialBanner, MaterialBannerClosedReason>
      _showSaveBanner(BuildContext context) {

    return ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        content: Text(S.of(context).doYouWantToSave),
        actions: [
          IconButton(
            onPressed: () => showDialog(
              context: context,
              builder: (_) => SaveStoryDialog(text: _text),
            ),
            icon: const Icon(Icons.save_alt),
          ),
        ],
      ),
    );
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
}
