import 'package:flutter/material.dart';
import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/components/text/text.dart';
import 'package:prtmobile/features/trackset-list/trackset_view.dart';
import 'package:prtmobile/models/models.dart';
import 'package:prtmobile/styles/styles.dart';
import 'package:prtmobile/utils/utils.dart';

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
          left: kHorizontalPadding,
          right: kHorizontalPadding,
          top: kHorizontalPadding,
        ),
        child: ListHeader(
          text: 'Tracksets',
          onAddTap: () {},
        ),
      ),
    ];
  }

  List<Trackset> getTracksets() {
    var tracksets = TracksetFactory.buildTracksets(5);
    final tracks = TrackFactory.buildTracks(5);
    final normalizedTracks = normalizeTracks(tracks);
    tracksets =
        tracksets.map((e) => e.copyWith(tracks: normalizedTracks)).toList();
    return tracksets;
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
    final tracksetViews = tracksets
        .asMap()
        .map(
          (index, tr) => MapEntry(
            index,
            TracksetView(
              trackset: tr,
              onToggle: (isExpanded) => onToggle(
                index: index,
                isExpanded: isExpanded,
              ),
            ),
          ),
        )
        .values
        .toList();
    return ExpandableList(
      key: listKey,
      listHeader: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ..._buildTracksetListHeader(),
        ],
      ),
      expandables: tracksetViews,
      expandableHeaderExtent: kTracksetHeaderHeight,
      separator: const HorizontalDivider(),
      animationData: kExpandAnimationData,
    );
  }
}
