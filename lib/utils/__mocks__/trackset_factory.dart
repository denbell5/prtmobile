import 'package:prtmobile/models/models.dart';
import 'package:prtmobile/utils/utils.dart';

class TracksetFactory {
  static Trackset buildTrackset(
    int index, {
    List<Track> tracks = const [],
    String? name,
  }) {
    final normalizedTracks = normalizeTracks(tracks);
    final now = DateTime.now();
    return Trackset(
      id: '$index',
      name: name ?? 'Trackset-$index',
      startAt: now,
      endAt: now.add(const Duration(days: 7)),
      tracks: normalizedTracks,
    );
  }

  static List<Trackset> buildTracksets(int count) {
    final values = <Trackset>[];
    for (var i = 0; i < count; i++) {
      values.add(buildTrackset(i));
    }
    return values;
  }
}
