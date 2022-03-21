import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:prtmobile/core/core.dart';
import 'package:prtmobile/features/tracking/tracking.dart';

class TracksetView extends StatelessWidget {
  const TracksetView({
    Key? key,
    required this.trackset,
    required this.onHeaderLongPressed,
    required this.isSelected,
    required this.selectionModeEnabled,
    required this.toggleSelection,
  }) : super(key: key);

  final Trackset trackset;

  final void Function(String tracksetId) onHeaderLongPressed;
  final bool isSelected;
  final bool selectionModeEnabled;
  final void Function(String tracksetId) toggleSelection;

  Widget _buildHeader(BuildContext context) {
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

  @override
  Widget build(BuildContext context) {
    return Expandable(
      animationData: kExpandAnimationData,
      header: Builder(builder: (context) {
        return _buildHeader(context);
      }),
      body: TracksetBody(trackset: trackset),
    );
  }
}
