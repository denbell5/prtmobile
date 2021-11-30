import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/components/text/highlighted.dart';
import 'package:prtmobile/features/subtrack/subtrack.dart';
import 'package:prtmobile/models/models.dart';
import 'package:prtmobile/styles/styles.dart';

class TrackBody extends StatefulWidget {
  const TrackBody({
    Key? key,
    required this.track,
  }) : super(key: key);

  final Track track;

  @override
  State<TrackBody> createState() => _TrackBodyState();
}

class _TrackBodyState extends State<TrackBody> with ListBuilder {
  Widget _buildTrackControls(BuildContext context) {
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
          InlineButton(text: 'Edit', onTap: () {}),
        ],
      ),
    );
  }

  Widget _buildTrackStats(BuildContext context) {
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
            children: const [
              Highlighted(
                child: Text(
                  '6 subtracks',
                ),
              ),
              SizedBox(height: kDefaultPadding / 2),
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

  Widget _buildSubtrackListHeader(BuildContext context) {
    return ListHeader(
      text: 'Subtrack List',
      onAddTap: () {},
    );
  }

  List<Widget> _buildSubtrackList(BuildContext context) {
    final subtracks = widget.track.subtracks.entities;
    return buildList(
      isDivided: true,
      itemCount: subtracks.length,
      itemBuilder: (index) => SubtrackView(subtrack: subtracks[index]),
      dividerBuilder: () => const HorizontalDivider(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ActiveSubtrackCubit, SubtrackSelection>(
      listener: (ctx, selection) async {}, // TODO: ?
      child: Column(
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
                  padding: EdgeInsets.only(top: kDefaultPadding),
                ),
                SliverToBoxAdapter(
                  child: _buildSubtrackListHeader(context),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    _buildSubtrackList(context),
                  ),
                ),
              ],
            ),
          ),
          SubtrackUpdateAnimator(
            childBuilder: (id) {
              return SubtrackUpdate(
                subtrack: widget.track.subtracks.byId[id]!,
              );
            },
          )
        ],
      ),
    );
  }
}
