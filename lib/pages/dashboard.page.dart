import 'package:bedtime/main.dart';
import 'package:bedtime/models/state/story.state.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(foregroundColor: Colors.amber),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: (){},
        child: Icon(Icons.add),
      ),
      body: Center(
        child: FutureBuilder(
          future: isar!.storyStates.where().findAll(),
          builder: (_, AsyncSnapshot<List<StoryState>> snapshot) {
            return ListView(
              children: [
                for (var story in snapshot.data ?? []) ...[
                  ListTile(
                    title: Text(story.name),
                    subtitle: Text(story.content),
                  )
                ]
              ],
            );
          },
        ),
      ),
    );
  }
}
