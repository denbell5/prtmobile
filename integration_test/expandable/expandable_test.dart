import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:prtmobile/features/tracking/tracking.dart';
import 'expandable_test_app.dart';

void main() async {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
      as IntegrationTestWidgetsFlutterBinding;
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  testWidgets('Expanding animation benchmark', (WidgetTester tester) async {
    await tester.pumpWidget(const ExpandableTestApp());
    await tester.pumpAndSettle();

    final itemFinder = find.byType(TracksetHeader).first;
    expect(itemFinder, findsOneWidget);

    for (var i = 0; i < 10; i++) {
      await binding.traceAction(
        () async {
          await tester.tap(itemFinder);
          await tester.pumpAndSettle();
        },
        reportKey: 'expandable',
        retainPriorEvents: true,
      );

      // collapse expandable back
      await tester.tap(itemFinder);
      await tester.pumpAndSettle();
    }
  });
}
