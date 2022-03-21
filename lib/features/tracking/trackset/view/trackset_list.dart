import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prtmobile/features/tracking/tracking.dart';
import 'package:prtmobile/core/core.dart';

class TracksetList extends StatefulWidget {
  const TracksetList({Key? key}) : super(key: key);

  @override
  _TracksetListState createState() => _TracksetListState();
}

class _TracksetListState extends State<TracksetList> {
  final listKey = GlobalKey<ExpandableListStateV2>();

  final _listSelector = ListSelector<String>();

  @override
  void initState() {
    super.initState();
    _requestTracksets();
    _listSelector.addListener(() {
      setState(() {});
    });
  }

  void _requestTracksets() {
    final bloc = TrackingBloc.of(context);
    bloc.add(TracksetsRequested());
  }

  Future<void> _openTracksetCreateDialog(BuildContext context) async {
    await showCupertinoModalPopup(
      context: context,
      useRootNavigator: false,
      builder: (context) {
        return const TracksetCreateDialog();
      },
    );
  }

  void _enableSelectionMode(String tracksetId) {
    if (listKey.currentState!.isExpanded) return;
    _listSelector.enableSelectionMode(itemId: tracksetId);
  }

  void _deleteSelectedTracksets(BuildContext context) async {
    _listSelector.deleteSelectedItems(
      confirmDeletion: (selectedIds) {
        return ConfirmDeletionDialog.askConfirmation(
          context,
          dialog: ConfirmDeletionDialog(
            deletedCount: selectedIds.length,
            entityName: 'trackset',
          ),
        );
      },
      delete: (selectedIds) {
        TrackingBloc.of(context).add(
          TracksetsDeleted(selectedIds),
        );
      },
    );
  }

  Widget? _buildErrorMessage(TrackingState state) {
    if (state is! TrackingErrorState ||
        state.failedEvent is! TracksetsRequested) {
      return null;
    }
    return Center(
      child: ErrorMessage(
        description: state.description,
        onRetry: _requestTracksets,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackingBloc, TrackingState>(
      builder: (context, state) {
        final tracksets = state.tracksets;
        final errorMessage = _buildErrorMessage(state);
        final isLoading = state is TrackingLoadingState;
        return ExpandableListV2(
          key: listKey,
          animationData: kExpandAnimationData,
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  RichListHeader(
                    isLoading: isLoading,
                    entityName: 'trackset',
                    leadingTextStyle: ListHeader.kTextStyle,
                    onAddTapped: () => _openTracksetCreateDialog(context),
                    selectionModeEnabled: _listSelector.selectionModeEnabled,
                    disableSelectionMode: _listSelector.disableSelectionMode,
                    onDeleteSelectedTapped: () =>
                        _deleteSelectedTracksets(context),
                    selectedCount: _listSelector.selectedIds.length,
                  ),
                  if (errorMessage != null) errorMessage,
                  ...tracksets.entities
                      .map(
                        (trackset) => TracksetView(
                          key: ValueKey(trackset.id),
                          trackset: trackset,
                          isSelected:
                              _listSelector.selectedIds.contains(trackset.id),
                          selectionModeEnabled:
                              _listSelector.selectionModeEnabled,
                          onHeaderLongPressed: _enableSelectionMode,
                          toggleSelection: _listSelector.toggleItemSelection,
                        ),
                      )
                      .toList()
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
