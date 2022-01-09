import 'package:dashbook/dashbook.dart';
import 'package:flutter/material.dart';
import 'stories.dart';
import 'storybook.dart' as storybook;

void main() {
  runApp(StorybookApp(
    stories: stories,
  ));
}

class StorybookApp extends StatefulWidget {
  final List<storybook.StorybookStory> stories;

  const StorybookApp({
    Key? key,
    required this.stories,
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _StorybookAppState createState() => _StorybookAppState(
        stories: stories,
      );
}

class _StorybookAppState extends State<StorybookApp> {
  List<storybook.StorybookStory> stories;
  late Dashbook dashbook;

  _StorybookAppState({
    required this.stories,
  }) {
    dashbook = Dashbook(
      theme: ThemeData(),
    );

    for (var story in stories) {
      final storiesHeader = dashbook.storiesOf(
        story.title,
      );
      // .decorator(
      //   CenterDecorator(),
      // );

      story.getVariations().forEach((
        storyVariant,
      ) {
        storiesHeader.add(
          storyVariant.type,
          (context) => storyVariant.contentBuilder(
            context,
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return dashbook;
  }
}
