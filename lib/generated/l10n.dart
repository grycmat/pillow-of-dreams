// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Dive into a realm where bedtime tales are no longer just stories, but worlds crafted by you and your child. Every evening is a new chapter in a magical adventure. 🌌📖`
  String get welcomeMessage {
    return Intl.message(
      'Dive into a realm where bedtime tales are no longer just stories, but worlds crafted by you and your child. Every evening is a new chapter in a magical adventure. 🌌📖',
      name: 'welcomeMessage',
      desc: '',
      args: [],
    );
  }

  /// `Embark on our magical journey!`
  String get letsGetStarted {
    return Intl.message(
      'Embark on our magical journey!',
      name: 'letsGetStarted',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to DreamWorld Tales!`
  String get welcomeTitle {
    return Intl.message(
      'Welcome to DreamWorld Tales!',
      name: 'welcomeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Gathering a group of wonderful companions for your hero... Just a moment!`
  String get gatheringCompanions {
    return Intl.message(
      'Gathering a group of wonderful companions for your hero... Just a moment!',
      name: 'gatheringCompanions',
      desc: '',
      args: [],
    );
  }

  /// `Who will accompany your hero? Select allies for a tale that's truly one-of-a-kind!`
  String get addCompanions {
    return Intl.message(
      'Who will accompany your hero? Select allies for a tale that\'s truly one-of-a-kind!',
      name: 'addCompanions',
      desc: '',
      args: [],
    );
  }

  /// `Who will lead your tale tonight? Choose a hero and let their adventure unfold!`
  String get discoverHero {
    return Intl.message(
      'Who will lead your tale tonight? Choose a hero and let their adventure unfold!',
      name: 'discoverHero',
      desc: '',
      args: [],
    );
  }

  /// `Set the backdrop of your epic tale – which world will you explore tonight?`
  String get chooseGenre {
    return Intl.message(
      'Set the backdrop of your epic tale – which world will you explore tonight?',
      name: 'chooseGenre',
      desc: '',
      args: [],
    );
  }

  /// `Conjuring a gallery of legendary heroes for your selection... A moment of magic is underway!`
  String get summoningHero {
    return Intl.message(
      'Conjuring a gallery of legendary heroes for your selection... A moment of magic is underway!',
      name: 'summoningHero',
      desc: '',
      args: [],
    );
  }

  /// `To weave the perfect tale, tell us the age of your young dreamer.`
  String get selectAge {
    return Intl.message(
      'To weave the perfect tale, tell us the age of your young dreamer.',
      name: 'selectAge',
      desc: '',
      args: [],
    );
  }

  /// `Adventure`
  String get adventure {
    return Intl.message(
      'Adventure',
      name: 'adventure',
      desc: '',
      args: [],
    );
  }

  /// `Fantasy`
  String get fantasy {
    return Intl.message(
      'Fantasy',
      name: 'fantasy',
      desc: '',
      args: [],
    );
  }

  /// `Fairy Tale`
  String get fairyTale {
    return Intl.message(
      'Fairy Tale',
      name: 'fairyTale',
      desc: '',
      args: [],
    );
  }

  /// `Sci-Fi`
  String get sciFi {
    return Intl.message(
      'Sci-Fi',
      name: 'sciFi',
      desc: '',
      args: [],
    );
  }

  /// `Superhero`
  String get superhero {
    return Intl.message(
      'Superhero',
      name: 'superhero',
      desc: '',
      args: [],
    );
  }

  /// `Mystery`
  String get mystery {
    return Intl.message(
      'Mystery',
      name: 'mystery',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to add this story to your Fairy Tale Book?`
  String get doYouWantToSave {
    return Intl.message(
      'Do you want to add this story to your Fairy Tale Book?',
      name: 'doYouWantToSave',
      desc: '',
      args: [],
    );
  }

  /// `Create your first story!`
  String get createFirstStory {
    return Intl.message(
      'Create your first story!',
      name: 'createFirstStory',
      desc: '',
      args: [],
    );
  }

  /// `Story Saved!`
  String get storySaved {
    return Intl.message(
      'Story Saved!',
      name: 'storySaved',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Name the Story`
  String get nameTheStory {
    return Intl.message(
      'Name the Story',
      name: 'nameTheStory',
      desc: '',
      args: [],
    );
  }

  /// `Pillow Of Dreams`
  String get pillowOfDreams {
    return Intl.message(
      'Pillow Of Dreams',
      name: 'pillowOfDreams',
      desc: '',
      args: [],
    );
  }

  /// `My Fairy Tale Book`
  String get myFairyTaleBook {
    return Intl.message(
      'My Fairy Tale Book',
      name: 'myFairyTaleBook',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'pl'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
