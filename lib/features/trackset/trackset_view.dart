import 'package:flutter/widgets.dart';
import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/components/text/list_item_header.dart';
import 'package:prtmobile/models/models.dart';
import 'package:prtmobile/styles/styles.dart';
import 'package:prtmobile/utils/utils.dart';

import 'trackset_body.dart';

class TracksetView extends StatelessWidget {
  const TracksetView({
    Key? key,
    required this.trackset,
    required this.onToggle,
  }) : super(key: key);

  final Trackset trackset;
  final void Function(bool) onToggle;

  Widget _buildHeader(BuildContext context) {
    final startDate = formatDate(trackset.startAt);
    final endDate = formatDate(trackset.endAt);
    final dateRange = '$startDate - $endDate';
    return ListItemHeader(
      primaryText: trackset.name,
      secondaryText: dateRange,
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
      body: TracksetBody(trackset: trackset),
    );
  }
}
