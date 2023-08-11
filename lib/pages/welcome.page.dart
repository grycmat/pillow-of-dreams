import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
              image: AssetImage('images/welcome.jpeg'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Welcome to DreamWorld Tales!", style: Theme.of(context).textTheme.headlineSmall,),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                  "Say goodbye to ordinary bedtime stories. With us, you and your child can co-create unique and captivating stories together. Every night becomes an opportunity for imagination to soar. 🌙✨",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),),
            ),
            ElevatedButton(
                onPressed: () {
                  context.go('/generator');
                },
                child: const Text("Let's get started!"))
          ],
        ),
      ),
    );
  }
}
