import 'package:flutter/material.dart';
import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/components/text/highlighted.dart';
import 'package:prtmobile/components/text/text.dart';
import 'package:prtmobile/features/track/track_view.dart';
import 'package:prtmobile/models/models.dart';
import 'package:prtmobile/styles/layout.dart';
import 'package:prtmobile/styles/styles.dart';

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

  void onToggle({
    required int index,
    required bool isExpanded,
  }) {
    trackListKey.currentState!.onToggle(
      index: index,
      isExpanded: isExpanded,
    );
  }

  Widget _buildTracksetControls(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: kHorizontalPadding,
        right: kHorizontalPadding,
        bottom: kHorizontalPadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InlineButton(text: 'Delete', onTap: () {}),
          const SizedBox(width: kHorizontalPadding),
          InlineButton(text: 'Edit', onTap: () {}),
        ],
      ),
    );
  }

  Widget _buildTracksetStats(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: kHorizontalPadding,
        right: kHorizontalPadding,
        top: kHorizontalPadding / 4,
        bottom: kHorizontalPadding,
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Highlighted(
                child: Text(
                  '34 days passed, 67 days  left',
                ),
              ),
              SizedBox(height: kHorizontalPadding / 2),
              Highlighted(
                child: Text(
                  '356/1678 points done',
                ),
              ),
              SizedBox(height: kHorizontalPadding / 2),
              Highlighted(
                child: Text(
                  '48 points to complete daily',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrackListHeader(BuildContext context) {
    return ListHeader(
      text: 'Track List',
      onAddTap: () {},
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
              track: tr,
              onToggle: (isExpanded) {
                onToggle(
                  index: index,
                  isExpanded: isExpanded,
                );
              },
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
          _buildTracksetStats(context),
          const SizedBox(height: kHorizontalPadding),
          _buildTrackListHeader(context),
        ],
      ),
      expandables: _buildTrackList(context),
      expandableHeaderExtent: kTrackHeaderHeight,
      animationData: kExpandAnimationData,
      itemCount: trackViews.length,
      itemBuilder: (index) => trackViews[index],
      divider: const HorizontalDivider(),
    );
  }
}
