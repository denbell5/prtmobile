// ignore_for_file: prefer_const_constructors

import 'package:flutter/widgets.dart';
import 'package:prtmobile/core/ui/components/components.dart';

import '../storybook.dart';

class ProgressBarExample extends StatefulWidget {
  const ProgressBarExample({
    Key? key,
  }) : super(key: key);

  @override
  _ProgressBarExampleState createState() => _ProgressBarExampleState();
}

class _ProgressBarExampleState extends State<ProgressBarExample> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 100,
      ),
      child: Center(
        child: ProgressBar(
          progress: 0.6,
          width: 20,
          height: 4,
        ),
      ),
    );
  }
}

class ProgressBarStories implements StorybookStory {
  @override
  String title = 'Example';

  @override
  List<StorybookStoryDefinition> getVariations() {
    return [
      StorybookStoryDefinition(
        type: 'default',
        contentBuilder: (context) {
          return const ProgressBarExample();
        },
      ),
    ];
  }
}
