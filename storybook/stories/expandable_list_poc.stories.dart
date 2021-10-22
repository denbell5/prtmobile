import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/styles/styles.dart';

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

  Widget buildSeparator() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: kDividerHeight,
            color: AppColors.black,
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
              expandableHeaderExtent: itemExtent,
              expandables: [
                ...List.generate(1000, (i) => buildListItem(i)),
              ],
              listHeader: buildListHeader(),
              animationData: animationData,
              divider: widget.isSeparated ? buildSeparator() : null,
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
