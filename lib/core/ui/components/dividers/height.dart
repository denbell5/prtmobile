// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/widgets.dart';

class Height extends StatelessWidget {
  const Height(this.height);

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}
