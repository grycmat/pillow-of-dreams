import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddNewStoryBtn extends StatelessWidget {
  const AddNewStoryBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).colorScheme.primary;

    return Padding(
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
    );
  }
}
