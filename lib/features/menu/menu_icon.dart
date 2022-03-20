import 'package:flutter/cupertino.dart';
import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/features/menu/menu.dart';
import 'package:prtmobile/styles/styles.dart';

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
