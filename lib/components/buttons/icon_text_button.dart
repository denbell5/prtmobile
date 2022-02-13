import 'package:flutter/cupertino.dart';
import 'package:prtmobile/styles/styles.dart';

import 'buttons.dart';

class IconTextButton extends StatelessWidget {
  const IconTextButton({
    Key? key,
    this.onTap,
    this.text,
    this.textWidget,
    this.icon,
    this.iconWidget,
    this.padding,
  })  : assert(text != null || textWidget != null),
        assert(icon != null || iconWidget != null),
        super(key: key);

  final VoidCallback? onTap;

  final String? text;
  final Widget? textWidget;

  final IconData? icon;
  final Widget? iconWidget;

  final EdgeInsets? padding;

  static const kEdgeInsets = EdgeInsets.symmetric(
    vertical: kDefaultPadding / 3,
    horizontal: kDefaultPadding / 2,
  );
  static const kSpaceBetweenIconAndText = kDefaultPadding / 4;

  static final kTextStyle = AppTypography.h5;
  static final kIconSize = kTextStyle.fontSize! + 5;

  @override
  Widget build(BuildContext context) {
    return Button(
      bordered: false,
      padding: padding ?? kEdgeInsets,
      onTap: onTap,
      child: Row(
        children: [
          iconWidget ??
              Icon(
                icon,
                size: kIconSize,
              ),
          const SizedBox(width: kSpaceBetweenIconAndText),
          textWidget ??
              Text(
                text!,
                style: kTextStyle,
              ),
        ],
      ),
    );
  }
}
