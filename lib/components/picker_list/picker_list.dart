import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prtmobile/styles/styles.dart';

class PickerList extends StatelessWidget {
  const PickerList({
    Key? key,
    required this.itemBuilder,
    required this.itemExtent,
    this.onSelected,
    this.initialIndex = 1,
  }) : super(key: key);

  final int initialIndex;
  final double itemExtent;
  final ValueChanged<int>? onSelected;
  final NullableIndexedWidgetBuilder itemBuilder;

  Widget _buildOpacity({
    required double height,
    required double width,
    required Color color,
    required bool isTop,
  }) {
    final begin = isTop ? Alignment.topCenter : Alignment.bottomCenter;
    final end = !isTop ? Alignment.topCenter : Alignment.bottomCenter;
    return Positioned(
      top: isTop ? 0 : null,
      bottom: !isTop ? 0 : null,
      child: IgnorePointer(
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: AppColors.white,
            gradient: LinearGradient(
              colors: [
                AppColors.white,
                AppColors.white.withOpacity(0.0),
              ],
              begin: begin,
              end: end,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final opacityColor = Theme.of(context).colorScheme.background;
    return LayoutBuilder(builder: (ctx, constraints) {
      final opacityHeight = (constraints.maxHeight - itemExtent) / 2;
      return Stack(
        children: [
          Positioned.fill(
            child: ListWheelScrollView.useDelegate(
              perspective: 0.00001,
              physics: const FixedExtentScrollPhysics(),
              controller: FixedExtentScrollController(initialItem: 1),
              itemExtent: itemExtent,
              childDelegate: ListWheelChildBuilderDelegate(
                builder: itemBuilder,
              ),
              onSelectedItemChanged: onSelected,
            ),
          ),
          _buildOpacity(
            height: opacityHeight,
            width: constraints.maxWidth,
            color: opacityColor,
            isTop: true,
          ),
          _buildOpacity(
            height: opacityHeight,
            width: constraints.maxWidth,
            color: opacityColor,
            isTop: false,
          ),
        ],
      );
    });
  }
}
