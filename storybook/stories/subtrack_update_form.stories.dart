// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/widgets.dart';
import 'package:prtmobile/features/subtrack/subtrack_update_form.dart';
import 'package:prtmobile/utils/utils.dart';

import '../storybook.dart';

class SubtrackUpdateFormExample extends StatefulWidget {
  const SubtrackUpdateFormExample({
    Key? key,
  }) : super(key: key);

  @override
  _SubtrackUpdateFormExampleState createState() =>
      _SubtrackUpdateFormExampleState();
}

class _SubtrackUpdateFormExampleState extends State<SubtrackUpdateFormExample> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 100,
      ),
      child: Column(
        children: [
          SubtrackUpdateForm(
            subtrack: SubtrackFactory.buildSubtrack(0),
          ),
        ],
      ),
    );
  }
}

class SubtrackUpdateFormStories implements StorybookStory {
  @override
  String title = 'SubtrackUpdateForm';

  @override
  List<StorybookStoryDefinition> getVariations() {
    return [
      StorybookStoryDefinition(
        type: 'default',
        contentBuilder: (context) {
          return const SubtrackUpdateFormExample();
        },
      ),
    ];
  }
}
