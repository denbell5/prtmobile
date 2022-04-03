import 'package:integration_test/integration_test_driver.dart';
import 'package:flutter_driver/flutter_driver.dart' as driver;

String testResultLabel = () {
  var now = DateTime.now().toUtc();
  return '${now.month}-${now.day}-${now.hour}-${now.hour}-${now.minute}-${now.second}';
}.call();

Future<void> main() {
  return integrationDriver(
    responseDataCallback: (data) async {
      if (data != null) {
        final timeline = driver.Timeline.fromJson(data['expandable']);
        final summary = driver.TimelineSummary.summarize(timeline);
        await summary.writeTimelineToFile(
          'expandable.$testResultLabel',
          destinationDirectory: 'integration_test/expandable/test_results/',
          pretty: true,
          includeSummary: true,
        );
      }
    },
  );
}
