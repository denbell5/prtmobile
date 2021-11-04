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
    this.divider,
    required this.itemCount,
    required this.itemBuilder,
  }) : super(key: key);

  final Widget? listHeader;
  final ScrollController? controller;
  final List<Widget> expandables;
  final double expandableHeaderExtent;
  final AnimationData? animationData;
  final Widget? divider;
  final int itemCount;
  final ListItemBuilder itemBuilder;

  @override
  ExpandableListState createState() => ExpandableListState();
}

class ExpandableListState extends State<ExpandableList> with ListBuilder {
  late ScrollController _controller;
  var listHeaderHeight = 0.0;
  var separatorHeight = 0.0;
  int? expandedIndex;
  double previousOffset = 0.0;

  ScrollPhysics? get scrollPhysics => expandedIndex == null
      ? const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        )
      : const NeverScrollableScrollPhysics();

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
      previousOffset = _controller.offset;
      _scrollTo(
        _calcScrollToToggledOffset(index),
      );
    } else {
      _scrollTo(previousOffset);
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

  List<Widget> _buildList({
    required BoxConstraints constraints,
  }) {
    return buildList(
      isDivided: widget.divider != null,
      itemCount: widget.itemCount,
      itemBuilder: (index) => ConstrainedBox(
        constraints: constraints,
        child: widget.itemBuilder(index),
      ),
      firstDividerBuilder: () => IntrinsicSize(
        onChange: (size) {
          separatorHeight = size.height;
        },
        child: widget.divider!,
      ),
      dividerBuilder: () => widget.divider!,
    );
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
                _buildList(constraints: constraints),
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
