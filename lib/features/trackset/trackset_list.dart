import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prtmobile/bloc/tracking/tracking.bloc.dart';
import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/components/text/list_item_header.dart';
import 'package:prtmobile/features/trackset/create/trackset_create.dart';
import 'package:prtmobile/features/trackset/trackset_list_header.dart';

import 'package:prtmobile/models/models.dart';
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

  bool _selectionModeEnabled = false;
  final Set<String> _selectedTracksetIds = {};

  @override
  void initState() {
    super.initState();
    _requestTracksets();
  }

  void _requestTracksets() {
    final bloc = TrackingBloc.of(context);
    bloc.add(TracksetsRequested());
  }

  Future<void> _openTracksetCreateDialog(BuildContext context) async {
    await showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return const TracksetCreateDialog();
      },
    );
  }

  void _enableSelectionMode(String tracksetId) {
    if (_selectionModeEnabled) return;
    if (listKey.currentState!.isExpanded) return;
    setState(() {
      _selectedTracksetIds.add(tracksetId);
      _selectionModeEnabled = true;
    });
  }

  void _disableSelectionMode() {
    setState(() {
      _selectedTracksetIds.clear();
      _selectionModeEnabled = false;
    });
  }

  void _toggleSelection(String tracksetId) {
    if (_selectedTracksetIds.contains(tracksetId)) {
      setState(() {
        _selectedTracksetIds.remove(tracksetId);
      });
    } else {
      setState(() {
        _selectedTracksetIds.add(tracksetId);
      });
    }
  }

  NormalizedList<Trackset, String> getTracksets() {
    // var tracksets = TracksetFactory.buildTracksets(5);
    // var tracks = TrackFactory.buildTracks(5);
    // final subtracks = SubtrackFactory.buildSubtracks(5);
    // final normalizedSubtracks = normalizeSubtracks(subtracks);
    // tracks =
    //     tracks.map((e) => e.copyWith(subtracks: normalizedSubtracks)).toList();
    // final normalizedTracks = normalizeTracks(tracks);
    // tracksets =
    //     tracksets.map((e) => e.copyWith(tracks: normalizedTracks)).toList();
    // return tracksets;
    return realWorldTracksets;
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
              TracksetListHeader(
                isLoading: isLoading,
                selectionModeEnabled: _selectionModeEnabled,
                disableSelectionMode: _disableSelectionMode,
                onAddTapped: () => _openTracksetCreateDialog(context),
                onDeleteSelectedTapped: () {},
                selectedCount: _selectedTracksetIds.length,
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
                    onToggle: (isExpanded) => onToggle(
                      index: index,
                      isExpanded: isExpanded,
                    ),
                    onHeaderLongPressed: _enableSelectionMode,
                    isSelected: _selectedTracksetIds.contains(trackset.id),
                    selectionModeEnabled: _selectionModeEnabled,
                    toggleSelection: _toggleSelection,
                  )))
              .values
              .toList(),
          divider: const HorizontalDivider(),
        );
      },
    );
  }
}
