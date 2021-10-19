import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prtmobile/components/components.dart';

import 'expandable.dart';

typedef ExpandableListBuilder = Expandable Function(
  BuildContext context,
  int index,
);

class ExpandableList extends StatefulWidget {
  const ExpandableList({
    Key? key,
    this.listHeader,
    this.controller,
    required this.expandables,
    required this.expandableHeaderExtent,
  }) : super(key: key);

  final Widget? listHeader;
  final ScrollController? controller;
  final List<Expandable> expandables;
  final double expandableHeaderExtent;

  @override
  ExpandableListState createState() => ExpandableListState();
}

class ExpandableListState extends State<ExpandableList> {
  late ScrollController _controller;
  var listHeaderHeight = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? ScrollController();
  }

  void scrollToToggled(int index) {
    final value = index * widget.expandableHeaderExtent + listHeaderHeight;
    _controller.jumpTo(value);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return CustomScrollView(
          controller: _controller,
          slivers: [
            if (widget.listHeader != null)
              SliverToBoxAdapter(
                child: IntrinsicSize(
                  onChange: (size) {
                    listHeaderHeight = size.height;
                  },
                  child: widget.listHeader!,
                ),
              ),
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
