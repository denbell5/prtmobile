import 'package:flutter/material.dart';
import 'package:prtmobile/core/core.dart';

import '../storybook.dart';

class TouchableColorExample extends StatefulWidget {
  const TouchableColorExample({
    Key? key,
  }) : super(key: key);

  @override
  _TouchableColorExampleState createState() => _TouchableColorExampleState();
}

class _TouchableColorExampleState extends State<TouchableColorExample> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 100,
      ),
      child: Column(
        children: [
          TouchableColor(
            child: const SizedBox(
              height: 30,
              width: 200,
            ),
            onTap: () {},
            color: Colors.amber,
            touchColor: AppColors.grey,
          ),
          const Height(10),
          const Text('From white to light grey'),
          TouchableColor(
            child: const SizedBox(
              height: 30,
              width: 200,
              child: Center(child: Text('Button text')),
            ),
            onTap: () {},
            color: AppColors.white,
            touchColor: AppColors.lightGrey,
          ),
        ],
      ),
    );
  }
}

class TouchableColorStories implements StorybookStory {
  @override
  String title = 'TouchableColor';

  @override
  List<StorybookStoryDefinition> getVariations() {
    return [
      StorybookStoryDefinition(
        type: 'default',
        contentBuilder: (context) {
          return const TouchableColorExample();
        },
      ),
    ];
  }
}
