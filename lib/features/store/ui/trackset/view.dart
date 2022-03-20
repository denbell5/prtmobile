import 'package:flutter/cupertino.dart';
import 'package:prtmobile/core/core.dart';
import 'package:prtmobile/features/store/store.dart';

class TracksetSoView extends StatelessWidget {
  const TracksetSoView({
    Key? key,
    required this.trackset,
  }) : super(key: key);

  final TracksetSo trackset;

  void _openAddTracksetDialog(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      useRootNavigator: false,
      builder: (context) {
        return AddTracksetSoDialog(
          trackset: trackset,
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return ListItemHeader(
      labelText: 'Trackset',
      primaryText: trackset.name,
      secondaryText: Text(
        'Recommended length: ${trackset.recommendedDays} days',
      ),
      trailing: IconTextButton(
        text: 'Add',
        icon: CupertinoIcons.add,
        onTap: () {
          _openAddTracksetDialog(context);
        },
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
