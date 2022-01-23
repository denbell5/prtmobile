import 'package:flutter/cupertino.dart';
import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/styles/styles.dart';

class ListHeader extends StatelessWidget {
  const ListHeader({
    Key? key,
    required this.text,
    required this.onAddTap,
    this.isLoading = false,
  }) : super(key: key);

  final String text;
  final VoidCallback onAddTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: kDefaultPadding,
        right: kDefaultPadding,
        bottom: kDefaultPadding / 2,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(text, style: AppTypography.h4),
              if (isLoading)
                const Padding(
                  padding: EdgeInsets.only(left: kDefaultPadding),
                  child: CupertinoActivityIndicator(
                    radius: RefreshIndicatorSizes.h4,
                  ),
                ),
            ],
          ),
          InlineButton(text: 'Add', onTap: onAddTap),
        ],
      ),
    );
  }
}
