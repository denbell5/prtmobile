import 'package:flutter/cupertino.dart';
import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/styles/styles.dart';

const kListItemHeaderHeight = 80.0;

class ListItemHeader extends StatelessWidget {
  const ListItemHeader({
    Key? key,
    this.primaryText,
    this.secondaryText,
    required this.onTap,
    this.onLongPress,
    this.bgColor,
    this.primaryTextSize,
    this.label,
    this.labelText,
    this.height,
    this.primary,
    this.trailing,
  })  : assert(!(label != null && labelText != null)),
        super(key: key);

  final String? primaryText;
  final Widget? secondaryText;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  final Color? bgColor;

  final double? primaryTextSize;

  final Widget? label;
  final String? labelText;

  final double? height;
  final Widget? primary;

  final Widget? trailing;

  static final labelTextStyle = AppTypography.small.bold().height1();

  List<Widget> _buildTextWidgets() {
    Widget primary = this.primary ??
        Text(
          primaryText!,
          style: AppTypography.h4.copyWith(
            fontSize: primaryTextSize,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        );

    return [
      if (label != null) label!,
      if (labelText != null)
        Text(
          labelText!,
          style: labelTextStyle,
        ),
      primary,
      if (secondaryText != null) secondaryText!,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildTextWidgets(),
    );
    return TouchableWidget(
      onTap: onTap,
      onLongPress: onLongPress,
      child: AnimatedContainer(
        color: bgColor ?? CupertinoTheme.of(context).scaffoldBackgroundColor,
        duration: const Duration(milliseconds: 200),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding,
          ),
          child: SizedBox(
            height: height ?? kListItemHeaderHeight,
            child: Row(
              children: [
                Expanded(
                  child: content,
                ),
                if (trailing != null) trailing!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
