import 'package:flutter/cupertino.dart';
import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/components/text/highlighted.dart';
import 'package:prtmobile/components/text/list_item_header.dart';
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
      builder: (context) {
        return TracksetEditDialog(
          trackset: trackset,
        );
      },
    );
  }

  Widget _buildTracksetControls(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: kDefaultPadding,
        right: kDefaultPadding,
        bottom: kDefaultPadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          InlineButton(text: 'Delete', onTap: () {}),
          const SizedBox(width: kDefaultPadding),
          InlineButton(
            text: 'Edit',
            onTap: () {
              _openTracksetEditDialog(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTracksetStats(BuildContext context) {
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
              Highlighted(
                child: Text(
                  '${trackset.daysPassed()}/${trackset.totalDays} days passed, ${trackset.daysLeft()} days left',
                ),
              ),
              const SizedBox(height: kDefaultPadding / 2),
              Highlighted(
                child: Text(
                  '${trackset.done}/${trackset.length} points done, ${trackset.left} left',
                ),
              ),
              const SizedBox(height: kDefaultPadding / 2),
              Highlighted(
                child: Text(
                  '${trackset.dailyGoal} points to complete daily',
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
          const SizedBox(height: kDefaultPadding),
          _buildTrackListHeader(context),
        ],
      ),
      expandableHeaderExtent: kListItemHeaderHeight,
      animationData: kExpandAnimationData,
      itemCount: trackViews.length,
      itemBuilder: (index) => trackViews[index],
      divider: const HorizontalDivider(),
    );
  }
}
