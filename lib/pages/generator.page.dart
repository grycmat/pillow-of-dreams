import 'dart:convert';

import 'package:bedtime/generated/l10n.dart';
import 'package:bedtime/injectable_initalizer.dart';
import 'package:bedtime/services/gpt.service.dart';
import 'package:bedtime/widgets/generate-story-tab.widget.dart';
import 'package:bedtime/widgets/selection-tab.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';

class GeneratorPage extends StatefulWidget {
  const GeneratorPage({Key? key}) : super(key: key);

  @override
  State<GeneratorPage> createState() => _GeneratorPageState();
}

class _GeneratorPageState extends State<GeneratorPage> {
  late final PageController _controller;
  late final Locale _locale;
  final List<String> _ageOptions = ['0-2', '3-5', '6-8', '9-12'];
  final List<String> _genreOptions = [];
  final List<String> _heroOptions = [];
  final List<String> _companionOptions = [];
  String? _age;
  String? _genre;
  String? _companion;
  String? _hero;
  String? _overlayText;

  @override
  void initState() {
    _controller = PageController();
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _locale = Localizations.localeOf(context);
      setState(() {
        _genreOptions.addAll([
          S.of(context).adventure,
          S.of(context).fantasy,
          S.of(context).sciFi,
          S.of(context).fairyTale,
          S.of(context).superhero,
          S.of(context).mystery
        ]);
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.go('/dashboard');
          },
          icon: Icon(
            Icons.cancel_outlined,
            color: colorScheme.primary,
          ),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _controller,
              children: <Widget>[
                SelectionTab(
                  title: S.of(context).selectAge,
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
                    title: S.of(context).chooseGenre,
                    options: _genreOptions,
                    optionSelected: (genre) async {
                      setState(() {
                        _overlayText = S.of(context).summoningHero;
                      });

                      try {
                        final heroOptionsResponse = await getIt
                            .get<GptService>()
                            .getHeroOptions(
                                age: _age!, genre: genre, locale: _locale);
                        var responseJson = jsonDecode(
                            heroOptionsResponse.firstMessage.content);
                        for (var item in responseJson['heroes']) {
                          _heroOptions
                              .add('${item['name']} - ${item['description']}');
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(S.of(context).couldNotCreateHeroes),
                            ),
                          );
                        }
                        setState(() {
                          _overlayText = null;
                        });
                        return;
                      }

                      setState(() {
                        _genre = genre;
                        _overlayText = null;
                        _controller.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut);
                      });
                    }),
                SelectionTab(
                    createCustomCharacter: true,
                    title: S.of(context).discoverHero,
                    options: _heroOptions,
                    optionSelected: (hero) async {
                      setState(() {
                        _overlayText = S.of(context).gatheringCompanions;
                      });
                      try {
                        final companionOptionsResponse = await getIt
                            .get<GptService>()
                            .getHeroCompanionOptions(
                                age: _age!,
                                genre: _genre!,
                                hero: hero,
                                locale: _locale);
                        final responseJson = jsonDecode(
                            companionOptionsResponse.firstMessage.content);
                        for (var item in responseJson['companions']) {
                          _companionOptions
                              .add('${item['name']} - ${item['description']}');
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text(S.of(context).couldNotCreateCompanions),
                            ),
                          );
                        }
                        setState(() {
                          _overlayText = null;
                        });

                        return;
                      }

                      setState(() {
                        _overlayText = null;
                        _hero = hero;
                        _controller.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut);
                      });
                    }),
                SelectionTab(
                    createCustomCharacter: true,
                    options: _companionOptions,
                    title: S.of(context).addCompanions,
                    optionSelected: (companion) {
                      setState(() {
                        _companion = companion;
                        _controller.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut);
                      });
                    }),
                GenerateStoryTab(
                  locale: _locale,
                  age: _age,
                  hero: _hero,
                  genre: _genre,
                  companion: _companion,
                )
              ],
            ),
            if (_overlayText != null) ...[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: colorScheme.background,
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
                        color: colorScheme.primary,
                        size: 100.0,
                        duration: const Duration(milliseconds: 400),
                      ),
                      Text(
                        _overlayText ?? "",
                        style: textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
