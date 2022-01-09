// @dart=2.12

import 'package:flutter/cupertino.dart';
import 'package:prtmobile/styles/styles.dart';

class BottomDialog extends StatelessWidget {
  const BottomDialog({
    Key? key,
    required this.child,
    this.isVerticallyTight = false,
  }) : super(key: key);

  final Widget child;
  final bool isVerticallyTight;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ConstrainedBox(
          constraints: BoxConstraints.tightFor(
            width: constraints.maxWidth,
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
