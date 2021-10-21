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
  }) : super(key: key);

  final Widget? listHeader;
  final ScrollController? controller;
  final List<Widget> expandables;
  final double expandableHeaderExtent;
  final AnimationData? animationData;

  @override
  ExpandableListState createState() => ExpandableListState();
}

class ExpandableListState extends State<ExpandableList> {
  late ScrollController _controller;
  var listHeaderHeight = 0.0;
  int? expandedIndex;

  ScrollPhysics? get scrollPhysics =>
      expandedIndex == null ? null : const NeverScrollableScrollPhysics();

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? ScrollController();
  }

  void onToggle({
    required int index,
    required bool isExpanded,
  }) {
    setState(() {
      expandedIndex = isExpanded ? index : null;
    });
    if (expandedIndex != null) {
      final value = index * widget.expandableHeaderExtent + listHeaderHeight;
      _scrollTo(value);
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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return CustomScrollView(
          controller: _controller,
          physics: scrollPhysics,
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
