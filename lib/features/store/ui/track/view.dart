import 'package:flutter/widgets.dart';
import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/features/store/store.dart';
import 'package:prtmobile/styles/styles.dart';

const kTrackHeaderHeight = 60.0;

class TrackSoView extends StatelessWidget {
  const TrackSoView({
    Key? key,
    required this.track,
  }) : super(key: key);

  final TrackSo track;

  Widget _buildHeader(BuildContext context) {
    return ListItemHeader(
      labelText: 'Track',
      primaryText: track.name,
      primaryTextSize: FontSizes.h5,
      height: kTrackHeaderHeight,
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
