import 'package:flutter/cupertino.dart';
import 'package:prtmobile/styles/styles.dart';

class PickerList extends StatefulWidget {
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

  @override
  State<PickerList> createState() => _PickerListState();
}

class _PickerListState extends State<PickerList> {
  late FixedExtentScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = FixedExtentScrollController(
      initialItem: widget.initialIndex,
    );
  }

  @override
  void didUpdateWidget(PickerList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialIndex != oldWidget.initialIndex) {
      scrollController.jumpToItem(widget.initialIndex);
    }
  }

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
    final opacityColor = CupertinoTheme.of(context).scaffoldBackgroundColor;
    return LayoutBuilder(builder: (ctx, constraints) {
      final opacityHeight = (constraints.maxHeight - widget.itemExtent) / 2;
      return Stack(
        children: [
          Positioned.fill(
            child: ListWheelScrollView.useDelegate(
              perspective: 0.00001,
              physics: const FixedExtentScrollPhysics(),
              controller: scrollController,
              itemExtent: widget.itemExtent,
              childDelegate: ListWheelChildBuilderDelegate(
                builder: widget.itemBuilder,
              ),
              onSelectedItemChanged: widget.onSelected,
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
