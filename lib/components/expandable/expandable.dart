export 'expandable_list.dart';
export 'models.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'models.dart';

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

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationData.duration,
    );
  }

  void toggle() {
    final wasExpanded = _isExpanded;
    _isExpanded = !_isExpanded;
    widget.onToggle?.call(_isExpanded);
    if (wasExpanded) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
  }

  static ExpandableState? of(BuildContext context) {
    return context.findAncestorStateOfType<ExpandableState>();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildHeader(context),
        buildBody(context),
      ],
    );
  }

  Widget buildHeader(BuildContext context) {
    return widget.header;
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
