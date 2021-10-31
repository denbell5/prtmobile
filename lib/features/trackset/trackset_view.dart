import 'package:flutter/material.dart';
import 'package:prtmobile/components/components.dart';

import 'package:prtmobile/models/models.dart';
import 'package:prtmobile/styles/colors.dart';
import 'package:prtmobile/styles/layout.dart';
import 'package:prtmobile/styles/styles.dart';
import 'package:prtmobile/utils/utils.dart';

import 'trackset_body.dart';

const kTracksetHeaderHeight = 60.0;

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

    return TouchableColor(
      color: AppColors.white,
      touchColor: AppColors.lightGrey,
      onTap: () {
        ExpandableState.of(context)!.toggle();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kHorizontalPadding,
        ),
        child: SizedBox(
          height: kTracksetHeaderHeight,
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(trackset.name, style: AppTypography.h4),
                  Text(dateRange, style: AppTypography.bodyText.greyed()),
                ],
              ),
            ],
          ),
        ),
      ),
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
