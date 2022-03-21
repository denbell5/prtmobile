import 'package:flutter/widgets.dart';

typedef DividerBuilder = Widget Function();
typedef ListItemBuilder = Widget Function(int index);

mixin ListBuilder {
  List<Widget> buildList({
    required bool isDivided,
    DividerBuilder? firstDividerBuilder,
    DividerBuilder? dividerBuilder,
    required int itemCount,
    required ListItemBuilder itemBuilder,
  }) {
    final list = <Widget>[];
    if (itemCount == 0) return list;
    if (!isDivided) {
      for (var i = 0; i < itemCount; i++) {
        list.add(itemBuilder(i));
      }
      return list;
    }
    final divider = dividerBuilder!();
    list.add(firstDividerBuilder?.call() ?? divider);
    for (var i = 0; i < itemCount; i++) {
      list.add(itemBuilder(i));
      list.add(divider);
    }
    return list;
  }
}
