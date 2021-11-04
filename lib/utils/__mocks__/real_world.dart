import 'dart:math';

import 'package:prtmobile/models/models.dart';
import 'package:prtmobile/utils/utils.dart';

Subtrack _generateRange({
  required int minValue,
}) {
  final start = minValue + 1 + Random(minValue).nextInt(50);
  final end = start + 1 + Random(minValue).nextInt(100);
  final pointer = start + Random(minValue).nextInt(end - start);
  return Subtrack(
    id: DateTime.now().microsecondsSinceEpoch.toString(),
    start: start,
    end: end,
    pointer: pointer,
  );
}

List<Subtrack> _generangeRangeList() {
  final list = <Subtrack>[];
  final length = Random().nextInt(10);
  for (var i = 1; i < length + 1; i++) {
    list.add(_generateRange(minValue: i * 100));
  }
  return list;
}

NormalizedList<Trackset, String> getRealWorldTracksets() {
  final tracks = <Track>[
    Track(
      id: '1',
      name: 'Read "Davies A. Async in C# 5.0"',
      subtracks: normalizeSubtracks(_generangeRangeList()),
    ),
    Track(
      id: '2',
      name: 'Read Entity Framework Core In Action by Jon P Smith',
      subtracks: normalizeSubtracks(_generangeRangeList()),
    ),
    Track(
      id: '3',
      name: 'Watch series in english',
      subtracks: normalizeSubtracks(_generangeRangeList()),
    ),
    Track(
      id: '4',
      name: 'Reach 4 kyu on codewars.com',
      subtracks: normalizeSubtracks(_generangeRangeList()),
    ),
    Track(
      id: '5',
      name:
          'Read “The Clean Coder: A Code of Conduct for Professional Programmers”',
      subtracks: normalizeSubtracks(_generangeRangeList()),
    ),
    Track(
      id: '6',
      name: 'Read Pro Git book by Scott Chacon and Ben Straub',
      subtracks: normalizeSubtracks(_generangeRangeList()),
    ),
  ];
  final normalizedTracks = normalizeTracks(tracks);
  final tracksets = <Trackset>[
    Trackset(
      id: '1',
      name: 'OKR 2021 Q1 - Q2',
      startAt: DateTime(2021, 1, 5),
      endAt: DateTime(2021, 4, 5),
      tracks: normalizedTracks,
    ),
    Trackset(
      id: '2',
      name: 'OKR 2021 Q2 - Q3',
      startAt: DateTime(2021, 4, 6),
      endAt: DateTime(2021, 7, 6),
      tracks: normalizedTracks,
    ),
    Trackset(
      id: '3',
      name: 'OKR 2021 Q3 - Q4',
      startAt: DateTime(2021, 7, 27),
      endAt: DateTime(2021, 10, 27),
      tracks: normalizedTracks,
    ),
    Trackset(
      id: '4',
      name: 'OKR 2021 Q4 - 2022 Q1',
      startAt: DateTime(2021, 11, 4),
      endAt: DateTime(2022, 2, 4),
      tracks: normalizedTracks,
    ),
  ];
  final normalizedTracksets = normalizeTracksets(tracksets);
  return normalizedTracksets;
}
