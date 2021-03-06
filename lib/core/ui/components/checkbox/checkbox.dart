import 'package:flutter/cupertino.dart';
import 'package:prtmobile/core/core.dart';

class Checkbox extends StatelessWidget {
  const Checkbox({
    Key? key,
    required this.checked,
  }) : super(key: key);

  final bool checked;

  @override
  Widget build(BuildContext context) {
    final icon =
        checked ? CupertinoIcons.checkmark_square_fill : CupertinoIcons.square;
    return Icon(
      icon,
      color: AppColors.black,
      size: 21,
    );
  }
}
