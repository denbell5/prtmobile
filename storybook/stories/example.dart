import 'package:flutter/widgets.dart';

import '../storybook.dart';

class ExampleExample extends StatefulWidget {
  const ExampleExample({
    Key? key,
  }) : super(key: key);

  @override
  _ExampleExampleState createState() => _ExampleExampleState();
}

class _ExampleExampleState extends State<ExampleExample> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 100,
      ),
      child: Container(),
    );
  }
}

class ExampleStories implements StorybookStory {
  @override
  String title = 'Example';

  @override
  List<StorybookStoryDefinition> getVariations() {
    return [
      StorybookStoryDefinition(
        type: 'default',
        contentBuilder: (context) {
          return const ExampleExample();
        },
      ),
    ];
  }
}
