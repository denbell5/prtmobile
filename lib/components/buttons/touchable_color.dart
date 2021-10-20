import 'package:flutter/widgets.dart';

class TouchableColor extends StatefulWidget {
  const TouchableColor({
    Key? key,
    required this.child,
    required this.onPressed,
    required this.color,
    required this.touchColor,
  }) : super(key: key);

  final Widget child;
  final VoidCallback onPressed;
  final Color color;
  final Color touchColor;

  @override
  _TouchableColorState createState() => _TouchableColorState();
}

class _TouchableColorState extends State<TouchableColor> {
  var isTouched = false;
  Color get activeColor => isTouched ? widget.touchColor : widget.color;

  void setIsTouched(bool value) {
    setState(() {
      isTouched = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        setIsTouched(true);
      },
      onTapCancel: () {
        setIsTouched(false);
      },
      onTapUp: (details) {
        setIsTouched(false);
      },
      child: AnimatedContainer(
        curve: Curves.decelerate,
        duration: const Duration(milliseconds: 200),
        color: activeColor,
        child: widget.child,
      ),
    );
  }
}
