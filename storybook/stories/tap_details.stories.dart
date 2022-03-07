// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:prtmobile/components/buttons/buttons.dart';

import '../storybook.dart';

class TapDetailsExample extends StatefulWidget {
  const TapDetailsExample({
    Key? key,
  }) : super(key: key);

  @override
  _TapDetailsExampleState createState() => _TapDetailsExampleState();
}

class _TapDetailsExampleState extends State<TapDetailsExample> {
  final _scrollController = ScrollController();

  final _listLayoutBuilderKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 100.0),
      child: Column(
        children: [
          Text('a'),
          Expanded(
            child: Builder(
              key: _listLayoutBuilderKey,
              builder: (listContext) {
                return CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, i) {
                          return TouchableWidget(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(
                                    Random().nextInt(100).toDouble()),
                                child: Text('Tap $i'),
                              ),
                            ),
                            onTap: () {},
                            onTapDetailed: (details) {
                              final globalY = details.globalPosition.dy;
                              final localY = details.localPosition.dy;

                              final box =
                                  listContext.findRenderObject() as RenderBox;
                              final position = box.localToGlobal(Offset.zero);
                              final topOffset = position.dy;

                              _scrollController.animateTo(
                                _scrollController.offset +
                                    globalY -
                                    localY -
                                    topOffset,
                                duration: Duration(milliseconds: 300),
                                curve: Curves.linear,
                              );
                              print(
                                  '#$i | $globalY | $localY | ${globalY - localY}');
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Text('a'),
        ],
      ),
    );
  }
}

class TapDetailsStories implements StorybookStory {
  @override
  String title = 'TapDetails';

  @override
  List<StorybookStoryDefinition> getVariations() {
    return [
      StorybookStoryDefinition(
        type: 'default',
        contentBuilder: (context) {
          return const TapDetailsExample();
        },
      ),
    ];
  }
}
