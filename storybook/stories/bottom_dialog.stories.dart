// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print

import 'package:flutter/cupertino.dart';
import 'package:prtmobile/components/components.dart';
import '../storybook.dart';

class BottomDialogExample extends StatelessWidget {
  const BottomDialogExample({
    Key? key,
  }) : super(key: key);

  void _showDialog(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (context) {
        return BottomDialog(
          child: BottomSafeArea(
            child: Padding(
              padding: const EdgeInsets.all(55.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Text 1'),
                  Text('Text 2'),
                  CupertinoTextField(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: Builder(builder: (context) {
        return Padding(
          padding: EdgeInsets.all(100),
          child: Column(
            children: [
              TouchableOpacity(
                child: Text('Open dialog'),
                onTap: () {
                  _showDialog(context);
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}

class BottomDialogStories implements StorybookStory {
  @override
  String title = 'BottomDialog';

  @override
  List<StorybookStoryDefinition> getVariations() {
    return [
      StorybookStoryDefinition(
        contentBuilder: (context) {
          return BottomDialogExample();
        },
        type: 'default',
      ),
    ];
  }
}
