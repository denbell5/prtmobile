export 'menu_icon.dart';

import 'package:flutter/cupertino.dart';
import 'package:prtmobile/core/core.dart';
import 'package:prtmobile/navigation/navigator.dart';
import 'package:prtmobile/navigation/routes.dart';

class AppMenu extends StatelessWidget {
  const AppMenu({Key? key}) : super(key: key);

  static Future<void> open(BuildContext context) {
    return showCupertinoModalPopup(
      context: context,
      useRootNavigator: false,
      builder: (context) {
        return const AppMenu();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomDialog(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Opacity(
                opacity: 0.0,
                child: TouchableIcon(
                  iconData: CupertinoIcons.xmark,
                  onTap: () {},
                ),
              ),
              Text(
                'Menu',
                style: AppTypography.h3.bolder(),
              ),
              TouchableIcon(
                iconData: CupertinoIcons.xmark,
                onTap: () {
                  AppNavigator.of(context).pop();
                },
              ),
            ],
          ),
          const HomeMenuItem(),
          const ForStudentsMenuItem(),
        ],
      ),
    );
  }
}

abstract class MenuItem extends StatelessWidget {
  const MenuItem({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @mustCallSuper
  void onTap(BuildContext context) {
    AppNavigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return TouchableWidget(
      onTap: () {
        onTap(context);
      },
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding * 2,
              vertical: kDefaultPadding / 2,
            ),
            child: Text(
              text,
              style: AppTypography.h3,
            ),
          ),
        ],
      ),
    );
  }
}

class HomeMenuItem extends MenuItem {
  const HomeMenuItem({
    Key? key,
  }) : super(text: 'Home', key: key);

  @override
  void onTap(BuildContext context) {
    super.onTap(context);
    AppNavigator.of(context).popUntil(
      (route) => route.settings.name == AppRoutes.home,
    );
  }
}

class ForStudentsMenuItem extends MenuItem {
  const ForStudentsMenuItem({
    Key? key,
  }) : super(text: 'For students', key: key);

  @override
  void onTap(BuildContext context) {
    super.onTap(context);
    AppNavigator.of(context).pushNamed(AppRoutes.store);
  }
}
