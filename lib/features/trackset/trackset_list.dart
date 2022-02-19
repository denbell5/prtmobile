import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prtmobile/bloc/tracking/tracking.bloc.dart';
import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/features/trackset/create/trackset_create.dart';
import 'package:prtmobile/misc/misc.dart';
import 'package:prtmobile/styles/styles.dart';
import 'package:prtmobile/utils/__mocks__/real_world.dart';

import 'trackset_view.dart';

final realWorldTracksets = getRealWorldTracksets();

class TracksetList extends StatefulWidget {
  const TracksetList({Key? key}) : super(key: key);

  @override
  _TracksetListState createState() => _TracksetListState();
}

class _TracksetListState extends State<TracksetList> {
  final listKey = GlobalKey<ExpandableListState>();

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

  void onToggle({
    required int index,
    required bool isExpanded,
  }) {
    listKey.currentState!.onToggle(
      index: index,
      isExpanded: isExpanded,
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
        return ExpandableList(
          key: listKey,
          listHeader: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichListHeader(
                isLoading: isLoading,
                entityName: 'trackset',
                leadingTextStyle: ListHeader.kTextStyle,
                onAddTapped: () => _openTracksetCreateDialog(context),
                selectionModeEnabled: _listSelector.selectionModeEnabled,
                disableSelectionMode: _listSelector.disableSelectionMode,
                onDeleteSelectedTapped: () => _deleteSelectedTracksets(context),
                selectedCount: _listSelector.selectedIds.length,
              ),
              if (errorMessage != null) errorMessage,
            ],
          ),
          expandableHeaderExtent: kListItemHeaderHeight,
          animationData: kExpandAnimationData,
          children: tracksets.entities
              .asMap()
              .map((index, trackset) => MapEntry(
                  index,
                  TracksetView(
                    key: ValueKey(trackset.id),
                    trackset: tracksets.entities[index],
                    isSelected: _listSelector.selectedIds.contains(trackset.id),
                    selectionModeEnabled: _listSelector.selectionModeEnabled,
                    onHeaderLongPressed: _enableSelectionMode,
                    toggleSelection: _listSelector.toggleItemSelection,
                    onToggle: (isExpanded) => onToggle(
                      index: index,
                      isExpanded: isExpanded,
                    ),
                  )))
              .values
              .toList(),
        );
      },
    );
  }
}
