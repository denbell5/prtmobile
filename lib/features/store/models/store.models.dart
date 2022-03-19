import 'package:prtmobile/models/models.dart';

class TracksetSo {
  final String name;
  final int recommendedDays;
  final List<TrackSo> tracks;

  TracksetSo({
    required this.name,
    required this.recommendedDays,
    required this.tracks,
  });

  int get length => tracks.fold(0, (sum, track) => sum += track.length);
}

class TrackSo {
  final String name;
  final List<SubtrackSo> subtracks;

  TrackSo({
    required this.name,
    required this.subtracks,
  });

  int get length =>
      subtracks.fold(0, (sum, subtrack) => sum += subtrack.length);
}

class SubtrackSo extends Range {
  const SubtrackSo({
    required int start,
    required int end,
  }) : super(start, end);
}
