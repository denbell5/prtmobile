import 'package:flutter/cupertino.dart';
import 'package:prtmobile/features/tracking/tracking.dart';

import 'package:prtmobile/core/core.dart';

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
  final trackListKey = GlobalKey<ExpandableListStateV2>();
  final _trackListSelector = ListSelector<String>();

  Trackset get trackset => widget.trackset;

  @override
  void initState() {
    super.initState();
    _trackListSelector.addListener(() {
      setState(() {});
    });
  }

  void onToggle({
    required int index,
    required bool isExpanded,
  }) {}

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

  void _enableSelectionMode(String trackId) {
    if (trackListKey.currentState!.isExpanded) return;
    _trackListSelector.enableSelectionMode(itemId: trackId);
  }

  void _deleteSelectedTracks(BuildContext context) async {
    _trackListSelector.deleteSelectedItems(
      confirmDeletion: (selectedIds) {
        return ConfirmDeletionDialog.askConfirmation(
          context,
          dialog: ConfirmDeletionDialog(
            deletedCount: selectedIds.length,
            entityName: 'track',
          ),
        );
      },
      delete: (selectedIds) {
        TrackingBloc.of(context).add(
          TracksDeleted(
            ids: selectedIds,
            tracksetId: trackset.id,
          ),
        );
      },
    );
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
    const divider = Height(kDefaultPadding * 0.5);
    return Padding(
      padding: const EdgeInsets.only(
        left: kDefaultPadding,
        right: kDefaultPadding,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
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
                const Height(kDefaultPadding * 1.5),
                ProgressBar(
                  progress: trackset.progress,
                  height: 8,
                ),
              ],
            ),
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
              isSelected: _trackListSelector.selectedIds.contains(tr.id),
              selectionModeEnabled: _trackListSelector.selectionModeEnabled,
              toggleSelection: _trackListSelector.toggleItemSelection,
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
    return ExpandableListV2(
      key: trackListKey,
      animationData: kExpandAnimationData,
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              _buildTracksetControls(context),
              const Height(kDefaultPadding * 1.5),
              _buildTracksetStats(context),
              const Height(kDefaultPadding * 1.5),
              RichListHeader(
                isLoading: false,
                selectionModeEnabled: _trackListSelector.selectionModeEnabled,
                disableSelectionMode: _trackListSelector.disableSelectionMode,
                onAddTapped: () => _openTrackCreateDialog(context),
                onDeleteSelectedTapped: () => _deleteSelectedTracks(context),
                selectedCount: _trackListSelector.selectedIds.length,
                entityName: 'track',
                leadingTextStyle: ListHeader.kSmallerTextStyle,
              ),
            ],
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            trackViews,
          ),
        ),
      ],
    );
  }
}
