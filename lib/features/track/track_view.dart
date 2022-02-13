import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/components/text/list_item_header.dart';
import 'package:prtmobile/features/subtrack/subtrack.dart';
import 'package:prtmobile/models/models.dart';
import 'package:prtmobile/styles/styles.dart';

import 'track_body.dart';

const kTrackHeaderHeight = 60.0;

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
    return ListItemHeader(
      primaryText: track.name,
      onTap: () {
        if (selectionModeEnabled) {
          toggleSelection(track.id);
        } else {
          ExpandableState.of(context)!.toggle();
        }
      },
      onLongPress: () => onHeaderLongPressed(track.id),
      bgColor: isSelected ? AppColors.lightGrey : null,
      primaryTextSize: FontSizes.h5,
      labelText: 'Track',
      height: kTrackHeaderHeight,
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
