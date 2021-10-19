import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prtmobile/components/components.dart';

import '../storybook.dart';

class ExpandableExample extends StatefulWidget {
  const ExpandableExample({
    Key? key,
  }) : super(key: key);

  @override
  _ExpandableExampleState createState() => _ExpandableExampleState();
}

class _ExpandableExampleState extends State<ExpandableExample> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 100,
      ),
      child: Expandable(
        animationData: AnimationData(
          curve: Curves.linear,
          duration: const Duration(
            milliseconds: 300,
          ),
        ),
        header: Builder(builder: (context) {
          return GestureDetector(
            onTap: () {
              final state = ExpandableState.of(context);
              state!.toggle();
            },
            child: Container(
              margin: const EdgeInsets.all(1),
              decoration: const BoxDecoration(
                color: Colors.cyan,
              ),
              child: const Text('expandable header'),
            ),
          );
        }),
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.amber,
          ),
        ),
      ),
    );
  }
}

class ExpandableStories implements StorybookStory {
  @override
  String title = 'Expandable';

  @override
  List<StorybookStoryDefinition> getVariations() {
    return [
      StorybookStoryDefinition(
        type: 'default',
        contentBuilder: (context) {
          return const ExpandableExample();
        },
      ),
    ];
  }
}
