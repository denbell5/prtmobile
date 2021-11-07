import 'package:flutter/material.dart';
import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/components/text/highlighted.dart';
import 'package:prtmobile/features/subtrack/subtrack_update_form.dart';
import 'package:prtmobile/features/subtrack/subtrack_view.dart';
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
              Highlighted(
                child: Text(
                  '6 subtracks',
                ),
              ),
              SizedBox(height: kHorizontalPadding / 2),
              Highlighted(
                child: Text(
                  '258/345 points done, 134 left',
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
      text: 'Subtrack List',
      onAddTap: () {},
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
    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _buildTrackControls(context),
              ),
              SliverToBoxAdapter(
                child: _buildTrackStats(context),
              ),
              const SliverPadding(
                padding: EdgeInsets.only(top: kHorizontalPadding),
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
          ),
        ),
        if (track.subtracks.all.isNotEmpty)
          SubtrackUpdateForm(subtrack: track.subtracks.entities.first)
      ],
    );
  }
}
