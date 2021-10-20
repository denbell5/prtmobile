import 'package:flutter/widgets.dart';
import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/styles/styles.dart';

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
            child: Text(
              'Touchable text',
              style: AppTypography.bodyText.greyed(),
            ),
            onPressed: () {},
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
