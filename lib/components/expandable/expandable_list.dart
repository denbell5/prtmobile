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
    this.animationData,
    required this.expandables,
    required this.expandableHeaderExtent,
    this.separator,
  }) : super(key: key);

  final Widget? listHeader;
  final ScrollController? controller;
  final List<Widget> expandables;
  final double expandableHeaderExtent;
  final AnimationData? animationData;
  final Widget? separator;

  @override
  ExpandableListState createState() => ExpandableListState();
}

class ExpandableListState extends State<ExpandableList> {
  late ScrollController _controller;
  var listHeaderHeight = 0.0;
  var separatorHeight = 0.0;
  int? expandedIndex;

  ScrollPhysics? get scrollPhysics =>
      expandedIndex == null ? null : const NeverScrollableScrollPhysics();

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? ScrollController();
  }

  double _calcScrollToToggledOffset(int index) {
    final value = index * widget.expandableHeaderExtent +
        listHeaderHeight +
        index * separatorHeight;
    return value;
  }

  void onToggle({
    required int index,
    required bool isExpanded,
  }) {
    setState(() {
      expandedIndex = isExpanded ? index : null;
    });
    if (expandedIndex != null) {
      _scrollTo(
        _calcScrollToToggledOffset(index),
      );
    }
  }

  void _scrollTo(double offset) {
    if (widget.animationData == null) {
      _controller.jumpTo(offset);
    } else {
      final data = widget.animationData!;
      _controller.animateTo(
        offset,
        duration: data.duration,
        curve: data.curve,
      );
    }
  }

  Widget _buildExtraScrollableSpace(BoxConstraints constraints) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: constraints.maxHeight,
      ),
    );
  }

  Widget _buildListHeader() {
    return SliverToBoxAdapter(
      child: IntrinsicSize(
        onChange: (size) {
          listHeaderHeight = size.height;
        },
        child: widget.listHeader!,
      ),
    );
  }

  List<Widget> buildList({
    required BoxConstraints constraints,
  }) {
    if (widget.expandables.isEmpty) {
      return [];
    }
    if (widget.separator == null) {
      final items = widget.expandables.map((item) {
        return ConstrainedBox(
          constraints: constraints,
          child: item,
        );
      }).toList();
      return items;
    }
    final separator = widget.separator!;
    final list = <Widget>[];
    list.add(
      IntrinsicSize(
        onChange: (size) {
          separatorHeight = size.height;
        },
        child: separator,
      ),
    );
    for (var i = 0; i < widget.expandables.length; i++) {
      list.add(
        ConstrainedBox(
          constraints: constraints,
          child: widget.expandables[i],
        ),
      );
      list.add(separator);
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return CustomScrollView(
          controller: _controller,
          physics: scrollPhysics,
          slivers: [
            if (widget.listHeader != null) _buildListHeader(),
            SliverList(
              delegate: SliverChildListDelegate(
                buildList(constraints: constraints),
              ),
            ),
            if (expandedIndex != null)
              _buildExtraScrollableSpace(
                constraints,
              )
          ],
        );
      },
    );
  }
}
