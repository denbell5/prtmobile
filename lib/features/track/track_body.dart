import 'package:flutter/material.dart';
import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/components/text/text.dart';
import 'package:prtmobile/features/subtrack.dart/subtrack_view.dart';
import 'package:prtmobile/models/models.dart';
import 'package:prtmobile/styles/styles.dart';

class TrackBody extends StatelessWidget with ListBuilder {
  const TrackBody({
    Key? key,
    required this.track,
  }) : super(key: key);

  final Track track;

  Widget _buildTrackControls(BuildContext context) {
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

  Widget _buildTrackStats(BuildContext context) {
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
              Text('256 points in total,'),
              Text('13 complete,'),
              Text('243 left,'),
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
      ),
      child: ListHeader(
        text: 'Subtracks',
        onAddTap: () {},
      ),
    );
  }

  List<Widget> _buildSubtrackList(BuildContext context) {
    final subtracks = track.subtracks.entities;
    return buildList(
      isDivided: true,
      itemCount: subtracks.length,
      itemBuilder: (index) => SubtrackView(subtrack: subtracks[index]),
      dividerBuilder: () => const HorizontalDivider(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: _buildTrackControls(context),
        ),
        SliverToBoxAdapter(
          child: _buildTrackStats(context),
        ),
        SliverToBoxAdapter(
          child: _buildTrackListHeader(context),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            _buildSubtrackList(context),
          ),
        ),
      ],
    );
  }
}
