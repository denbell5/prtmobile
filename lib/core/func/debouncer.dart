import 'dart:async';

import 'package:flutter/foundation.dart';

class Debouncer {
  final int ms;
  VoidCallback? _action;
  Timer? _timer;

  Debouncer({
    required this.ms,
  });

  void run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _action = action;
    _timer = Timer(
      Duration(milliseconds: ms),
      () {
        _action = null;
        action();
      },
    );
  }

  bool get isTimerActive => _timer != null && _timer!.isActive;

  void cancel() {
    _timer?.cancel();
    _action = null;
  }

  void disposeAndSendLatest() {
    _timer?.cancel();
    _action?.call();
  }
}
