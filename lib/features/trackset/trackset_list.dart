import 'package:flutter/material.dart';
import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/components/text/list_item_header.dart';
import 'package:prtmobile/components/text/text.dart';

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

  Iterable<Widget> _buildTracksetListHeader() {
    return [
      Padding(
        padding: const EdgeInsets.only(
          top: kDefaultPadding,
        ),
        child: ListHeader(
          text: 'Trackset List',
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

  @override
  Widget build(BuildContext context) {
    final tracksets = getTracksets();
    return ExpandableList(
      key: listKey,
      listHeader: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ..._buildTracksetListHeader(),
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
  }
}
