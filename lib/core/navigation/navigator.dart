import 'package:flutter/widgets.dart';

typedef AppRouteBuilder = Widget Function(
  BuildContext context,
  Object argument,
);

class AppNavigator extends InheritedWidget {
  final NavigatorState navigator;

  const AppNavigator({
    Key? key,
    required Widget child,
    required this.navigator,
  }) : super(
          key: key,
          child: child,
        );

  static NavigatorState of(
    BuildContext context, {
    bool rootNavigator = false,
  }) {
    NavigatorState? navigator;
    if (rootNavigator) {
      navigator =
          context.dependOnInheritedWidgetOfExactType<AppNavigator>()?.navigator;
    } else {
      navigator = Navigator.of(
        context,
        rootNavigator: false,
      );
    }

    assert(() {
      if (navigator == null) {
        throw FlutterError(
          'Can\'t find navigator (rootNavigator $rootNavigator)',
        );
      }
      return true;
    }());

    return navigator!;
  }

  @override
  bool updateShouldNotify(AppNavigator oldWidget) {
    return true;
  }
}
