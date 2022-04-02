import 'package:flutter/cupertino.dart';
import 'package:prtmobile/core/core.dart';
import 'package:prtmobile/features/tracking/models/models.dart';

class TracksetHeader extends StatelessWidget {
  const TracksetHeader({
    Key? key,
    required this.trackset,
    required this.selectionModeEnabled,
    required this.toggleSelection,
    required this.isSelected,
    required this.onHeaderLongPressed,
  }) : super(key: key);

  final Trackset trackset;
  final bool selectionModeEnabled;
  final void Function(String tracksetId) toggleSelection;
  final bool isSelected;
  final void Function(String tracksetId) onHeaderLongPressed;

  @override
  Widget build(BuildContext context) {
    final startDate = formatDate(trackset.startAt);
    final endDate = formatDate(trackset.endAt);
    final dateRange = '$startDate - $endDate';
    return ListItemHeader(
      labelText: 'Trackset',
      primaryText: dateRange.toUpperCase(),
      secondaryText: Text(trackset.name),
      onTap: () {
        if (selectionModeEnabled) {
          toggleSelection(trackset.id);
        } else {
          ExpandableState.of(context)!.toggle();
        }
      },
      onLongPress: () => onHeaderLongPressed(trackset.id),
      bgColor: isSelected ? AppColors.lightGrey : null,
    );
  }
}
