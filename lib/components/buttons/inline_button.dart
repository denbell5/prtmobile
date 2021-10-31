import 'package:flutter/widgets.dart';
import 'package:prtmobile/styles/styles.dart';

import 'buttons.dart';

class InlineButton extends StatelessWidget {
  const InlineButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.padded = true,
  }) : super(key: key);

  final String text;
  final VoidCallback onTap;
  final bool padded;

  @override
  Widget build(BuildContext context) {
    Widget content = Text(
      text,
      style: AppTypography.bodyText.greyed(),
    );
    if (padded) {
      content = Padding(
        padding: const EdgeInsets.only(
          top: kHorizontalPadding * 0.5,
          bottom: kHorizontalPadding * 0.5,
          left: kHorizontalPadding,
        ),
        child: content,
      );
    }
    return TouchableOpacity(
      child: content,
      onPressed: onTap,
    );
  }
}
