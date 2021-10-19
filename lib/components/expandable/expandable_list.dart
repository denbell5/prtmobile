import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'expandable.dart';

typedef ExpandableListBuilder = Expandable Function(
  BuildContext context,
  int index,
);

class ExpandableList extends StatefulWidget {
  const ExpandableList({
    Key? key,
    required this.expandables,
    this.controller,
    required this.expandableHeaderExtent,
  }) : super(key: key);

  final List<Expandable> expandables;
  final ScrollController? controller;
  final double expandableHeaderExtent;

  @override
  ExpandableListState createState() => ExpandableListState();
}

class ExpandableListState extends State<ExpandableList> {
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? ScrollController();
  }

  void scrollToToggled(int index) {
    final value = index * widget.expandableHeaderExtent;
    _controller.jumpTo(value);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return CustomScrollView(
          controller: _controller,
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                widget.expandables.map((item) {
                  return ConstrainedBox(
                    constraints: constraints,
                    child: item,
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
