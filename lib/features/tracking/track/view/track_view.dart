import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prtmobile/core/core.dart';
import 'package:prtmobile/features/tracking/tracking.dart';

class TrackView extends StatelessWidget {
  const TrackView({
    Key? key,
    required this.track,
    required this.onToggle,
    required this.onHeaderLongPressed,
    required this.isSelected,
    required this.selectionModeEnabled,
    required this.toggleSelection,
  }) : super(key: key);

  final Track track;
  final void Function(bool) onToggle;
  final void Function(String tracksetId) onHeaderLongPressed;
  final bool isSelected;
  final bool selectionModeEnabled;
  final void Function(String tracksetId) toggleSelection;

  Widget _buildHeader(BuildContext context) {
    return BlocListener<TrackingBloc, TrackingState>(
      listener: (context, state) {
        if (state is TrackingUpdatedState && state.trackIdToBeOpened != null) {
          if (track.id == state.trackIdToBeOpened) {
            final expandable = ExpandableState.of(context)!;
            if (!expandable.isExpanded) {
              ExpandableState.of(context)!.toggle();
            }
          }
        }
      },
      child: ListItemHeader(
        primary: Text(
          track.name,
          style: AppTypography.h5,
          maxLines: 2,
        ),
        onTap: () {
          if (selectionModeEnabled) {
            toggleSelection(track.id);
          } else {
            ExpandableState.of(context)!.toggle();
          }
        },
        onLongPress: () => onHeaderLongPressed(track.id),
        bgColor: isSelected ? AppColors.lightGrey : null,
        labelText: 'Track',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expandable(
      onToggle: onToggle,
      animationData: kExpandAnimationData,
      header: Builder(
        builder: (context) {
          return _buildHeader(context);
        },
      ),
      body: BlocProvider<SelectedSubtrackCubit>(
        create: (ctx) => SelectedSubtrackCubit(),
        child: TrackBody(track: track),
      ),
    );
  }
}
