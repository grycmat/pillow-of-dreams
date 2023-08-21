import 'package:isar/isar.dart';

part 'story.state.g.dart';

@collection
class StoryState {
  Id id = Isar.autoIncrement;
  String? content;
}