import 'package:flutter/cupertino.dart';
import 'package:prtmobile/styles/styles.dart';

class ListHeader extends StatelessWidget {
  const ListHeader({
    Key? key,
    this.leading,
    this.trailing,
    this.isLoading = false,
    this.padding,
  }) : super(key: key);

  final Widget? leading;
  final Widget? trailing;
  final bool isLoading;
  final EdgeInsets? padding;

  static TextStyle get defaultTextStyle => AppTypography.h4;
  static const EdgeInsets defaultPadding = EdgeInsets.only(
    left: kDefaultPadding,
    right: kDefaultPadding,
    top: kDefaultPadding / 2,
    bottom: kDefaultPadding / 2,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? defaultPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              leading ?? const SizedBox(),
              if (isLoading)
                const Padding(
                  padding: EdgeInsets.only(
                    left: kDefaultPadding / 2,
                  ),
                  child: CupertinoActivityIndicator(
                    radius: RefreshIndicatorSizes.h4,
                  ),
                ),
            ],
          ),
          trailing ?? const SizedBox(),
        ],
      ),
    );
  }
}
