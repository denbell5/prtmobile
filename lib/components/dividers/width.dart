// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/widgets.dart';

class Width extends StatelessWidget {
  const Width(this.width);

  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}
