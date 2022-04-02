import 'package:prtmobile/features/tracking/func/__mocks__/mocks.dart';
import 'package:prtmobile/features/tracking/tracking.dart';

class TrackFactory {
  static Track buildTrack(
    int index, {
    required String tracksetId,
    List<Subtrack> subtracks = const [],
    int? subtrackCount,
  }) {
    var _subtracks = subtracks;
    if (subtrackCount != null) {
      _subtracks = SubtrackFactory.buildSubtracks(
        subtrackCount,
        trackId: '$index',
      );
    }
    final normalizedSubtracks = normalizeSubtracks(_subtracks);
    return Track(
      id: '$index',
      tracksetId: tracksetId,
      name: 'Track $index',
      subtracks: normalizedSubtracks,
    );
  }

  static List<Track> buildTracks(
    int count, {
    required String tracksetId,
    int? subtrackCount,
  }) {
    final values = <Track>[];
    for (var i = 0; i < count; i++) {
      values.add(
        buildTrack(
          i,
          tracksetId: tracksetId,
          subtrackCount: subtrackCount,
        ),
      );
    }
    return values;
  }
}
