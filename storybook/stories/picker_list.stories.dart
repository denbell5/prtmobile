// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_const_declarations

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/styles/styles.dart';

import '../storybook.dart';

class ListPickerExample extends StatefulWidget {
  const ListPickerExample({
    Key? key,
  }) : super(key: key);

  @override
  _ListPickerExampleState createState() => _ListPickerExampleState();
}

class _ListPickerExampleState extends State<ListPickerExample> {
  @override
  Widget build(BuildContext context) {
    final itemExtent = 50.0;
    return Padding(
      padding: EdgeInsets.only(
        top: 100.0,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 110,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(),
              ),
              child: PickerList(
                itemExtent: itemExtent,
                itemBuilder: (ctx, index) {
                  if (index <= 0) {
                    return null;
                  }
                  return Center(
                    child: SizedBox(
                      height: 50,
                      child: Text(
                        index.toString(),
                        style: AppTypography.h1,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ListPickerStories implements StorybookStory {
  @override
  String title = 'ListPicker';

  @override
  List<StorybookStoryDefinition> getVariations() {
    return [
      StorybookStoryDefinition(
        type: 'default',
        contentBuilder: (context) {
          return const ListPickerExample();
        },
      ),
    ];
  }
}
