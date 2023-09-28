import 'package:bedtime/generated/l10n.dart';
import 'package:bedtime/widgets/add-custom-character-btn.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

class SelectionTab extends StatefulWidget {
  const SelectionTab(
      {Key? key,
      this.createCustomCharacter = false,
      required this.title,
      required this.options,
      required this.optionSelected})
      : super(key: key);
  final Function optionSelected;
  final bool createCustomCharacter;
  final List<String> options;
  final String title;

  @override
  State<SelectionTab> createState() => _SelectionTabState();
}

class _SelectionTabState extends State<SelectionTab> {
  late final TextEditingController _nameController;
  late final TextEditingController _descController;

  @override
  void initState() {
    _nameController = TextEditingController();
    _descController = TextEditingController();
    super.initState();
  }

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
                  widget.title,
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
                  if (widget.createCustomCharacter)
                    InkWell(
                      onTap: () => showDialog(
                        context: context,
                        builder: (_) => Dialog(
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(children: [
                              TextField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  label: Text(S.of(context).writeName),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 24),
                                child: TextField(
                                  controller: _descController,
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                    label: Text(S.of(context).writeDescription),
                                  ),
                                ),
                              ),
                              TextButton(
                                  child: Text(S.of(context).newCharacterReady),
                                  onPressed: () {
                                    if (_nameController.text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(S
                                              .of(context)
                                              .pleaseNameCharacter),
                                        ),
                                      );

                                      return;
                                    }

                                    String character = _descController
                                            .text.isEmpty
                                        ? _nameController.text
                                        : '${_nameController.text} - ${_descController.text}';
                                    widget.optionSelected(character);

                                    context.pop();
                                  }),
                              TextButton(
                                onPressed: () => context.pop(),
                                child: Text(S.of(context).selectSomeoneElse),
                              )
                            ]),
                          ),
                        ),
                      ),
                      child: const AddCustomCharacterBtn(),
                    ),
                  for (var option in widget.options) ...[
                    InkWell(
                      onTap: () => widget.optionSelected(option),
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
