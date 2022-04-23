// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:prtmobile/core/core.dart';

import '../storybook.dart';

final data = [
  'a',
  'b',
  'c',
  'd',
  'e',
  'f',
  'g',
  'h',
  'i',
  'j',
  'k',
  'l',
  'm',
  'n',
  'o',
  'p',
  'q',
  'r',
  's',
];

class ExpandableListSortingExample extends StatefulWidget {
  const ExpandableListSortingExample({
    Key? key,
  }) : super(key: key);

  @override
  _ExpandableListSortingExampleState createState() =>
      _ExpandableListSortingExampleState();
}

class _ExpandableListSortingExampleState
    extends State<ExpandableListSortingExample> {
  final itemExtent = 50.0;
  final listKey = GlobalKey<ExpandableListState>();
  final animationData = AnimationData(
    curve: Curves.linear,
    duration: const Duration(milliseconds: 300),
  );

  List<String> _data = data;

  Expandable buildListItem(String value) {
    return Expandable(
      key: ValueKey(value),
      onToggle: (isExpanded) {},
      animationData: animationData,
      header: Builder(
        builder: (context) {
          return SizedBox(
            height: itemExtent,
            child: GestureDetector(
              onTap: () {
                ExpandableState.of(context)!.toggle();
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.cyan,
                  //border: Border.all(color: Colors.black),
                ),
                child: Row(
                  children: [
                    Text(value),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.amber,
        ),
        child: Center(
          child: Text(
            value,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 100,
      ),
      child: Column(
        children: [
          Row(
            children: [
              TouchableOpacity(
                child: Text('Reverse'),
                onTap: () {
                  setState(() {
                    _data = _data.reversed.toList();
                  });
                },
              ),
            ],
          ),
          Flexible(
            child: ExpandableList(
              key: listKey,
              animationData: animationData,
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    _data
                        .map(
                          (value) => buildListItem(
                            value,
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ExpandableListSortingStories implements StorybookStory {
  @override
  String title = 'ExpandableListSorting';

  @override
  List<StorybookStoryDefinition> getVariations() {
    return [
      StorybookStoryDefinition(
        type: 'default',
        contentBuilder: (context) {
          return const ExpandableListSortingExample();
        },
      ),
    ];
  }
}
