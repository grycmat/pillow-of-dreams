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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Text(
                  title,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Wrap(
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                spacing: 16,
                runSpacing: 16,
                children: [
                  for (var option in options) ...[
                    InkWell(
                      onTap: () => optionSelected(option),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(
                                color: Theme.of(context).highlightColor,
                                width: 1),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                  color: Theme.of(context).colorScheme.primary,
                                  blurRadius: 4),
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 18),
                          child: Text(option,
                              style: Theme.of(context).textTheme.bodyLarge,
                              softWrap: true),
                        ),
                      ),
                    )
                  ]
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
