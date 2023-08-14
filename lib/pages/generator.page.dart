import 'dart:convert';

import 'package:bedtime/generated/l10n.dart';
import 'package:bedtime/injectable_initalizer.dart';
import 'package:bedtime/services/gpt.service.dart';
import 'package:flutter/material.dart';
import 'package:bedtime/widgets/selection-tab.widget.dart';
import 'package:bedtime/widgets/generate-story-tab.widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class GeneratorPage extends StatefulWidget {
  const GeneratorPage({Key? key}) : super(key: key);

  @override
  State<GeneratorPage> createState() => _GeneratorPageState();
}

class _GeneratorPageState extends State<GeneratorPage> {
  late final PageController _controller;
  late final LineSplitter _splitter;
  final List<String> _ageOptions = ['0-2', '3-5', '6-8', '9-12'];
  final List<String> _genreOptions = [
    'Adventure',
    'Fantasy',
    'Fairy Tale',
    'Sci-Fi',
    'Superhero',
    'Mystery'
  ];

  final List<String> _heroOptions = [];

  final List<String> _companionOptions = [];
  String? _age;
  String? _genre;
  String? _companion;
  String? _hero;
  String? _overlayText;

  @override
  void initState() {
    _splitter = const LineSplitter();
    _controller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _controller,
            children: <Widget>[
              SelectionTab(
                type: Age,
                title:
                S
                    .of(context)
                    .selectAge,
                options: _ageOptions,
                optionSelected: (age) {
                  setState(() {
                    _age = age;
                    _controller.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut);
                  });
                },
              ),
              SelectionTab(
                  type: Genre,
                  title:
                  S
                      .of(context)
                      .chooseGenre,
                  options: _genreOptions,
                  optionSelected: (genre) async {
                    setState(() {
                      _overlayText = S
                          .of(context)
                          .summoningHero;
                    });
                    final heroOptionsResponse = await getIt
                        .get<GptService>()
                        .getHeroOptions(_age!, genre);
                      _heroOptions.addAll(_splitter.convert(heroOptionsResponse.firstMessage.content));
                    setState(() {
                      _genre = genre;
                      _overlayText = null;
                      _controller.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut);
                    });
                  }),
              SelectionTab(
                  type: Genre,
                  title:
                  S
                      .of(context)
                      .discoverHero,
                  options: _heroOptions,
                  optionSelected: (hero) async {
                    setState(() {
                      _overlayText = S
                          .of(context)
                          .gatheringCompanions;
                    });
                    final companionOptionsResponse = await getIt
                        .get<GptService>()
                        .getHeroCompanionOptions(_age!, _genre!, hero);
                    _companionOptions.addAll(_splitter.convert(companionOptionsResponse.firstMessage.content));
                    setState(() {
                      _overlayText = null;
                      _hero = hero;
                      _controller.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut);
                    });
                  }),
              SelectionTab(
                  type: Companion,
                  options: _companionOptions,
                  title:
                  S
                      .of(context)
                      .addCompanions,
                  optionSelected: (companion) {
                    setState(() {
                      _companion = companion;
                      _controller.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut);
                    });
                  }),
              GenerateStoryTab(
                age: _age,
                hero: _hero,
                genre: _genre,
                companion: _companion,
              )
            ],
          ),
          if (_overlayText != null) ...[
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              color: MediaQuery.of(context).platformBrightness == Brightness.light ? Colors.white.withOpacity(0.8) : Colors.black.withOpacity(0.8)
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SpinKitPumpingHeart(
                      color: Theme
                          .of(context)
                          .highlightColor,
                      size: 100.0,
                      duration: const Duration(milliseconds: 400),
                    ),
                    Text(
                      _overlayText??"",
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

enum Age { zeroToTwo, threeToFive, sixToEight, nineToTwelve }

enum Genre { adventure, fantasy, scifi, fairytale, superhero, mystery, funny }

enum Companion { none, loyalFriend, group, animal }
