import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prtmobile/components/components.dart';
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
      padding: EdgeInsets.only(
        left: kDefaultPadding - IconTextButton.kEdgeInsets.left,
        right: kDefaultPadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconTextButton(
            text: 'Edit',
            icon: CupertinoIcons.pen,
            onTap: () {
              _openTrackEditDialog(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTrackStats(BuildContext context) {
    const divider = SizedBox(height: kDefaultPadding * 0.5);
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
              Row(
                children: [
                  const Icon(CupertinoIcons.collections),
                  RichText(
                    text: TextSpan(
                      style: CupertinoTheme.of(context).textTheme.textStyle,
                      children: <TextSpan>[
                        TextSpan(
                          text: ' ${track.subtracks.all.length} ',
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
                          text: ' ${track.left} ',
                          style: StatStyles.kAccentTextStyle,
                        ),
                        TextSpan(
                          text: 'points to do,',
                          style: StatStyles.kSecondaryTextStyle,
                        ),
                        TextSpan(
                          text: ' ${track.done} ',
                          style: StatStyles.kAccentTextStyle,
                        ),
                        TextSpan(
                          text: 'out of',
                          style: StatStyles.kSecondaryTextStyle,
                        ),
                        TextSpan(
                          text: ' ${track.length} ',
                          style: StatStyles.kAccentTextStyle,
                        ),
                        TextSpan(
                          text: 'done',
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
      trailing: IconTextButton(
        text: 'Add',
        icon: CupertinoIcons.add,
        onTap: () {},
      ),
    );
  }

  List<Widget> _buildSubtrackList(BuildContext context) {
    final subtracks = widget.track.subtracks.entities;
    return buildList(
      isDivided: false,
      itemCount: subtracks.length,
      itemBuilder: (index) => SubtrackView(subtrack: subtracks[index]),
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
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _buildTrackControls(context),
                const SizedBox(height: kDefaultPadding * 1.5),
                _buildTrackStats(context),
                const SizedBox(height: kDefaultPadding),
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
      ),
    );
  }
}
