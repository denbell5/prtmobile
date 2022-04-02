import 'package:prtmobile/core/core.dart';
import 'package:prtmobile/features/tracking/func/__mocks__/mocks.dart';
import 'package:prtmobile/features/tracking/tracking.dart';

NormalizedList<Trackset, String> buildTrackingData() {
  final tracksets = TracksetFactory.buildTracksets(
    count: 10,
    trackCount: 10,
    subtrackCount: 10,
  );

  return normalizeTracksets(tracksets);
}
