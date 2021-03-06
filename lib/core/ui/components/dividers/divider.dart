import 'package:flutter/widgets.dart';
import 'package:prtmobile/core/core.dart';

class HorizontalDivider extends StatelessWidget {
  const HorizontalDivider({
    Key? key,
    this.color,
    this.height = kDividerHeight,
  }) : super(key: key);

  final double height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final _color = color ?? AppColors.lightGrey;
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            width: height,
            color: _color,
          ),
        ),
      ),
    );
  }
}
