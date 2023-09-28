import 'package:bedtime/generated/l10n.dart';
import 'package:bedtime/main.dart';
import 'package:bedtime/models/state/story.state.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:isar/isar.dart';

class SaveStoryDialog extends StatefulWidget {
  const SaveStoryDialog({super.key, required this.text});

  final String text;

  @override
  State<SaveStoryDialog> createState() => _SaveStoryDialogState();
}

class _SaveStoryDialogState extends State<SaveStoryDialog> {
  late TextEditingController _nameController;

  @override
  void initState() {
    _nameController = TextEditingController();
    super.initState();
  }

  Future<Id> _save(String text) async {
    final story = StoryState()
      ..content = text
      ..name = _nameController.text;

    return isar!.writeTxn(
      () => isar!.storyStates.put(story),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                label: Text(S.of(context).nameTheStory),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: Text(S.of(context).cancel),
                  ),
                  TextButton(
                    onPressed: () {
                      if (_nameController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(S.of(context).pleaseNameYourStory),
                            action: SnackBarAction(
                                label: S.of(context).goToDashboard,
                                onPressed: () {
                                  context.go('/dashboard');
                                }),
                          ),
                        );
                        return;
                      }

                      ScaffoldMessenger.of(context).clearMaterialBanners();
                      _save(widget.text).then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(S.of(context).storySaved),
                          ),
                        );

                        context.pop();
                      });
                    },
                    child: Text(S.of(context).save),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
