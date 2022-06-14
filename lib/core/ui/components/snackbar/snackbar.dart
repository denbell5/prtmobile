import 'package:flutter/cupertino.dart';
import 'package:prtmobile/core/core.dart';

class AppSnackbar extends StatefulWidget {
  const AppSnackbar({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  AppSnackbarState createState() => AppSnackbarState();

  static AppSnackbarState? of(BuildContext context) {
    return context.findAncestorStateOfType<AppSnackbarState>();
  }
}

class AppSnackbarState extends State<AppSnackbar>
    with SingleTickerProviderStateMixin {
  late final _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 100),
  );

  late Animation<Offset> _animation;

  final _closeDebouncer = Debouncer(ms: 2000);

  @override
  void initState() {
    super.initState();
    _animation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: const Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );
  }

  String? _text;

  Future<void> show({
    required String text,
  }) async {
    setState(() {
      _text = text;
    });
    await _animationController.forward();
    _closeDebouncer.run(close);
  }

  Future<void> close() async {
    await _animationController.reverse();
    setState(() {
      _text = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: widget.child),
        if (_text != null)
          Positioned.fill(
            top: null,
            child: SlideTransition(
              position: _animation,
              child: Container(
                color: AppColors.mineShaft,
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                  vertical: kDefaultPadding / 2,
                ),
                child: Text(
                  _text!,
                  style: TextStyle(
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
