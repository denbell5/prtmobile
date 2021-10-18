import 'package:flutter/widgets.dart';

class Expandable extends StatefulWidget {
  const Expandable({
    Key? key,
    required this.header,
  }) : super(key: key);

  final Widget header;

  @override
  ExpandableState createState() => ExpandableState();
}

class ExpandableState extends State<Expandable> {
  var _isExpanded = false;

  void toggle() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  static ExpandableState? of(BuildContext context) {
    return context.findAncestorStateOfType<ExpandableState>();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('isExpanded: ${_isExpanded.toString()}'),
        widget.header,
      ],
    );
  }
}
