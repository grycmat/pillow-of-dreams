import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Image(
              image: AssetImage('images/welcome.jpeg'),
            ),
            Text("Welcome to Bedtime Stories!"),
            Text("We'll help you generate a story for your child to read!"),
            Text("Let's get started!"),
            ElevatedButton(
                onPressed: () {
                  context.go('/generator');
                },
                child: Text("Get Started"))
          ],
        ),
      ),
    );
  }
}
