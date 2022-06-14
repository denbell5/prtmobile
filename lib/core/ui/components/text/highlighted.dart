import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:prtmobile/core/core.dart';

const kHighlightedVerticalPadding = 2.0;
const kHighlightedHorizontalPadding = kDefaultPadding / 3;

class Highlighted extends StatelessWidget {
  const Highlighted({
    Key? key,
    required this.child,
    this.horizontalInset,
  }) : super(key: key);

  final Widget child;
  final double? horizontalInset;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.lightGrey,
      padding: EdgeInsets.symmetric(
        vertical: kHighlightedVerticalPadding,
        horizontal: horizontalInset ?? kHighlightedHorizontalPadding,
      ),
      child: child,
    );
  }
}
