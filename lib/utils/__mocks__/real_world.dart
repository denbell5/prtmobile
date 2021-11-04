import 'package:prtmobile/models/models.dart';
import 'package:prtmobile/utils/utils.dart';

NormalizedList<Trackset, String> getRealWorldTracksets() {
  final tracks = <Track>[
    Track(
      id: '1',
      name: 'Read "Davies A. Async in C# 5.0"',
      subtracks: NormalizedList.createEmpty(),
    ),
    Track(
      id: '2',
      name: 'Read Entity Framework Core In Action by Jon P Smith',
      subtracks: NormalizedList.createEmpty(),
    ),
    Track(
      id: '3',
      name: 'Watch series in english',
      subtracks: NormalizedList.createEmpty(),
    ),
    Track(
      id: '4',
      name: 'Reach 4 kyu on codewars.com',
      subtracks: NormalizedList.createEmpty(),
    ),
    Track(
      id: '5',
      name:
          'Read “The Clean Coder: A Code of Conduct for Professional Programmers”',
      subtracks: NormalizedList.createEmpty(),
    ),
    Track(
      id: '6',
      name: 'Read Pro Git book by Scott Chacon and Ben Straub',
      subtracks: NormalizedList.createEmpty(),
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
