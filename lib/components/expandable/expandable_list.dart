import 'package:flutter/widgets.dart';
import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/misc/widget_position.dart';

typedef ExpandableListBuilder = Expandable Function(
  BuildContext context,
  int index,
);

class ExpandableListV2 extends StatefulWidget {
  const ExpandableListV2({
    Key? key,
    this.controller,
    this.animationData,
    this.slivers = const [],
  }) : super(key: key);

  // ignore: todo
  // TODO: remove unused fields
  final ScrollController? controller;
  final AnimationData? animationData;
  final List<Widget> slivers;

  @override
  ExpandableListStateV2 createState() => ExpandableListStateV2();
}

class ExpandableListStateV2 extends State<ExpandableListV2> with ListBuilder {
  late ScrollController _scrollController;
  double previousOffset = 0.0;

  bool _isExpanded = false;
  bool get isExpanded => _isExpanded;

  ExpandableState? _expandedExpandable;

  ScrollPhysics? get scrollPhysics => isExpanded
      ? const NeverScrollableScrollPhysics()
      : const ClampingScrollPhysics();

  late BoxConstraints _viewportConstraints;
  BoxConstraints get viewportConstraints => _viewportConstraints;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.controller ?? ScrollController();
  }

  @override
  void didUpdateWidget(ExpandableListV2 oldWidget) {
    super.didUpdateWidget(oldWidget);
    _handleReorderWhenExpanded();
  }

  static ExpandableListStateV2? of(BuildContext context) {
    return context.findAncestorStateOfType<ExpandableListStateV2>();
  }

  void _handleReorderWhenExpanded() {
    WidgetsBinding.instance!.scheduleFrameCallback((timeStamp) {
      if (!_isExpanded ||
          _expandedExpandable == null ||
          !_expandedExpandable!.mounted) {
        return;
      }
      final headerBox = _expandedExpandable!.getBox();
      final nextOffset = _calcOffsetOf(headerBox);
      _scrollController.jumpTo(nextOffset);
    });
  }

  void onToggleV2({
    required ExpandableState toggledExpandable,
  }) {
    setState(() {
      _isExpanded = !_isExpanded;
      if (!_isExpanded) {
        _expandedExpandable = null;
      }
    });
    if (_isExpanded) {
      previousOffset = _scrollController.offset;
      _expandedExpandable = toggledExpandable;
      final expandedHeaderBox = toggledExpandable.getBox();
      final nextOffset = _calcOffsetOf(expandedHeaderBox);
      _scrollTo(nextOffset);
    } else {
      _scrollTo(previousOffset);
    }
  }

  double _calcOffsetOf(BoxDetails expandedHeaderBox) {
    final listBox = getBoxOf(context);
    return _scrollController.offset +
        expandedHeaderBox.position.dy -
        listBox.position.dy;
  }

  void _scrollTo(double offset) {
    if (widget.animationData == null) {
      _scrollController.jumpTo(offset);
    } else {
      final data = widget.animationData!;
      _scrollController.animateTo(
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
        _viewportConstraints = constraints;
        return CustomScrollView(
          controller: _scrollController,
          physics: scrollPhysics,
          cacheExtent: double.maxFinite,
          slivers: [
            ...widget.slivers,
            if (_isExpanded)
              _buildExtraScrollableSpace(
                constraints,
              )
          ],
        );
      },
    );
  }
}
