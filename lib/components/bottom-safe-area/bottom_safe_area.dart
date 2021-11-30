import 'package:flutter/widgets.dart';

class BottomSafeArea extends StatelessWidget {
  const BottomSafeArea({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.only(
        bottom: bottomPadding,
      ),
      child: child,
    );
  }
}
