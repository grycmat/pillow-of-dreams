import 'package:flutter/material.dart';

class SelectionTab extends StatelessWidget {
  const SelectionTab(
      {Key? key,
      required this.type,
      required this.title,
      required this.options,
      required this.optionSelected})
      : super(key: key);
  final Function optionSelected;
  final List<String> options;
  final String title;
  final dynamic type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Text(title,
                softWrap: true,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 8,
              runSpacing: 8,
              children: [
                for (var option in options) ...[
                  InkWell(
                    onTap: () => optionSelected(option),
                    child: Chip(
                      label: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(option,
                            style: Theme.of(context).textTheme.bodyLarge),
                      ),
                    ),
                  )
                ]
              ],
            )
          ],
        ),
      ),
    );
  }
}
