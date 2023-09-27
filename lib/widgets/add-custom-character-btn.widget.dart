import 'package:flutter/material.dart';

class AddCustomCharacterBtn extends StatelessWidget {
  const AddCustomCharacterBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).colorScheme.primary;
    var textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: primaryColor, blurRadius: 2, blurStyle: BlurStyle.outer),
          ],
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          border: Border.all(color: primaryColor),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Icon(Icons.add),
              ),
              Text('Create your own!',
                  style: textTheme.bodyLarge, softWrap: true)
            ],
          ),
        ),
      ),
    );
  }
}
