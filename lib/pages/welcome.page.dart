import 'package:bedtime/main.dart';
import 'package:bedtime/models/state/story.state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import 'package:bedtime/generated/l10n.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage('images/welcome.png'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                S.of(context).welcomeTitle,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                S.of(context).welcomeMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoButton(
                onPressed: () {
                  isar!.storyStates.count().then((count) {
                    if (count > 0) {
                      context.go('/dashboard');
                    } else {
                      context.go('/generator');
                    }
                  });
                },
                child: Text(S.of(context).letsGetStarted),
              ),
            )
          ]
              .animate(interval: 200.ms)
              .fadeIn(curve: Curves.bounceIn)
        ),
      ),
    );
  }
}
