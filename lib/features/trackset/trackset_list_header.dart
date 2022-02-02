import 'package:flutter/cupertino.dart';
import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/styles/styles.dart';

class TracksetListHeader extends StatelessWidget {
  const TracksetListHeader({
    Key? key,
    required this.isLoading,
    required this.selectionModeEnabled,
    required this.disableSelectionMode,
    required this.onAddTapped,
    required this.onDeleteSelectedTapped,
    required this.selectedCount,
  }) : super(key: key);

  final bool isLoading;
  final bool selectionModeEnabled;
  final VoidCallback disableSelectionMode;
  final VoidCallback onAddTapped;
  final VoidCallback onDeleteSelectedTapped;
  final int selectedCount;

  @override
  Widget build(BuildContext context) {
    const padding = ListHeader.defaultPadding;
    final leadingTextStyle = ListHeader.defaultTextStyle;
    final allowedHeight = padding.vertical +
        leadingTextStyle.fontSize! * leadingTextStyle.height!;

    return Padding(
      padding: const EdgeInsets.only(
        top: kDefaultPadding,
      ),
      child: ListHeader(
        isLoading: isLoading,
        padding: EdgeInsets.zero,
        leading: selectionModeEnabled
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TouchableIcon(
                    iconData: CupertinoIcons.xmark,
                    onTap: disableSelectionMode,
                    padding: padding.copyWith(
                      right: kDefaultPadding / 2,
                    ),
                    adjustToHeight: allowedHeight,
                  ),
                  Text(
                    'Selected $selectedCount tracksets',
                    style: leadingTextStyle,
                  ),
                ],
              )
            : Padding(
                padding: padding.copyWith(
                  right: 0,
                ),
                child: Text(
                  'Trackset List',
                  style: leadingTextStyle,
                ),
              ),
        trailing: selectionModeEnabled
            ? TouchableIcon(
                iconData: CupertinoIcons.delete,
                onTap: onDeleteSelectedTapped,
                padding: padding,
                adjustToHeight: allowedHeight,
              )
            : InlineButton(
                text: 'Add',
                onTap: onAddTapped,
                padding: padding,
              ),
      ),
    );
  }
}
