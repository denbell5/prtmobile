import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prtmobile/features/tracking/tracking.dart';
import 'package:prtmobile/core/core.dart';

class TrackBody extends StatefulWidget {
  const TrackBody({
    Key? key,
    required this.track,
  }) : super(key: key);

  final Track track;

  @override
  State<TrackBody> createState() => _TrackBodyState();
}

class _TrackBodyState extends State<TrackBody> with ListBuilder {
  Track get track => widget.track;

  final _subtrackListSelector = ListSelector<String>();

  @override
  void initState() {
    super.initState();
    _subtrackListSelector.addListener(() {
      setState(() {});
    });
  }

  Future<void> _openTrackEditDialog(BuildContext context) async {
    await showCupertinoModalPopup(
      context: context,
      useRootNavigator: true,
      builder: (context) {
        return TrackEditDialog(
          track: track,
        );
      },
    );
  }

  void _deleteSelectedSubtracks(BuildContext context) async {
    _subtrackListSelector.deleteSelectedItems(
      confirmDeletion: (selectedIds) {
        return ConfirmDeletionDialog.askConfirmation(
          context,
          dialog: ConfirmDeletionDialog(
            deletedCount: selectedIds.length,
            entityName: 'subtrack',
          ),
        );
      },
      delete: (selectedIds) {
        TrackingBloc.of(context).add(
          SubtracksDeleted(
            ids: selectedIds,
            trackId: track.id,
            tracksetId: track.tracksetId,
          ),
        );
      },
    );
  }

  Widget _buildTrackControls(BuildContext context) {
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
              _openTrackEditDialog(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTrackStats(BuildContext context) {
    const divider = SizedBox(height: kDefaultPadding * 0.5);
    return Padding(
      padding: const EdgeInsets.only(
        left: kDefaultPadding,
        right: kDefaultPadding,
        top: kDefaultPadding / 4,
        bottom: kDefaultPadding,
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(CupertinoIcons.collections),
                  RichText(
                    text: TextSpan(
                      style: CupertinoTheme.of(context).textTheme.textStyle,
                      children: <TextSpan>[
                        TextSpan(
                          text: ' ${track.subtracks.all.length} ',
                          style: StatStyles.kAccentTextStyle,
                        ),
                        TextSpan(
                          text: 'subtracks',
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
                          text: ' ${track.left} ',
                          style: StatStyles.kAccentTextStyle,
                        ),
                        TextSpan(
                          text: 'points to do,',
                          style: StatStyles.kSecondaryTextStyle,
                        ),
                        TextSpan(
                          text: ' ${track.done} ',
                          style: StatStyles.kAccentTextStyle,
                        ),
                        TextSpan(
                          text: 'out of',
                          style: StatStyles.kSecondaryTextStyle,
                        ),
                        TextSpan(
                          text: ' ${track.length} ',
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
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _openSubtrackCreateDialog(BuildContext context) async {
    await showCupertinoModalPopup(
      context: context,
      useRootNavigator: false,
      builder: (context) {
        return SubtrackCreateDialog(
          track: track,
        );
      },
    );
  }

  Widget _buildSubtrackListHeader(BuildContext context) {
    return RichListHeader(
      isLoading: false,
      selectionModeEnabled: _subtrackListSelector.selectionModeEnabled,
      disableSelectionMode: _subtrackListSelector.disableSelectionMode,
      onAddTapped: () => _openSubtrackCreateDialog(context),
      onDeleteSelectedTapped: () => _deleteSelectedSubtracks(context),
      selectedCount: _subtrackListSelector.selectedIds.length,
      entityName: 'subtrack',
      leadingTextStyle: ListHeader.kSmallerTextStyle,
    );
  }

  List<Widget> _buildSubtrackList(BuildContext context) {
    final subtracks = widget.track.subtracks.entities;
    return buildList(
      isDivided: false,
      itemCount: subtracks.length,
      itemBuilder: (index) => SubtrackView(
        subtrack: subtracks[index],
        onEnableSelectionMode: (subtrackId) {
          _subtrackListSelector.enableSelectionMode(itemId: subtrackId);
        },
        toggleItemSelection: _subtrackListSelector.toggleItemSelection,
        isSelected: _subtrackListSelector.selectedIds.contains(
          subtracks[index].id,
        ),
        selectionModeEnabled: _subtrackListSelector.selectionModeEnabled,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SelectedSubtrackCubit, SelectedSubtrackInfo>(
      listener: (ctx, selectedInfo) async {
        if (selectedInfo.id == null) {
          return;
        }
        await showCupertinoModalPopup(
          context: context,
          builder: (context) {
            return SubtrackUpdateDialog(
              subtrack: widget.track.subtracks.byId[selectedInfo.id]!,
              track: widget.track,
            );
          },
        );
        BlocProvider.of<SelectedSubtrackCubit>(context).emitChange(null);
      },
      child: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _buildTrackControls(context),
                const SizedBox(height: kDefaultPadding * 1.5),
                _buildTrackStats(context),
                const SizedBox(height: kDefaultPadding),
                _buildSubtrackListHeader(context),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              _buildSubtrackList(context),
            ),
          ),
        ],
      ),
    );
  }
}
