import 'package:flutter/cupertino.dart';
import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/features/store/store.dart';
import 'package:prtmobile/styles/styles.dart';

class TracksetSoView extends StatelessWidget {
  const TracksetSoView({
    Key? key,
    required this.trackset,
  }) : super(key: key);

  final TracksetSo trackset;

  Widget _buildHeader(BuildContext context) {
    return ListItemHeader(
      labelText: 'Trackset',
      primaryText: trackset.name,
      secondaryText: Text(
        'Recommended length: ${trackset.recommendedDays} days',
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
      body: TracksetSoBody(trackset: trackset),
    );
  }
}
