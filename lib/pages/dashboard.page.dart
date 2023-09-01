import 'package:bedtime/generated/l10n.dart';
import 'package:bedtime/main.dart';
import 'package:bedtime/models/state/story.state.dart';
import 'package:bedtime/widgets/add-new-story-btn.widget.dart';
import 'package:bedtime/widgets/save-story-dialog.widget.dart';
import 'package:bedtime/widgets/story-list-item.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:isar/isar.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).myFairyTaleBook),
        centerTitle: true,
        leading: Container(),
      ),
      body: SafeArea(
        bottom: false,
        top: true,
        child: Center(
          child: FutureBuilder(
            future: isar!.storyStates.where().findAll(),
            builder: (_, AsyncSnapshot<List<StoryState>> snapshot) {
              if (snapshot.hasData && snapshot.data!.isEmpty) {
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: IconButton(
                          onPressed: () {
                            context.go('/generator');
                          },
                          icon: const Icon(Icons.add_circle_outline, size: 46),
                        ),
                      ),
                      Text(
                        S.of(context).createFirstStory,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                );
              }
              return ListView(
                children: [
                  const AddNewStoryBtn(),
                  for (var story in snapshot.data ?? []) ...[
                    StoryListItem(story: story)
                  ]
                ].animate(interval: 100.ms).fadeIn().slide(),
              );
            },
          ),
        ),
      ),
    );
  }
}
