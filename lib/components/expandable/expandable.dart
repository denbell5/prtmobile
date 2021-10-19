export 'expandable_list.dart';

import 'package:flutter/widgets.dart';

typedef OnExpandableToggle = Function(bool isExpanded);

class Expandable extends StatefulWidget {
  const Expandable({
    Key? key,
    required this.header,
    required this.body,
    this.onToggle,
  }) : super(key: key);

  final Widget header;
  final Widget body;
  final OnExpandableToggle? onToggle;

  @override
  ExpandableState createState() => ExpandableState();
}

class ExpandableState extends State<Expandable> {
  var _isExpanded = false;

  void toggle() {
    final newValue = !_isExpanded;
    widget.onToggle?.call(newValue);
    setState(() {
      _isExpanded = newValue;
    });
  }

  static ExpandableState? of(BuildContext context) {
    return context.findAncestorStateOfType<ExpandableState>();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        widget.header,
        if (_isExpanded)
          Expanded(
            child: widget.body,
          ),
      ],
    );
  }
}
