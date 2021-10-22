import 'package:flutter/widgets.dart';
import 'package:prtmobile/styles/styles.dart';

import 'buttons.dart';

class InlineButton extends StatelessWidget {
  const InlineButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      child: Text(
        text,
        style: AppTypography.bodyText.greyed(),
      ),
      onPressed: onTap,
    );
  }
}
