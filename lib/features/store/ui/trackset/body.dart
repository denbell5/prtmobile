import 'package:flutter/cupertino.dart';
import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/features/store/store.dart';
import 'package:prtmobile/styles/styles.dart';

class TracksetSoBody extends StatefulWidget {
  const TracksetSoBody({
    Key? key,
    required this.trackset,
  }) : super(key: key);

  final TracksetSo trackset;

  @override
  State<TracksetSoBody> createState() => _TracksetSoBodyState();
}

class _TracksetSoBodyState extends State<TracksetSoBody> {
  final trackListKey = GlobalKey<ExpandableListStateV2>();

  TracksetSo get trackset => widget.trackset;

  Widget _buildTracksetStats(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: kDefaultPadding,
        right: kDefaultPadding,
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(CupertinoIcons.graph_square),
                  RichText(
                    text: TextSpan(
                      style: CupertinoTheme.of(context).textTheme.textStyle,
                      children: <TextSpan>[
                        TextSpan(
                          text: ' ${trackset.length} ',
                          style: StatStyles.kAccentTextStyle,
                        ),
                        TextSpan(
                          text: 'points in total',
                          style: StatStyles.kSecondaryTextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _buildTrackList(BuildContext context) {
    final trackViews =
        trackset.tracks.map((tr) => TrackSoView(track: tr)).toList();
    return trackViews;
  }

  @override
  Widget build(BuildContext context) {
    final trackViews = _buildTrackList(context);
    return ExpandableListV2(
      key: trackListKey,
      animationData: kExpandAnimationData,
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              const Height(kDefaultPadding * 1),
              _buildTracksetStats(context),
              const Height(kDefaultPadding * 1.5),
              ListHeader(
                leading: Text(
                  'Track List',
                  style: ListHeader.kSmallerTextStyle.bolder(),
                ),
              ),
            ],
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            trackViews,
          ),
        ),
      ],
    );
  }
}
