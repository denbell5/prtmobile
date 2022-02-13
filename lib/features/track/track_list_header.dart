import 'package:flutter/cupertino.dart';
import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/styles/styles.dart';

class TrackListHeader extends StatelessWidget {
  const TrackListHeader({
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
    final leadingTextStyle = ListHeader.kSmallerTextStyle;
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
                    'Selected $selectedCount tracks',
                    style: leadingTextStyle,
                  ),
                ],
              )
            : Padding(
                padding: padding.copyWith(
                  right: 0,
                ),
                child: Text(
                  'Track List',
                  style: leadingTextStyle.bolder(),
                ),
              ),
        trailing: selectionModeEnabled
            ? TouchableIcon(
                iconData: CupertinoIcons.delete,
                onTap: onDeleteSelectedTapped,
                padding: padding,
                adjustToHeight: allowedHeight,
              )
            : Padding(
                padding: EdgeInsets.only(right: padding.left),
                child: IconTextButton(
                  text: 'Add',
                  icon: CupertinoIcons.add,
                  onTap: onAddTapped,
                ),
              ),
      ),
    );
  }
}
