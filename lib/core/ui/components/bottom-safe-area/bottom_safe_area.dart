import 'package:flutter/widgets.dart';

typedef BottomSafeAreaChildBuilder = Widget Function(
  BuildContext context,
  double bottomInset,
);

class BottomSafeArea extends StatelessWidget {
  const BottomSafeArea({
    Key? key,
    this.child,
    this.builder,
  })  : assert(child != null || builder != null),
        super(key: key);

  final Widget? child;
  final BottomSafeAreaChildBuilder? builder;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.only(
        bottom: bottomPadding,
      ),
      child: builder?.call(context, bottomPadding) ?? child!,
    );
  }
}
