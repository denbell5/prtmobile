export 'expandable_list.dart';
export 'models.dart';
import 'package:flutter/widgets.dart';
import 'package:prtmobile/core/core.dart';

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
  bool get isExpanded => _isExpanded;

  late AnimationController _animationController;
  final headerKey = GlobalKey();
  late ExpandableListState _expandableListState;

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
    _expandableListState = ExpandableListState.of(context)!;
  }

  void toggle() async {
    final wasExpanded = _isExpanded;
    if (!wasExpanded) {
      setState(() {
        _isExpanded = !_isExpanded;
      });
    }

    _expandableListState.onToggle(toggledExpandable: this);
    if (wasExpanded) {
      await _animationController.reverse();
    } else {
      await _animationController.forward();
    }

    if (wasExpanded) {
      setState(() {
        _isExpanded = !_isExpanded;
      });
    }
  }

  BoxDetails getBox() {
    final headerContext = headerKey.currentContext!;
    final box = getBoxOf(headerContext);
    return box;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<BoxConstraints?>(
      valueListenable: _expandableListState.viewportConstraints,
      builder: (context, constraints, _) {
        return ConstrainedBox(
          constraints: constraints!,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildHeader(context),
              buildBody(context),
            ],
          ),
        );
      },
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
        child: Offstage(
          offstage: !_isExpanded,
          child: widget.body,
        ),
      ),
    );
  }
}
