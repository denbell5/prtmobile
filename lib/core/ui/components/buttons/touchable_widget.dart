import 'package:flutter/widgets.dart';
import 'package:prtmobile/core/core.dart';

class TouchableWidget extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final ValueChanged<TapUpDetails>? onTapDetailed;

  const TouchableWidget({
    Key? key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.onTapDetailed,
  }) : super(key: key);

  @override
  _TouchableWidgetState createState() => _TouchableWidgetState();
}

class _TouchableWidgetState extends State<TouchableWidget>
    with SingleTickerProviderStateMixin {
  final _longPressDetectionDebouncer = Debouncer(ms: 300);
  bool _isLongPress = false;
  TapUpDetails? _tapUpDetails;

  void _onTapDown(TapDownDetails event) {
    _isLongPress = false;
    _tapUpDetails = null;
    _longPressDetectionDebouncer.run(_onLongPress);
  }

  void _onTapUp(TapUpDetails event) {
    _longPressDetectionDebouncer.cancel();
    _tapUpDetails = event;
  }

  void _onTapCancel() {
    _longPressDetectionDebouncer.cancel();
  }

  void _onLongPress() {
    if (widget.onLongPress != null) {
      _isLongPress = true;
      widget.onLongPress!();
    }
  }

  void _onTap() {
    if (!_isLongPress) {
      widget.onTapDetailed?.call(_tapUpDetails!);
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
      child: widget.child,
    );
  }
}
