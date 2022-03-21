import 'package:prtmobile/core/core.dart';

import '../models/models.dart';

NormalizedList<Trackset, String> normalizeTracksets(
  List<Trackset> tracksets,
) {
  return NormalizedList.normalize(tracksets, (item) => item.id);
}

NormalizedList<Track, String> normalizeTracks(
  List<Track> tracks,
) {
  return NormalizedList.normalize(tracks, (item) => item.id);
}

NormalizedList<Subtrack, String> normalizeSubtracks(
  List<Subtrack> subtracks,
) {
  return NormalizedList.normalize(subtracks, (item) => item.id);
}
