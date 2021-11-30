import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/components/text/list_item_header.dart';
import 'package:prtmobile/features/subtrack/subtrack.dart';
import 'package:prtmobile/models/models.dart';
import 'package:prtmobile/styles/styles.dart';

import 'track_body.dart';

class TrackView extends StatelessWidget {
  const TrackView({
    Key? key,
    required this.track,
    required this.onToggle,
  }) : super(key: key);

  final Track track;
  final void Function(bool) onToggle;

  Widget _buildHeader(BuildContext context) {
    return ListItemHeader(
      primaryText: track.name,
      secondaryText: '${track.done}/${track.length} points',
      onTap: () {
        ExpandableState.of(context)!.toggle();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expandable(
      onToggle: onToggle,
      animationData: kExpandAnimationData,
      header: Builder(builder: (context) {
        return _buildHeader(context);
      }),
      body: BlocProvider<ActiveSubtrackCubit>(
        create: (ctx) => ActiveSubtrackCubit(),
        child: TrackBody(track: track),
      ),
    );
  }
}
