import 'package:flutter/material.dart';
import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/models/models.dart';
import 'package:prtmobile/styles/styles.dart';

class SubtrackView extends StatelessWidget {
  const SubtrackView({
    Key? key,
    required this.subtrack,
  }) : super(key: key);

  final Subtrack subtrack;

  Widget _buildControlPanel(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InlineButton(text: 'Delete', onTap: () {}),
        const SizedBox(width: kHorizontalPadding),
        InlineButton(text: 'Edit', onTap: () {}),
      ],
    );
  }

  Widget _buildRange(BuildContext context) {
    final textStyle = AppTypography.h2;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          subtrack.start.toString(),
          style: textStyle,
        ),
        Text(
          subtrack.pointer.toString(),
          style: textStyle,
        ),
        Text(
          subtrack.end.toString(),
          style: textStyle,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final scaleFactor = MediaQuery.of(context).textScaleFactor;
    final rangeTextHeight = calcTextSize(
      fontSize: FontSizes.h2,
      scaleFactor: scaleFactor,
    );
    final formTextHeight = calcTextSize(
      fontSize: FontSizes.body,
      scaleFactor: scaleFactor,
    );
    const verticalPadding = kHorizontalPadding / 4;
    final totalHeight =
        rangeTextHeight + formTextHeight + (verticalPadding * 8);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kHorizontalPadding,
      ),
      child: SizedBox(
        height: totalHeight,
        child: Stack(
          children: [
            Positioned(
              top: verticalPadding,
              child: _buildControlPanel(context),
            ),
            Positioned.fill(
              child: _buildRange(context),
            ),
            const Positioned(
              bottom: verticalPadding,
              child: Text('Start must have a value.'),
            ),
          ],
        ),
      ),
    );
  }
}
