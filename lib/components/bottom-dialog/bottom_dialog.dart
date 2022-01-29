// @dart=2.12

import 'package:flutter/cupertino.dart';
import 'package:prtmobile/features/home/home.dart';
import 'package:prtmobile/styles/styles.dart';

class BottomDialog extends StatelessWidget {
  const BottomDialog({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final systemBarHeight = MediaQuery.of(context).padding.top;
    final navbarHeight = calcNavbarHeight(systemBarHeight: systemBarHeight);
    return LayoutBuilder(
      builder: (context, constraints) {
        return ConstrainedBox(
          constraints: constraints.copyWith(
            minWidth: constraints.maxWidth,
            maxHeight: constraints.maxHeight - navbarHeight - 15,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                decoration: BoxDecoration(
                  color: CupertinoTheme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(kDefaultPadding * 0.75),
                    topRight: Radius.circular(kDefaultPadding * 0.75),
                  ),
                ),
                child: child,
              );
            },
          ),
        );
      },
    );
  }
}
