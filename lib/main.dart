import 'package:bedtime/app.theme.dart';
import 'package:bedtime/injectable_initalizer.dart';
import 'package:bedtime/models/state/story.state.dart';
import 'package:bedtime/pages/dashboard.page.dart';
import 'package:bedtime/pages/generator.page.dart';
import 'package:bedtime/pages/read_story.page.dart';
import 'package:bedtime/pages/welcome.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'generated/l10n.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => const WelcomePage(),
      routes: [
        GoRoute(
          path: 'generator',
          builder: (context, state) => const GeneratorPage(),
        ),
        GoRoute(
          path: 'dashboard',
          builder: (context, state) => const DashboardPage(),
        ),
        GoRoute(
          path: 'read/:id',
          builder: (context, state) =>
              ReadStoryPage(id: state.pathParameters['id']!),
        ),
      ],
    ),
  ],
);

Isar? isar;

void main() async {
  await dotenv.load();
  var dir = await getApplicationDocumentsDirectory();
  isar = await Isar.open([StoryStateSchema], directory: dir.path);
  configureDependencies();
  runApp(const BedtimeStories());
}

class BedtimeStories extends StatelessWidget {
  const BedtimeStories({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      title: 'Bedtime Stories',
      darkTheme: AppTheme.darkTheme(),
      theme: AppTheme.lightTheme(),
      themeMode: ThemeMode.dark,
    );
  }
}
