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
        header: Builder(builder: (context) {
          return GestureDetector(
            onTap: () {
              final state = ExpandableState.of(context);
              state!.toggle();
            },
            child: const Text('expand'),
          );
        }),
        body: Container(),
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
