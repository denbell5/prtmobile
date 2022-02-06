import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/components/text/highlighted.dart';
import 'package:prtmobile/features/subtrack/subtrack.dart';
import 'package:prtmobile/models/models.dart';
import 'package:prtmobile/styles/styles.dart';

import 'edit/track_edit.dart';

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
  Track get track => widget.track;

  Future<void> _openTrackEditDialog(BuildContext context) async {
    await showCupertinoModalPopup(
      context: context,
      useRootNavigator: true,
      builder: (context) {
        return TrackEditDialog(
          track: track,
        );
      },
    );
  }

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
          InlineButton(
            text: 'Edit',
            onTap: () => _openTrackEditDialog(context),
          ),
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
            children: [
              Highlighted(
                child: Text(
                  '${track.subtracks.all.length} subtracks',
                ),
              ),
              const SizedBox(height: kDefaultPadding / 2),
              Highlighted(
                child: Text(
                  '${track.done}/${track.length} points done, ${track.left} left',
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
      leading: Text('Subtrack List', style: ListHeader.defaultTextStyle),
      trailing: InlineButton(
        text: 'Add',
        onTap: () {},
      ),
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
    return BlocListener<SelectedSubtrackCubit, SelectedSubtrackInfo>(
      listener: (ctx, selectedInfo) async {
        if (selectedInfo.id == null) {
          return;
        }
        await showCupertinoModalPopup(
          context: context,
          builder: (context) {
            return SubtrackUpdateDialog(
              subtrack: widget.track.subtracks.byId[selectedInfo.id]!,
            );
          },
        );
        BlocProvider.of<SelectedSubtrackCubit>(context).emitChange(null);
      },
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
    );
  }
}
