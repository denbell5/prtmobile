import 'package:flutter/widgets.dart';
import 'package:prtmobile/core/core.dart';

class InlineButton extends StatelessWidget {
  const InlineButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.padding,
  }) : super(key: key);

  final String text;
  final VoidCallback onTap;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    Widget content = Text(
      text,
      style: AppTypography.bodyText.greyed(),
    );
    return TouchableOpacity(
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: content,
      ),
      onTap: onTap,
    );
  }
}
