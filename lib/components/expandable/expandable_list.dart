import 'package:flutter/widgets.dart';
import 'package:prtmobile/components/components.dart';

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
    required this.expandableHeaderExtent,
    this.divider,
    required this.children,
  }) : super(key: key);

  final Widget? listHeader;
  final ScrollController? controller;
  final double expandableHeaderExtent;
  final AnimationData? animationData;
  final Widget? divider;

  final List<Widget> children;

  @override
  ExpandableListState createState() => ExpandableListState();
}

class ExpandableListState extends State<ExpandableList> with ListBuilder {
  late ScrollController _controller;
  var listHeaderHeight = 0.0;
  var separatorHeight = 0.0;
  double previousOffset = 0.0;
  int? expandedIndex;
  Key? expandedKey;

  bool get isExpanded => expandedIndex != null;

  ScrollPhysics? get scrollPhysics =>
      expandedIndex == null ? null : const NeverScrollableScrollPhysics();

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? ScrollController();
  }

  @override
  void didUpdateWidget(ExpandableList oldWidget) {
    super.didUpdateWidget(oldWidget);
    _handleReorderWhenExpanded();
  }

  void _handleReorderWhenExpanded() {
    if (expandedKey == null) {
      return;
    }
    final newExpandedIndex = widget.children.indexWhere(
      (w) => w.key == expandedKey,
    );
    if (newExpandedIndex != expandedIndex) {
      expandedIndex = newExpandedIndex;
      _controller.jumpTo(
        _calcScrollToToggledOffset(expandedIndex!),
      );
    }
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
      if (expandedIndex == null) {
        expandedKey = null;
      }
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
      itemCount: widget.children.length,
      itemBuilder: (index) {
        final child = widget.children[index];
        if (index == expandedIndex) {
          expandedKey = child.key;
        }
        return KeyedSubtree(
          key: child.key,
          child: ConstrainedBox(
            constraints: constraints,
            child: child,
          ),
        );
      },
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
