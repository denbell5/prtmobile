import 'package:dashbook/dashbook.dart';
import 'package:flutter/widgets.dart';

typedef _StoryDefinitionContentCreator = Widget Function(
  DashbookContext context,
);

class StorybookStoryDefinition {
  _StoryDefinitionContentCreator contentBuilder;
  String type;

  StorybookStoryDefinition({
    required this.contentBuilder,
    required this.type,
  });
}

abstract class StorybookStory {
  late String title;

  List<StorybookStoryDefinition> getVariations();
}
