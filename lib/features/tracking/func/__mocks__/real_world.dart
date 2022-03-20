import 'dart:math';

import 'package:prtmobile/core/core.dart';
import 'package:prtmobile/features/tracking/tracking.dart';

Subtrack _generateRange({
  required int minValue,
  required String trackId,
}) {
  final start = minValue + 1 + Random(minValue).nextInt(50);
  final end = start + 1 + Random(minValue).nextInt(100);
  final pointer = start + Random(minValue).nextInt(end - start);
  return Subtrack(
    id: DateTime.now().microsecondsSinceEpoch.toString(),
    trackId: trackId,
    start: start,
    end: end,
    pointer: pointer,
  );
}

List<Subtrack> _generangeRangeList({
  required String trackId,
}) {
  final list = <Subtrack>[];
  final length = Random().nextInt(10);
  for (var i = 1; i < length + 1; i++) {
    list.add(
      _generateRange(minValue: i * 100, trackId: trackId),
    );
  }
  return list;
}

NormalizedList<Trackset, String> getRealWorldTracksets() {
  Track _track(
    String tracksetId,
    Track track,
  ) {
    final id = tracksetId + track.id;
    return track.copyWith(
      id: id,
      subtracks: normalizeSubtracks(_generangeRangeList(trackId: id)),
    );
  }

  List<Track> tracks(String tracksetId) => <Track>[
        _track(
          tracksetId,
          Track(
            id: '1',
            tracksetId: tracksetId,
            name: 'Read "Davies A. Async in C# 5.0"',
          ),
        ),
        _track(
          tracksetId,
          Track(
            id: '2',
            tracksetId: tracksetId,
            name: 'Read Entity Framework Core In Action by Jon P Smith',
          ),
        ),
        _track(
          tracksetId,
          Track(
            id: '3',
            tracksetId: tracksetId,
            name: 'Watch series in english',
          ),
        ),
        _track(
          tracksetId,
          Track(
            id: '4',
            tracksetId: tracksetId,
            name: 'Reach 4 kyu on codewars.com',
          ),
        ),
        _track(
          tracksetId,
          Track(
            id: '5',
            tracksetId: tracksetId,
            name:
                'Read “The Clean Coder: A Code of Conduct for Professional Programmers”',
          ),
        ),
        _track(
          tracksetId,
          Track(
            id: '6',
            tracksetId: tracksetId,
            name: 'Read Pro Git book by Scott Chacon and Ben Straub',
          ),
        ),
      ];

  final tracksets = <Trackset>[
    Trackset(
      id: '1',
      name: 'OKR 2021 Q1 - Q2',
      startAt: DateTime(2021, 1, 5),
      endAt: DateTime(2021, 4, 5),
      tracks: normalizeTracks(tracks('1')),
    ),
    Trackset(
      id: '2',
      name: 'OKR 2021 Q2 - Q3',
      startAt: DateTime(2021, 4, 6),
      endAt: DateTime(2021, 7, 6),
      tracks: normalizeTracks(tracks('2')),
    ),
    Trackset(
      id: '3',
      name: 'OKR 2021 Q3 - Q4',
      startAt: DateTime(2021, 7, 27),
      endAt: DateTime(2021, 10, 27),
      tracks: normalizeTracks(tracks('3')),
    ),
    Trackset(
      id: '4',
      name: 'OKR 2021 Q4 - 2022 Q1',
      startAt: DateTime(2021, 11, 4),
      endAt: DateTime(2022, 2, 4),
      tracks: normalizeTracks(tracks('4')),
    ),
  ];
  final normalizedTracksets = normalizeTracksets(tracksets);
  return normalizedTracksets;
}
