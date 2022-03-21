import 'package:flutter/cupertino.dart';
import 'package:prtmobile/core/core.dart';
import 'package:prtmobile/features/menu/menu.dart';

class MenuIcon extends StatelessWidget {
  const MenuIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TouchableIcon(
      iconData: CupertinoIcons.line_horizontal_3,
      color: AppColors.white,
      size: FontSizes.h2,
      onTap: () {
        AppMenu.open(context);
      },
    );
  }
}
