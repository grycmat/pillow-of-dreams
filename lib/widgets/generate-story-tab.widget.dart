import 'dart:convert';

import 'package:bedtime/injectable_initalizer.dart';
import 'package:bedtime/main.dart';
import 'package:bedtime/models/state/story.state.dart';
import 'package:bedtime/services/gpt.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
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

class _GenerateStoryTabState extends State<GenerateStoryTab> {
  late TextEditingController _storyNameController;
  String _text = '';
  late LineSplitter _splitter;

  @override
  void initState() {
    _storyNameController = TextEditingController();
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
            _showSaveBanner(context);
          },
        );
      });
    });

    super.initState();
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
              builder: (_) => Dialog(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    children: [
                      TextField(
                        controller: _storyNameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text('Name Story'),
                        ),
                      ),
                      Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              // ScaffoldMessenger.of(context)
                              //     .clearMaterialBanners();
                              context.pop();
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context)
                                  .clearMaterialBanners();
                              _save().then((_) {
                                context.pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Story Saved!'),
                                  ),
                                );
                              });
                            },
                            child: const Text('Save'),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            icon: const Icon(Icons.save_alt),
          ),
        ],
      ),
    );
  }

  _getDelta(dynamic json) => json['choices'][0]['delta']['content'];

  Future<Id> _save() async {
    final story = StoryState()
      ..content = _text
      ..name = _storyNameController.text;

    return isar!.writeTxn(() => isar!.storyStates.put(story));
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
