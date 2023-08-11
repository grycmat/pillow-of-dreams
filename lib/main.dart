import 'package:bedtime/injectable_initalizer.dart';
import 'package:bedtime/pages/generator.page.dart';
import 'package:bedtime/pages/welcome.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'generated/l10n.dart';

final GoRouter router = GoRouter(routes: <RouteBase>[
  GoRoute(
    path: '/',
    builder: (context, state) => const WelcomePage(),
    routes: [
      GoRoute(
        path: 'generator',
        builder: (context, state) => const GeneratorPage(),
      ),
    ],
  ),
]);

void main() async {
  await dotenv.load();
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
      title: 'Chat App',
      theme: ThemeData(
        fontFamily: 'Lato',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
    );
  }
}
