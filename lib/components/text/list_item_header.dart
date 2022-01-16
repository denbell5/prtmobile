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
    this.axis = Axis.vertical,
  }) : super(key: key);

  final String primaryText;
  final String secondaryText;
  final VoidCallback onTap;
  final Axis axis;

  List<Widget> _buildTextWidgets() {
    return [
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
    ];
  }

  @override
  Widget build(BuildContext context) {
    final content = axis == Axis.vertical
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildTextWidgets(),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: _buildTextWidgets(),
          );
    return TouchableOpacity(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
        ),
        child: SizedBox(
          height: kListItemHeaderHeight,
          child: Row(
            children: [
              Expanded(
                child: content,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
