import 'package:flutter/material.dart';
import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/components/text/text.dart';
import 'package:prtmobile/models/models.dart';
import 'package:prtmobile/styles/layout.dart';

class TracksetBody extends StatelessWidget {
  const TracksetBody({
    Key? key,
    required this.trackset,
  }) : super(key: key);

  final Trackset trackset;

  Widget _buildTracksetControls(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: kHorizontalPadding,
        right: kHorizontalPadding,
        top: kHorizontalPadding / 4,
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
              Text('34 days of the trackset are behind,'),
              Text('67 days left.'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrackListHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: kHorizontalPadding,
        right: kHorizontalPadding,
        top: kHorizontalPadding,
      ),
      child: ListHeader(
        text: 'Tracks',
        onAddTap: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ExpandableList(
      listHeader: Column(
        children: [
          _buildTracksetControls(context),
          _buildTracksetStats(context),
          _buildTrackListHeader(context),
        ],
      ),
      expandables: const [],
      expandableHeaderExtent: 0,
    );
  }
}
