import 'package:bedtime/main.dart';
import 'package:bedtime/models/state/story.state.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

class ReadStoryPage extends StatelessWidget {
  const ReadStoryPage({required this.id, super.key});

  final String id;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: false,
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: FutureBuilder(
              future:
                  isar!.storyStates.filter().idEqualTo(int.parse(id)).findFirst(),
              builder: (_, AsyncSnapshot<StoryState?> snapshot) => Text(
                  snapshot.data?.content ?? '',
                  style: Theme.of(context).textTheme.bodyLarge,
                  softWrap: true),
            ),
          ),
        ),
      ),
    );
  }
}
