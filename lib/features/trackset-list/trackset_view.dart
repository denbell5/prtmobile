import 'package:flutter/material.dart';
import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/models/models.dart';
import 'package:prtmobile/styles/colors.dart';
import 'package:prtmobile/styles/layout.dart';
import 'package:prtmobile/styles/styles.dart';

final kTracksetExpandAnimationData = AnimationData(
  curve: Curves.decelerate,
  duration: const Duration(milliseconds: 300),
);

class TracksetView extends StatelessWidget {
  const TracksetView({
    Key? key,
    required this.trackset,
    required this.onToggle,
  }) : super(key: key);

  final Trackset trackset;
  final void Function(bool) onToggle;

  Widget _buildHeader(BuildContext context) {
    return TouchableColor(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kHorizontalPadding,
        ),
        child: SizedBox(
          height: 50,
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(trackset.name, style: AppTypography.h3),
                  Text(trackset.startAt.toString()),
                ],
              ),
            ],
          ),
        ),
      ),
      onPressed: () {
        ExpandableState.of(context)!.toggle();
      },
      color: AppColors.white,
      touchColor: AppColors.lightGrey,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expandable(
      onToggle: onToggle,
      header: Builder(builder: (context) {
        return _buildHeader(context);
      }),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.amber,
        ),
      ),
      animationData: kTracksetExpandAnimationData,
    );
  }
}
