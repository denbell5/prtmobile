import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prtmobile/bloc/tracking/tracking.bloc.dart';
import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/components/text/list_item_header.dart';

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

  @override
  void initState() {
    super.initState();
    _requestTracksets();
  }

  void _requestTracksets() {
    final bloc = TrackingBloc.of(context);
    bloc.add(TracksetsRequested());
  }

  Iterable<Widget> _buildTracksetListHeader({
    bool isLoading = false,
  }) {
    return [
      Padding(
        padding: const EdgeInsets.only(
          top: kDefaultPadding,
        ),
        child: ListHeader(
          text: 'Trackset List',
          isLoading: isLoading,
          onAddTap: () {},
        ),
      ),
    ];
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
              ..._buildTracksetListHeader(isLoading: isLoading),
              if (errorMessage != null) errorMessage,
            ],
          ),
          expandableHeaderExtent: kListItemHeaderHeight,
          animationData: kExpandAnimationData,
          itemCount: tracksets.all.length,
          itemBuilder: (index) => TracksetView(
            trackset: tracksets.entities[index],
            onToggle: (isExpanded) => onToggle(
              index: index,
              isExpanded: isExpanded,
            ),
          ),
          divider: const HorizontalDivider(),
        );
      },
    );
  }
}
