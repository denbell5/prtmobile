import 'package:flutter/widgets.dart';
import 'package:prtmobile/utils/utils.dart';

class TouchableOpacity extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool touchAnimated;

  const TouchableOpacity({
    Key? key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.touchAnimated = true,
  }) : super(key: key);

  @override
  _TouchableOpacityState createState() => _TouchableOpacityState();
}

class _TouchableOpacityState extends State<TouchableOpacity>
    with SingleTickerProviderStateMixin {
  late ButtonAnimation animation;
  final _longPressDetectionDebouncer = Debouncer(ms: 600);
  bool _isLongPress = false;

  bool get touchAnimated => widget.touchAnimated;

  @override
  void initState() {
    super.initState();
    animation = ButtonAnimation(target: this);
  }

  @override
  void didUpdateWidget(TouchableOpacity old) {
    super.didUpdateWidget(old);
    animation.setTween();
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails event) {
    _isLongPress = false;
    if (touchAnimated) {
      animation.handleTapDown(event);
    }
    _longPressDetectionDebouncer.run(_onLongPress);
  }

  void _onTapUp(TapUpDetails event) {
    if (touchAnimated) {
      animation.handleTapUp(event);
    }
    _longPressDetectionDebouncer.cancel();
  }

  void _onTapCancel() {
    if (touchAnimated) {
      animation.handleTapCancel();
    }
    _longPressDetectionDebouncer.cancel();
  }

  void _onLongPress() {
    if (widget.onLongPress != null) {
      _isLongPress = true;
      widget.onLongPress!();
      animation.handleTapUp();
    }
  }

  void _onTap() {
    if (!_isLongPress) {
      widget.onTap?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isTappable = widget.onTap != null;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: isTappable ? _onTap : null,
      onTapDown: isTappable ? _onTapDown : null,
      onTapUp: isTappable ? _onTapUp : null,
      onTapCancel: isTappable ? _onTapCancel : null,
      child: FadeTransition(
        opacity: animation.opacityAnimation,
        child: widget.child,
      ),
    );
  }
}

class ButtonAnimation<T extends TickerProvider> {
  final T target;

  static const Duration kFadeOutDuration = Duration(milliseconds: 10);
  static const Duration kFadeInDuration = Duration(milliseconds: 100);
  static const double kPressedOpacity = 0.4;
  final Tween<double> _opacityTween = Tween<double>(begin: 1.0);

  bool _buttonHeldDown = false;

  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  ButtonAnimation({
    required this.target,
  }) {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      value: 0.0,
      vsync: target,
    );
    _opacityAnimation = _controller
        .drive(CurveTween(curve: Curves.decelerate))
        .drive(_opacityTween);
    setTween();
  }

  AnimationController get controller => _controller;

  Animation<double> get opacityAnimation => _opacityAnimation;

  void setTween() {
    _opacityTween.end = kPressedOpacity;
  }

  void handleTapDown(TapDownDetails event) {
    if (!_buttonHeldDown) {
      _buttonHeldDown = true;
      _animate();
    }
  }

  void handleTapUp([TapUpDetails? event]) {
    if (_buttonHeldDown) {
      _buttonHeldDown = false;
      _animate();
    }
  }

  void handleTapCancel() {
    if (_buttonHeldDown) {
      _buttonHeldDown = false;
      _animate();
    }
  }

  void _animate() {
    if (_controller.isAnimating) {
      return;
    }
    final wasHeldDown = _buttonHeldDown;
    final ticker = _buttonHeldDown
        ? _controller.animateTo(1.0, duration: kFadeOutDuration)
        : _controller.animateTo(0.0, duration: kFadeInDuration);
    ticker.then<void>((void value) {
      if ((target as State<dynamic>).mounted &&
          wasHeldDown != _buttonHeldDown) {
        _animate();
      }
    });
  }

  void dispose() {
    _controller.dispose();
  }
}
