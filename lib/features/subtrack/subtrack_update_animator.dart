import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prtmobile/features/subtrack/subtrack.dart';

class SubtrackUpdateAnimator extends StatefulWidget {
  const SubtrackUpdateAnimator({
    Key? key,
    required this.childBuilder,
  }) : super(key: key);

  final Widget Function(String) childBuilder;

  @override
  _SubtrackUpdateAnimatorState createState() => _SubtrackUpdateAnimatorState();
}

class _SubtrackUpdateAnimatorState extends State<SubtrackUpdateAnimator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ActiveSubtrackCubit, SubtrackSelection>(
      listener: (context, state) async {
        if (state.prev != null && state.next == null) {
          await _animationController.reverse();
          return;
        }
        if (state.prev == null && state.next != null) {
          await _animationController.forward();
          return;
        }
      },
      builder: (context, state) {
        final id = state.next ?? state.prev;
        return SizeTransition(
          sizeFactor: CurvedAnimation(
            parent: _animationController,
            curve: Curves.linear,
          ),
          child: state.prev == null && state.next == null
              ? Container()
              : widget.childBuilder(id!),
        );
      },
    );
  }
}
