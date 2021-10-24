import 'package:flutter/material.dart';

class SubtrackViewActions extends StatelessWidget {
  SubtrackViewActions({
    Key? key,
    required this.actions,
    required this.animationView,
    required this.paddingOffset,
    required this.actionsOffset,
  })  : topOffsetAnimation = Tween<double>(
          begin: -actionsOffset,
          end: paddingOffset,
        ).animate(
          CurvedAnimation(
            parent: animationView,
            curve: const Interval(
              0.5,
              1.0,
              curve: Curves.easeOutBack,
            ),
          ),
        ),
        super(key: key);

  final List<Widget> actions;
  final Animation<double> animationView;
  final double paddingOffset;
  final double actionsOffset;
  final Animation<double> topOffsetAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationView,
      builder: (context, _) => Positioned(
        top: topOffsetAnimation.value,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: actions,
        ),
      ),
    );
  }
}
