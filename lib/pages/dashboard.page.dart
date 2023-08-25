import 'package:bedtime/generated/l10n.dart';
import 'package:bedtime/main.dart';
import 'package:bedtime/models/state/story.state.dart';
import 'package:bedtime/widgets/story-list-item.widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:isar/isar.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(foregroundColor: Colors.amber),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          context.go('/generator');
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: FutureBuilder(
          future: isar!.storyStates.where().findAll(),
          builder: (_, AsyncSnapshot<List<StoryState>> snapshot) {
            if (true) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Icon(Icons.menu_book_outlined, size: 36,),
                    ),
                    Text(S.of(context).createFirstStory, style: Theme.of(context).textTheme.headlineMedium,),
                  ],
                ),
              );
            }
            return ListView(
              children: [
                for (var story in snapshot.data ?? []) ...[
                  StoryListItem(story: story)
                ]
              ],
            );
          },
        ),
      ),
    );
  }
}
