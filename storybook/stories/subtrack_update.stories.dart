// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/widgets.dart';
import 'package:prtmobile/features/subtrack/subtrack.dart';

import 'package:prtmobile/utils/utils.dart';

import '../storybook.dart';

class SubtrackUpdateExample extends StatefulWidget {
  const SubtrackUpdateExample({
    Key? key,
  }) : super(key: key);

  @override
  _SubtrackUpdateExampleState createState() => _SubtrackUpdateExampleState();
}

class _SubtrackUpdateExampleState extends State<SubtrackUpdateExample> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 100,
      ),
      child: Column(
        children: [
          SubtrackUpdateDialog(
            subtrack: SubtrackFactory.buildSubtrack(0, trackId: '1'),
          ),
        ],
      ),
    );
  }
}

class SubtrackUpdateStories implements StorybookStory {
  @override
  String title = 'SubtrackUpdate';

  @override
  List<StorybookStoryDefinition> getVariations() {
    return [
      StorybookStoryDefinition(
        type: 'default',
        contentBuilder: (context) {
          return const SubtrackUpdateExample();
        },
      ),
    ];
  }
}
