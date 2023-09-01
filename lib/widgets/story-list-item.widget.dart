import 'package:animations/animations.dart';
import 'package:bedtime/models/state/story.state.dart';
import 'package:bedtime/pages/read_story.page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StoryListItem extends StatelessWidget {
  const StoryListItem({
    super.key,
    required this.story,
  });

  final StoryState story;

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).colorScheme.primary;
    var borderRadius = const BorderRadius.all(Radius.circular(16));
    return OpenContainer(
      closedBuilder: (_, openContainer) => Padding(
        padding: const EdgeInsets.all(12),
        child: InkWell(
          splashColor: primaryColor,
          borderRadius: borderRadius,
          onTap: () {
            openContainer();
            // context.go('/read/${story.id}');
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: borderRadius,
                border: Border.all(color: primaryColor),
                boxShadow: [
                  BoxShadow(
                      color: primaryColor,
                      blurRadius: 2,
                      blurStyle: BlurStyle.outer),
                ]),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Text(
                story.name!,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ),
        ),
      ),
      openBuilder: (_, closeContainer) => ReadStoryPage(
          id: story.id.toString(), closeContainer: closeContainer),
      closedColor: Colors.transparent,
      closedElevation: 0,
      transitionType: ContainerTransitionType.fadeThrough,
      middleColor: primaryColor,
    );
  }
}
