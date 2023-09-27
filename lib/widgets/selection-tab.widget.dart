import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SelectionTab extends StatelessWidget {
  const SelectionTab(
      {Key? key,
      required this.title,
      required this.options,
      required this.optionSelected})
      : super(key: key);
  final Function optionSelected;
  final List<String> options;
  final String title;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;
    var textTheme = Theme.of(context).textTheme;
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
                  style: textTheme.headlineMedium,
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
                            color: colorScheme.background,
                            border: Border.all(
                                color: colorScheme.primary, width: 1),
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                  color: colorScheme.primary, blurRadius: 4),
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 18),
                          child: Text(option,
                              style: textTheme.bodyLarge, softWrap: true),
                        ),
                      ),
                    )
                  ]
                ].animate(interval: 200.ms).fadeIn(curve: Curves.easeIn),
              )
            ],
          ),
        ),
      ),
    );
  }
}
