export 'expandable_list.dart';
export 'models.dart';
import 'package:flutter/widgets.dart';
import 'package:prtmobile/core/core.dart';
import 'package:prtmobile/misc/widget_position.dart';

typedef OnExpandableToggle = Function(bool isExpanded);

class Expandable extends StatefulWidget {
  const Expandable({
    Key? key,
    required this.header,
    required this.body,
    this.onToggle,
    required this.animationData,
  }) : super(key: key);

  final Widget header;
  final Widget body;
  final OnExpandableToggle? onToggle;
  final AnimationData animationData;

  @override
  ExpandableState createState() => ExpandableState();
}

class ExpandableState extends State<Expandable>
    with SingleTickerProviderStateMixin {
  var _isExpanded = false;
  late AnimationController _animationController;
  final headerKey = GlobalKey();
  late ExpandableListStateV2 _expandableListState;

  static ExpandableState? of(BuildContext context) {
    return context.findAncestorStateOfType<ExpandableState>();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationData.duration,
    );
    _expandableListState = ExpandableListStateV2.of(context)!;
  }

  void toggle() {
    final wasExpanded = _isExpanded;
    _isExpanded = !_isExpanded;
    _expandableListState.onToggleV2(toggledExpandable: this);
    if (wasExpanded) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
  }

  BoxDetails getBox() {
    final headerContext = headerKey.currentContext!;
    final box = getBoxOf(headerContext);
    return box;
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: _expandableListState.viewportConstraints,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildHeader(context),
          buildBody(context),
        ],
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return KeyedSubtree(
      key: headerKey,
      child: widget.header,
    );
  }

  Widget buildBody(BuildContext context) {
    return Flexible(
      child: SizeTransition(
        sizeFactor: CurvedAnimation(
          parent: _animationController,
          curve: widget.animationData.curve,
        ),
        child: widget.body,
      ),
    );
  }
}
