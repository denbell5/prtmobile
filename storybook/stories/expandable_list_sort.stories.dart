// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:prtmobile/components/components.dart';

import '../storybook.dart';

final data = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j'];

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

  void onToggle({
    required int index,
    required bool isExpanded,
  }) {
    listKey.currentState!.onToggle(
      index: index,
      isExpanded: isExpanded,
    );
  }

  Expandable buildListItem(int index) {
    return Expandable(
      key: ValueKey(_data[index]),
      onToggle: (isExpanded) {
        onToggle(index: index, isExpanded: isExpanded);
      },
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
                    Text(
                      _data[index],
                    ),
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
            _data[index],
          ),
        ),
      ),
    );
  }

  Widget buildListHeader() {
    return Column(
      children: const [
        Text('Text information 1.'),
        Text('Text information 2.'),
        SizedBox(
          height: 500,
        ),
      ],
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
              expandableHeaderExtent: itemExtent,
              animationData: animationData,
              divider: HorizontalDivider(),
              listHeader: buildListHeader(),
              children: _data
                  .asMap()
                  .map((key, value) => MapEntry(key, buildListItem(key)))
                  .values
                  .toList(),
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
