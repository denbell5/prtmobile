import 'package:flutter/cupertino.dart';
import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/styles/styles.dart';
import 'package:prtmobile/utils/utils.dart';

class RichListHeader extends StatelessWidget {
  const RichListHeader({
    Key? key,
    required this.isLoading,
    required this.selectionModeEnabled,
    required this.disableSelectionMode,
    required this.onAddTapped,
    required this.onDeleteSelectedTapped,
    required this.selectedCount,
    required this.entityName,
    required this.leadingTextStyle,
  }) : super(key: key);

  final bool isLoading;
  final bool selectionModeEnabled;
  final VoidCallback disableSelectionMode;
  final VoidCallback onAddTapped;
  final VoidCallback onDeleteSelectedTapped;
  final int selectedCount;
  final String entityName;
  final TextStyle leadingTextStyle;

  @override
  Widget build(BuildContext context) {
    const padding = ListHeader.defaultPadding;
    final allowedHeight = padding.vertical +
        leadingTextStyle.fontSize! * leadingTextStyle.height!;

    return ListHeader(
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
                  'Selected $selectedCount ${pluralize(entityName, count: selectedCount)}',
                  style: leadingTextStyle,
                ),
              ],
            )
          : Padding(
              padding: padding.copyWith(
                right: 0,
              ),
              child: Text(
                '${capitalize(entityName)} List',
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
    );
  }
}

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

  static TextStyle get kTextStyle => AppTypography.h4;
  static TextStyle get kSmallerTextStyle => kTextStyle.copyWith(
        fontSize: FontSizes.h4 - 2,
      );

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
