import 'package:bedtime/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SaveStoryDialog extends StatefulWidget {
  const SaveStoryDialog({super.key, required Function save});

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
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                label: Text(S.of(context).nameTheStory),
              ),
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    // ScaffoldMessenger.of(context)
                    //     .clearMaterialBanners();
                    context.pop();
                  },
                  child: Text(S.of(context).cancel),
                ),
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context)
                        .clearMaterialBanners();
                    // widget.save().then((_) {
                    //   context.pop();
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     SnackBar(
                    //       content: Text(S.of(context).storySaved),
                    //     ),
                    //   );
                    // });
                  },
                  child: Text(S.of(context).save),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
