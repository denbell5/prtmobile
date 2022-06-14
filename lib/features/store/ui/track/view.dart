import 'package:flutter/widgets.dart';
import 'package:prtmobile/core/core.dart';
import 'package:prtmobile/features/store/store.dart';

class TrackSoView extends StatelessWidget {
  const TrackSoView({
    Key? key,
    required this.track,
  }) : super(key: key);

  final TrackSo track;

  Widget _buildHeader(BuildContext context) {
    return ListItemHeader(
      labelText: 'Track',
      primary: Text(
        track.name,
        style: AppTypography.h5,
        maxLines: 2,
      ),
      onTap: () {
        ExpandableState.of(context)!.toggle();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expandable(
      animationData: kExpandAnimationData,
      header: Builder(
        builder: (context) {
          return _buildHeader(context);
        },
      ),
      body: TrackSoBody(track: track),
    );
  }
}
