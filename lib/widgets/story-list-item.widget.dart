import 'package:bedtime/models/state/story.state.dart';
import 'package:flutter/material.dart';

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
    return Padding(
      padding: const EdgeInsets.all(12),
      child: InkWell(
        splashColor: primaryColor,
        borderRadius: borderRadius,
        onTap: (){},
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
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
            child: Text(story.name!),
          ),
        ),
      ),
    );
  }
}
