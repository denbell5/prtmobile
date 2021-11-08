import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prtmobile/components/components.dart';
import 'package:prtmobile/features/subtrack/subtrack.dart';
import 'package:prtmobile/models/models.dart';
import 'package:prtmobile/styles/styles.dart';

class SubtrackView extends StatefulWidget {
  const SubtrackView({
    Key? key,
    required this.subtrack,
  }) : super(key: key);

  final Subtrack subtrack;

  @override
  State<SubtrackView> createState() => _SubtrackViewState();
}

class _SubtrackViewState extends State<SubtrackView>
    with SingleTickerProviderStateMixin {
  late AnimationController _actionsAnimationController;
  var isSelected = false;

  Subtrack get subtrack => widget.subtrack;

  @override
  void initState() {
    super.initState();
    _actionsAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  void onSelectionToggled() {
    final cubit = BlocProvider.of<ActiveSubtrackCubit>(context);
    if (cubit.state.next == subtrack.id) {
      cubit.emitChange(null);
    } else {
      cubit.emitChange(subtrack.id);
    }
  }

  Widget _buildRange(BuildContext context) {
    final textStyle = AppTypography.h2;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.subtrack.start.toString(),
          style: textStyle,
        ),
        Text(
          widget.subtrack.pointer.toString(),
          style: textStyle,
        ),
        Text(
          widget.subtrack.end.toString(),
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

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onDoubleTap: onSelectionToggled,
      onTap: onSelectionToggled,
      child: BlocBuilder<ActiveSubtrackCubit, SubtrackSelection>(
        builder: (context, selection) {
          final isActive = widget.subtrack.id == selection.next;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            color: isActive
                ? Theme.of(context).colorScheme.surface
                : Theme.of(context).colorScheme.background,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kHorizontalPadding,
              ),
              child: SizedBox(
                height: totalHeight,
                child: Stack(
                  children: [
                    SubtrackViewActions(
                      animationView: _actionsAnimationController.view,
                      paddingOffset: verticalPadding,
                      actionsOffset: formTextHeight,
                      actions: [
                        InlineButton(text: 'Delete', onTap: () {}),
                        const SizedBox(width: kHorizontalPadding),
                        InlineButton(text: 'Cancel', onTap: () {}),
                        const SizedBox(width: kHorizontalPadding),
                        InlineButton(text: 'Save', onTap: () {}),
                      ],
                    ),
                    Positioned.fill(
                      child: _buildRange(context),
                    ),
                    // error message
                    const Positioned(
                      bottom: verticalPadding,
                      child: Text(''),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
