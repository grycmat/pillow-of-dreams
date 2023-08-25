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
    var primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: isar!.storyStates.where().findAll(),
          builder: (_, AsyncSnapshot<List<StoryState>> snapshot) {
            if (snapshot.hasData && snapshot.data!.isEmpty) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Icon(
                        Icons.menu_book_outlined,
                        size: 36,
                      ),
                    ),
                    Text(
                      S.of(context).createFirstStory,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
              );
            }
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: primaryColor,
                            blurRadius: 2,
                            blurStyle: BlurStyle.outer),
                      ],
                      borderRadius: const BorderRadius.all(
                        Radius.circular(16),
                      ),
                      border: Border.all(color: primaryColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.add,
                          color: primaryColor,
                        ),
                        onPressed: () {
                          context.go('/generator');
                        },
                      ),
                    ),
                  ),
                ),
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
