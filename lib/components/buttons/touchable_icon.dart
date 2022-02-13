import 'package:flutter/cupertino.dart';
import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/styles/styles.dart';

class TouchableIcon extends StatelessWidget {
  const TouchableIcon({
    Key? key,
    required this.iconData,
    required this.onTap,
    this.padding,
    this.adjustToHeight,
    this.color,
  }) : super(key: key);

  final IconData iconData;
  final VoidCallback onTap;
  final EdgeInsets? padding;
  final double? adjustToHeight;
  final Color? color;

  static const EdgeInsets defaultPadding = EdgeInsets.all(kDefaultPadding);

  @override
  Widget build(BuildContext context) {
    var iconSize = FontSizes.h3;
    var padding = this.padding ?? defaultPadding;
    if (adjustToHeight != null) {
      if (adjustToHeight! < iconSize) {
        iconSize = adjustToHeight!;
        padding = padding.copyWith(top: 0, bottom: 0);
      } else {
        final availableVertical = (adjustToHeight! - iconSize) / 2;
        padding = padding.copyWith(
          top: availableVertical,
          bottom: availableVertical,
        );
      }
    }
    return Align(
      alignment: Alignment.center,
      child: TouchableWidget(
        onTap: onTap,
        child: Padding(
          padding: padding,
          child: Icon(
            iconData,
            color: color ?? AppColors.black,
            size: FontSizes.h3,
          ),
        ),
      ),
    );
  }
}
