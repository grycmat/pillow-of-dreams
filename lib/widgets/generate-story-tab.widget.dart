import 'dart:convert';

import 'package:bedtime/models/chat_completion.model.dart';
import 'package:bedtime/pages/generator.page.dart';
import 'package:bedtime/services/gpt.service.dart';
import 'package:bedtime/services/http.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:bedtime/injectable_initalizer.dart';
import 'package:http/http.dart';

class GenerateStoryTab extends StatefulWidget {
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
  State<GenerateStoryTab> createState() => _GenerateStoryTabState();
}

class _GenerateStoryTabState extends State<GenerateStoryTab> {
  String _text = '';

  @override
  void initState() {
    getIt.get<HttpService>().sendPromptGetStream().then((value) {
      value.stream.transform(utf8.decoder).listen((event) {
        var subs = event.substring(6);
        try {
          var json = jsonDecode(subs);
          setState(() {
            _text += json['choices'][0]['delta']['content'];
          });

        } catch (e) {
          print('not ok');
        }

      });
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(_text, style: Theme.of(context).textTheme.bodyLarge, softWrap: true),
      ),
    );
  }
}
