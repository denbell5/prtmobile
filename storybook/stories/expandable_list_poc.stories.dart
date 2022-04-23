import 'dart:math';

import 'package:flutter/material.dart';
import 'package:prtmobile/core/core.dart';

import '../storybook.dart';

class ExpandableListPocExample extends StatefulWidget {
  const ExpandableListPocExample({
    Key? key,
    this.isSeparated = false,
  }) : super(key: key);

  final bool isSeparated;

  @override
  _ExpandableListPocExampleState createState() =>
      _ExpandableListPocExampleState();
}

class _ExpandableListPocExampleState extends State<ExpandableListPocExample> {
  final scrollController = ScrollController();
  final itemExtent = 50.0;
  final listKey = GlobalKey<ExpandableListState>();
  final animationData = AnimationData(
    curve: Curves.linear,
    duration: const Duration(milliseconds: 300),
  );

  Expandable buildListItem(int index) {
    return Expandable(
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
                    Text(Random().nextDouble().toString()),
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
      ),
    );
  }

  Widget buildListHeader() {
    return Column(
      children: const [
        Text('Text information 1.'),
        Text('Text information 2.'),
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  scrollController.jumpTo(
                    scrollController.offset - 10,
                  );
                },
                child: const Text('-', style: TextStyle(fontSize: 30)),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () {
                  scrollController.jumpTo(
                    scrollController.offset + 10,
                  );
                },
                child: const Text('+', style: TextStyle(fontSize: 30)),
              ),
            ],
          ),
          Flexible(
            child: ExpandableList(
              key: listKey,
              controller: scrollController,
              animationData: animationData,
            ),
          ),
        ],
      ),
    );
  }
}

class ExpandableListPocStories implements StorybookStory {
  @override
  String title = 'Expandable list poc';

  @override
  List<StorybookStoryDefinition> getVariations() {
    return [
      StorybookStoryDefinition(
        type: 'default',
        contentBuilder: (context) {
          return const ExpandableListPocExample();
        },
      ),
      StorybookStoryDefinition(
        type: 'separated',
        contentBuilder: (context) {
          return const ExpandableListPocExample(
            isSeparated: true,
          );
        },
      ),
    ];
  }
}
