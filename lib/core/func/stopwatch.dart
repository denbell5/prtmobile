import 'dart:async';

Future<Duration> measure(FutureOr<void> Function() function) async {
  var sw = Stopwatch()..start();
  await function();
  sw.stop();
  return sw.elapsed;
}
