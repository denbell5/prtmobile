import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prtmobile/core/core.dart';
import 'package:prtmobile/features/tracking/tracking.dart';

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
    return BlocListener<TrackingBloc, TrackingState>(
      listener: (context, state) {
        if (state is TrackingUpdatedState &&
            state.tracksetIdToBeOpened != null) {
          if (trackset.id == state.tracksetIdToBeOpened) {
            ExpandableState.of(context)!.toggle();
          }
        }
      },
      child: ListItemHeader(
        labelText: 'Trackset',
        primaryText: trackset.name,
        secondaryText: Text(dateRange.toUpperCase()),
        onTap: () {
          if (selectionModeEnabled) {
            toggleSelection(trackset.id);
          } else {
            ExpandableState.of(context)!.toggle();
          }
        },
        onLongPress: () => onHeaderLongPressed(trackset.id),
        bgColor: isSelected ? AppColors.lightGrey : null,
      ),
    );
  }
}
