import 'package:flutter/widgets.dart';
import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/styles/styles.dart';

const kListItemHeaderHeight = 60.0;

class ListItemHeader extends StatelessWidget {
  const ListItemHeader({
    Key? key,
    required this.primaryText,
    required this.secondaryText,
    required this.onTap,
  }) : super(key: key);

  final String primaryText;
  final String secondaryText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TouchableOpacity(
      onPressed: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kHorizontalPadding,
        ),
        child: SizedBox(
          height: kListItemHeaderHeight,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      primaryText,
                      style: AppTypography.h4,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      secondaryText,
                      style: AppTypography.bodyText.greyed(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
