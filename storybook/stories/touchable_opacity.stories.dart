import 'package:flutter/material.dart';
import 'package:prtmobile/core/core.dart';

import '../storybook.dart';

class TouchableOpacityExample extends StatefulWidget {
  const TouchableOpacityExample({
    Key? key,
  }) : super(key: key);

  @override
  _TouchableOpacityExampleState createState() =>
      _TouchableOpacityExampleState();
}

class _TouchableOpacityExampleState extends State<TouchableOpacityExample> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 100,
      ),
      child: Column(
        children: [
          TouchableOpacity(
            child: Container(
              color: Colors.green,
              child: Text(
                'Touchable text',
                style: AppTypography.h1.white(),
              ),
            ),
            onTap: () {},
            onLongPress: () {},
          ),
        ],
      ),
    );
  }
}

class TouchableOpacityStories implements StorybookStory {
  @override
  String title = 'TouchableOpacity';

  @override
  List<StorybookStoryDefinition> getVariations() {
    return [
      StorybookStoryDefinition(
        type: 'default',
        contentBuilder: (context) {
          return const TouchableOpacityExample();
        },
      ),
    ];
  }
}
