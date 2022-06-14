import 'package:flutter/widgets.dart';
import 'package:prtmobile/core/core.dart';

typedef ExpandableListBuilder = Expandable Function(
  BuildContext context,
  int index,
);

class ExpandableList extends StatefulWidget {
  const ExpandableList({
    Key? key,
    this.controller,
    this.animationData,
    this.slivers = const [],
  }) : super(key: key);

  final ScrollController? controller;
  final AnimationData? animationData;
  final List<Widget> slivers;

  @override
  ExpandableListState createState() => ExpandableListState();
}

class ExpandableListState extends State<ExpandableList> with ListBuilder {
  late ScrollController _scrollController;
  double previousOffset = 0.0;

  bool _isExpanded = false;
  bool get isExpanded => _isExpanded;

  bool _isScrolling = false;

  ExpandableState? _expandedExpandable;

  ScrollPhysics? get scrollPhysics => isExpanded
      ? const NeverScrollableScrollPhysics()
      : const ClampingScrollPhysics();

  final ValueNotifier<BoxConstraints?> viewportConstraints =
      ValueNotifier(null);

  @override
  void initState() {
    super.initState();
    _scrollController = widget.controller ?? ScrollController();
  }

  @override
  void didUpdateWidget(ExpandableList oldWidget) {
    super.didUpdateWidget(oldWidget);
    _handleReorderWhenExpanded();
  }

  static ExpandableListState? of(BuildContext context) {
    return context.findAncestorStateOfType<ExpandableListState>();
  }

  void _handleReorderWhenExpanded() {
    WidgetsBinding.instance!.scheduleFrameCallback((timeStamp) {
      if (!_isExpanded ||
          _expandedExpandable == null ||
          !_expandedExpandable!.mounted ||
          _isScrolling) {
        return;
      }
      final headerBox = _expandedExpandable!.getBox();
      final nextOffset = _calcOffsetFor(headerBox);
      _scrollController.jumpTo(nextOffset);
    });
  }

  void onToggle({
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
      final nextOffset = _calcOffsetFor(expandedHeaderBox);
      _scrollTo(nextOffset);
    } else {
      _scrollTo(previousOffset);
    }
  }

  double _calcOffsetFor(BoxDetails expandedHeaderBox) {
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

  void _watchIsScrolling(ScrollNotification notification) {
    if (notification.depth != 0) {
      return;
    }
    if (notification is ScrollEndNotification) {
      _isScrolling = false;
    } else if (notification is ScrollStartNotification) {
      _isScrolling = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        viewportConstraints.value = constraints;
        return NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            _watchIsScrolling(notification);
            return false;
          },
          child: CustomScrollView(
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
          ),
        );
      },
    );
  }
}
