import 'package:flutter/cupertino.dart';
import 'package:prtmobile/bloc/tracking/tracking.bloc.dart';

import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/features/track/create/track_create.dart';
import 'package:prtmobile/features/track/track_list_header.dart';
import 'package:prtmobile/features/track/track_view.dart';
import 'package:prtmobile/models/models.dart';
import 'package:prtmobile/styles/styles.dart';

import 'edit/trackset_edit.dart';

class TracksetBody extends StatefulWidget {
  const TracksetBody({
    Key? key,
    required this.trackset,
  }) : super(key: key);

  final Trackset trackset;

  @override
  State<TracksetBody> createState() => _TracksetBodyState();
}

class _TracksetBodyState extends State<TracksetBody> {
  final trackListKey = GlobalKey<ExpandableListState>();

  bool _selectionModeEnabled = false;
  final Set<String> _selectedTrackIds = {};

  Trackset get trackset => widget.trackset;

  void onToggle({
    required int index,
    required bool isExpanded,
  }) {
    trackListKey.currentState!.onToggle(
      index: index,
      isExpanded: isExpanded,
    );
  }

  Future<void> _openTracksetEditDialog(BuildContext context) async {
    await showCupertinoModalPopup(
      context: context,
      useRootNavigator: true,
      builder: (context) {
        return TracksetEditDialog(
          trackset: trackset,
        );
      },
    );
  }

  Future<void> _openTrackCreateDialog(BuildContext context) async {
    await showCupertinoModalPopup(
      context: context,
      useRootNavigator: false,
      builder: (context) {
        return TrackCreateDialog(
          tracksetId: trackset.id,
        );
      },
    );
  }

  void _enableSelectionMode(String tracksetId) {
    if (_selectionModeEnabled) return;
    if (trackListKey.currentState!.isExpanded) return;
    setState(() {
      _selectedTrackIds.add(tracksetId);
      _selectionModeEnabled = true;
    });
  }

  void _disableSelectionMode() {
    setState(() {
      _selectedTrackIds.clear();
      _selectionModeEnabled = false;
    });
  }

  void _toggleSelection(String trackId) {
    if (_selectedTrackIds.contains(trackId)) {
      setState(() {
        _selectedTrackIds.remove(trackId);
      });
    } else {
      setState(() {
        _selectedTrackIds.add(trackId);
      });
    }
  }

  void _deleteSelectedTracks(BuildContext context) async {
    final selectedIds = Set<String>.from(_selectedTrackIds);
    if (selectedIds.isEmpty) return;

    bool canProceed = await showCupertinoDialog(
      context: context,
      builder: (context) {
        return YesNoDialog(
          title: Text(
            'Delete ${selectedIds.length} selected track${selectedIds.length == 1 ? '' : 's'}?',
            style: AppTypography.h5,
          ),
        );
      },
    );

    if (canProceed) {
      _disableSelectionMode();
      TrackingBloc.of(context).add(
        TracksDeleted(
          ids: selectedIds,
          tracksetId: trackset.id,
        ),
      );
    }
  }

  Widget _buildTracksetControls(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: kDefaultPadding - IconTextButton.kEdgeInsets.left,
        right: kDefaultPadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconTextButton(
            text: 'Edit',
            icon: CupertinoIcons.pen,
            onTap: () {
              _openTracksetEditDialog(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTracksetStats(BuildContext context) {
    const divider = SizedBox(height: kDefaultPadding * 0.5);
    return Padding(
      padding: const EdgeInsets.only(
        left: kDefaultPadding,
        right: kDefaultPadding,
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(CupertinoIcons.calendar),
                  RichText(
                    text: TextSpan(
                      style: CupertinoTheme.of(context).textTheme.textStyle,
                      children: <TextSpan>[
                        TextSpan(
                          text: ' ${trackset.daysLeft().toString()} ',
                          style: StatStyles.kAccentTextStyle,
                        ),
                        TextSpan(
                          text: 'days left,',
                          style: StatStyles.kSecondaryTextStyle,
                        ),
                        TextSpan(
                          text: ' ${trackset.daysPassed()} ',
                          style: StatStyles.kAccentTextStyle,
                        ),
                        TextSpan(
                          text: 'out of',
                          style: StatStyles.kSecondaryTextStyle,
                        ),
                        TextSpan(
                          text: ' ${trackset.totalDays} ',
                          style: StatStyles.kAccentTextStyle,
                        ),
                        TextSpan(
                          text: 'passed',
                          style: StatStyles.kSecondaryTextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              divider,
              Row(
                children: [
                  const Icon(CupertinoIcons.graph_square),
                  RichText(
                    text: TextSpan(
                      style: CupertinoTheme.of(context).textTheme.textStyle,
                      children: <TextSpan>[
                        TextSpan(
                          text: ' ${trackset.left} ',
                          style: StatStyles.kAccentTextStyle,
                        ),
                        TextSpan(
                          text: 'points to do,',
                          style: StatStyles.kSecondaryTextStyle,
                        ),
                        TextSpan(
                          text: ' ${trackset.done} ',
                          style: StatStyles.kSecondaryTextStyle,
                        ),
                        TextSpan(
                          text: 'out of',
                          style: StatStyles.kSecondaryTextStyle,
                        ),
                        TextSpan(
                          text: ' ${trackset.length} ',
                          style: StatStyles.kAccentTextStyle,
                        ),
                        TextSpan(
                          text: 'done',
                          style: StatStyles.kSecondaryTextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              divider,
              Row(
                children: [
                  const Icon(CupertinoIcons.speedometer),
                  RichText(
                    text: TextSpan(
                      style: CupertinoTheme.of(context).textTheme.textStyle,
                      children: <TextSpan>[
                        TextSpan(
                          text: ' ${trackset.dailyGoal} ',
                          style: StatStyles.kAccentTextStyle,
                        ),
                        TextSpan(
                          text: 'to complete daily',
                          style: StatStyles.kSecondaryTextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTrackList(BuildContext context) {
    final tracks = widget.trackset.tracks.entities;
    final trackViews = tracks
        .asMap()
        .map(
          (index, tr) => MapEntry(
            index,
            TrackView(
              key: ValueKey(tr.id),
              track: tr,
              onToggle: (isExpanded) {
                onToggle(
                  index: index,
                  isExpanded: isExpanded,
                );
              },
              onHeaderLongPressed: _enableSelectionMode,
              isSelected: _selectedTrackIds.contains(tr.id),
              selectionModeEnabled: _selectionModeEnabled,
              toggleSelection: _toggleSelection,
            ),
          ),
        )
        .values
        .toList();
    return trackViews;
  }

  @override
  Widget build(BuildContext context) {
    final trackViews = _buildTrackList(context);
    return ExpandableList(
      key: trackListKey,
      listHeader: Column(
        children: [
          _buildTracksetControls(context),
          const SizedBox(height: kDefaultPadding * 1.5),
          _buildTracksetStats(context),
          const SizedBox(height: kDefaultPadding),
          TrackListHeader(
            isLoading: false,
            selectionModeEnabled: _selectionModeEnabled,
            disableSelectionMode: _disableSelectionMode,
            onAddTapped: () => _openTrackCreateDialog(context),
            onDeleteSelectedTapped: () => _deleteSelectedTracks(context),
            selectedCount: _selectedTrackIds.length,
          ),
        ],
      ),
      expandableHeaderExtent: kTrackHeaderHeight,
      animationData: kExpandAnimationData,
      children: trackViews,
    );
  }
}
