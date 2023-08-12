import 'package:flutter/material.dart';

class SelectionTab extends StatelessWidget {
  const SelectionTab(
      {Key? key,
      required this.title,
      required this.options,
      required this.optionSelected})
      : super(key: key);
  final Function optionSelected;
  final Map<String, dynamic> options;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: [
            Text(
              maxLines: 5,
              title,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ],
        ),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8,
          runSpacing: 8,
          children: [
            for (var option in options.entries) ...[
              InkWell(
                onTap: () => optionSelected(option.value),
                child: Chip(
                  label: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(option.key,
                        style: Theme.of(context).textTheme.bodyLarge),
                  ),
                ),
              )
            ]
          ],
        )
      ],
    );
  }
}
