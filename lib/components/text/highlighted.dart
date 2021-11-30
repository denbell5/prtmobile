import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:prtmobile/styles/styles.dart';

const kHighlightedVerticalPadding = 2.0;
const kHighlightedHorizontalPadding = kDefaultPadding / 3;

class Highlighted extends StatelessWidget {
  const Highlighted({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.lightGrey, // TODO: theme
      padding: const EdgeInsets.symmetric(
        vertical: kHighlightedVerticalPadding,
        horizontal: kHighlightedHorizontalPadding,
      ),
      child: child,
    );
  }
}
