import 'package:flutter/cupertino.dart';
import 'package:prtmobile/core/core.dart';
import 'package:prtmobile/features/store/store.dart';

class TrackSoBody extends StatefulWidget {
  const TrackSoBody({
    Key? key,
    required this.track,
  }) : super(key: key);

  final TrackSo track;

  @override
  State<TrackSoBody> createState() => _TrackSoBodyState();
}

class _TrackSoBodyState extends State<TrackSoBody> with ListBuilder {
  TrackSo get track => widget.track;

  Widget _buildTrackStats(BuildContext context) {
    const divider = Height(kDefaultPadding * 0.5);
    return Padding(
      padding: const EdgeInsets.only(
        left: kDefaultPadding,
        right: kDefaultPadding,
        bottom: kDefaultPadding,
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(CupertinoIcons.collections),
                  RichText(
                    text: TextSpan(
                      style: CupertinoTheme.of(context).textTheme.textStyle,
                      children: <TextSpan>[
                        TextSpan(
                          text: ' ${track.subtracks.length} ',
                          style: StatStyles.kAccentTextStyle,
                        ),
                        TextSpan(
                          text: 'subtracks',
                          style: StatStyles.kSecondaryTextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              divider,
              Row(
                children: [
                  const Icon(CupertinoIcons.graph_square),
                  RichText(
                    text: TextSpan(
                      style: CupertinoTheme.of(context).textTheme.textStyle,
                      children: <TextSpan>[
                        TextSpan(
                          text: ' ${track.length} ',
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

  Widget _buildSubtrackListHeader(BuildContext context) {
    return ListHeader(
      leading: Text(
        'Subtrack List',
        style: ListHeader.kSmallerTextStyle.bolder(),
      ),
    );
  }

  List<Widget> _buildSubtrackList(BuildContext context) {
    final subtracks = widget.track.subtracks;
    return buildList(
      isDivided: false,
      itemCount: subtracks.length,
      itemBuilder: (index) => SubtrackSoView(
        subtrack: subtracks[index],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              const Height(kDefaultPadding * 1.5),
              _buildTrackStats(context),
              const Height(kDefaultPadding),
              _buildSubtrackListHeader(context),
            ],
          ),
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
