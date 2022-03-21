import 'package:flutter/cupertino.dart';
import 'package:prtmobile/core/core.dart';

class AppNavbar extends StatelessWidget
    implements ObstructingPreferredSizeWidget {
  const AppNavbar({
    Key? key,
    required this.topBarPadding,
    this.leading,
    this.trailing,
    this.middle,
  }) : super(key: key);

  final double topBarPadding;
  final Widget? leading;
  final Widget? trailing;
  final Widget? middle;

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: CupertinoTheme.of(context).barBackgroundColor,
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.only(
          top: topBarPadding + kDefaultPadding,
          bottom: kDefaultPadding / 3,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerLeft,
                child: leading ?? const Nothing(),
              ),
            ),
            if (middle != null)
              Expanded(
                flex: 4,
                child: Align(
                  child: middle,
                ),
              ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerRight,
                child: trailing ?? const Nothing(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(topBarPadding + 65);

  @override
  bool shouldFullyObstruct(BuildContext context) {
    return true;
  }
}
