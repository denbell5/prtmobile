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

  @override
  Widget build(BuildContext context) {
    return Expandable(
      animationData: kExpandAnimationData,
      header: TracksetHeader(
        trackset: trackset,
        selectionModeEnabled: selectionModeEnabled,
        toggleSelection: toggleSelection,
        isSelected: isSelected,
        onHeaderLongPressed: onHeaderLongPressed,
      ),
      body: TracksetBody(trackset: trackset),
    );
  }
}
