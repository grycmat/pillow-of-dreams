import 'package:flutter/material.dart';
import 'package:bedtime/widgets/selection-tab.widget.dart';
import 'package:bedtime/widgets/generate-story-tab.widget.dart';

class GeneratorPage extends StatefulWidget {
  const GeneratorPage({Key? key}) : super(key: key);

  @override
  State<GeneratorPage> createState() => _GeneratorPageState();
}

class _GeneratorPageState extends State<GeneratorPage> {
  late final PageController _controller;
  final Map<String, Age> _ageOptions = {
    '0-2': Age.zeroToTwo,
    '3-5': Age.threeToFive,
    '6-8': Age.sixToEight,
    '9-12': Age.nineToTwelve
  };
  final Map<String, Genre> _genreOptions = {
    'Adventure': Genre.adventure,
    'Fantasy': Genre.fantasy,
    'Sci-fi': Genre.scifi,
    'Fairy Tale': Genre.fairytale
  };
  final Map<String, Companion> _companionOptions = {
    'None': Companion.none,
    'Loyal friend': Companion.loyalFriend,
    'A group of adventurers': Companion.group,
    'Brave Animal': Companion.animal
  };
  Age? _age;
  Genre? _genre;
  Companion? _companion;

  @override
  void initState() {
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
      body: PageView(
        controller: _controller,
        children: <Widget>[
          SelectionTab(
            title: "What is your child's age?",
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
              title: "What kind of story would you like to create?",
              options: _genreOptions,
              optionSelected: (genre) {
                setState(() {
                  _genre = genre;
                  _controller.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut);
                });
              }),
          SelectionTab(
              options: _companionOptions,
              title: "SelectCompanion",
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
            genre: _genre,
            companion: _companion,
          )
        ],
      ),
    );
  }
}

enum Age { zeroToTwo, threeToFive, sixToEight, nineToTwelve }

enum Genre { adventure, fantasy, scifi, fairytale, superhero, mystery, funny }

enum Companion { none, loyalFriend, group, animal }
