import 'package:bedtime/models/state/story.state.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: null,
          builder: (_, AsyncSnapshot<List<StoryState>> snapshot) {
            return ListView(
              children: [
                for (var story in snapshot.data ?? []) ...[
                  ListTile(
                    title: Text(story.id),
                    subtitle: Text('this is story'),
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
