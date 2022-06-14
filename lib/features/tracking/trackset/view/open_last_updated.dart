import 'package:flutter/cupertino.dart';
import 'package:prtmobile/core/core.dart';

class OpenLastUpdatedSubtrackWidget extends StatelessWidget {
  const OpenLastUpdatedSubtrackWidget({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IconTextButton(
      iconWidget: const Icon(
        CupertinoIcons.chevron_right_2,
      ),
      textWidget: Text(
        'Go to last updated subtrack',
        style: AppTypography.h5.bolder(),
      ),
      onTap: onTap,
    );
  }
}
