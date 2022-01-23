import 'package:flutter/widgets.dart';

class TouchableOpacity extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;

  const TouchableOpacity({
    Key? key,
    required this.child,
    this.onTap,
  }) : super(key: key);

  @override
  _TouchableOpacityState createState() => _TouchableOpacityState();
}

class _TouchableOpacityState extends State<TouchableOpacity>
    with SingleTickerProviderStateMixin {
  late ButtonAnimation animation;

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

  @override
  Widget build(BuildContext context) {
    final isTappable = widget.onTap != null;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: widget.onTap,
      onTapDown: isTappable ? animation.handleTapDown : null,
      onTapUp: isTappable ? animation.handleTapUp : null,
      onTapCancel: isTappable ? animation.handleTapCancel : null,
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

  void handleTapUp(TapUpDetails event) {
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
