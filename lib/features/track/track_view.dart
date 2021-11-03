import 'package:flutter/material.dart';
import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/models/models.dart';
import 'package:prtmobile/styles/colors.dart';
import 'package:prtmobile/styles/layout.dart';
import 'package:prtmobile/styles/styles.dart';

import 'track_body.dart';

const kTrackHeaderHeight = 60.0;

class TrackView extends StatelessWidget {
  const TrackView({
    Key? key,
    required this.track,
    required this.onToggle,
  }) : super(key: key);

  final Track track;
  final void Function(bool) onToggle;

  Widget _buildHeader(BuildContext context) {
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
          height: kTrackHeaderHeight,
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(track.name, style: AppTypography.h4),
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
      body: TrackBody(track: track),
    );
  }
}
