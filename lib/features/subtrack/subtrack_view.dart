import 'package:flutter/material.dart';
import 'package:prtmobile/models/models.dart';

class SubtrackView extends StatelessWidget {
  const SubtrackView({
    Key? key,
    required this.subtrack,
  }) : super(key: key);

  final Subtrack subtrack;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(subtrack.start.toString()),
      ],
    );
  }
}
