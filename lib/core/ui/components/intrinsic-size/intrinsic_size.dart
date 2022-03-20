import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

typedef OnWidgetSizeChange = void Function(Size size);

class IntrinsicSize extends SingleChildRenderObjectWidget {
  final OnWidgetSizeChange onChange;

  const IntrinsicSize({
    Key? key,
    required this.onChange,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return IntrinsicSizeRenderObject(onChange);
  }
}

class IntrinsicSizeRenderObject extends RenderProxyBox {
  final OnWidgetSizeChange onChange;

  IntrinsicSizeRenderObject(this.onChange);

  @override
  void performLayout() {
    super.performLayout();
    Size newSize = child!.size;
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      onChange(newSize);
    });
  }
}
