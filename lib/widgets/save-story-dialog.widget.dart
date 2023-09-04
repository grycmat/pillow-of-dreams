import 'package:bedtime/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SaveStoryDialog extends StatefulWidget {
  const SaveStoryDialog({super.key, required this.save});

  final Function save;

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
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(S.of(context).pleaseNameYourStory)));
                        return;
                      }
                      ScaffoldMessenger.of(context).clearMaterialBanners();
                      widget.save().then((_) {
                        context.pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(S.of(context).storySaved),
                          ),
                        );
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
