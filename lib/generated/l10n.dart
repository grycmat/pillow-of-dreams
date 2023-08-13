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

  /// `Say goodbye to ordinary bedtime stories. With us, you and your child can co-create unique and captivating stories together. Every night becomes an opportunity for imagination to soar. 🌙✨`
  String get welcomeMessage {
    return Intl.message(
      'Say goodbye to ordinary bedtime stories. With us, you and your child can co-create unique and captivating stories together. Every night becomes an opportunity for imagination to soar. 🌙✨',
      name: 'welcomeMessage',
      desc: '',
      args: [],
    );
  }

  /// `Let's get started!`
  String get letsGetStarted {
    return Intl.message(
      'Let\'s get started!',
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

  /// `Add companions to your hero's journey – choose friends for an unforgettable adventure!`
  String get addCompanions {
    return Intl.message(
      'Add companions to your hero\'s journey – choose friends for an unforgettable adventure!',
      name: 'addCompanions',
      desc: '',
      args: [],
    );
  }

  /// `Discover the hero of your dreams – pick the main character for your adventure!`
  String get discoverHero {
    return Intl.message(
      'Discover the hero of your dreams – pick the main character for your adventure!',
      name: 'discoverHero',
      desc: '',
      args: [],
    );
  }

  /// `Embark on a storytelling journey – choose a genre to set the stage!`
  String get chooseGenre {
    return Intl.message(
      'Embark on a storytelling journey – choose a genre to set the stage!',
      name: 'chooseGenre',
      desc: '',
      args: [],
    );
  }

  /// `Summoning a cast of captivating heroes for you... Please wait a moment!`
  String get summoningHero {
    return Intl.message(
      'Summoning a cast of captivating heroes for you... Please wait a moment!',
      name: 'summoningHero',
      desc: '',
      args: [],
    );
  }

  /// `Help us tailor enchanting stories by selecting your child's age`
  String get selectAge {
    return Intl.message(
      'Help us tailor enchanting stories by selecting your child\'s age',
      name: 'selectAge',
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
