import 'package:bedtime/injectable_initalizer.dart';
import 'package:bedtime/services/http.service.dart';
import 'package:bedtime/widgets/chat-response.widget.dart';
import 'package:bedtime/widgets/message-box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  await dotenv.load();
  configureDependencies();
  runApp(const BedtimeStories());
}

class BedtimeStories extends StatelessWidget {
  const BedtimeStories({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('pl', 'PL')
      ],
      title: 'Chat App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _messages = [];

  _sendPrompt(String prompt) async {
    final completion = await getIt<HttpService>().sendPrompt(prompt);
    setState(() {
      _messages.add(completion.choices[0].message.content);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4),),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Chat"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListView.builder(
                  itemCount: _messages.length,
                  reverse: true,
                  itemBuilder: (BuildContext context, int index) => ChatResponse(
                    content: _messages[index],
                  ),
                ),
              ],
            ),
            MessageBox(
              onSend: _sendPrompt,
            )
          ],
        ),
      ),
    );
  }
}
