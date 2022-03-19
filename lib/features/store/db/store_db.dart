import 'package:prtmobile/features/store/store.dart';

class TrackingStoreDb {
  Future<void> init() async {
    await Future<void>.delayed(const Duration(seconds: 1));
  }

  Future<List<TracksetSo>> getTracksets() async {
    await Future<void>.delayed(const Duration(seconds: 1));
    final subtracks = <SubtrackSo>[
      const SubtrackSo(start: 10, end: 20),
      const SubtrackSo(start: 30, end: 40),
    ];
    final tracks = <TrackSo>[
      TrackSo(name: 'Read Descrete math', subtracks: subtracks),
      TrackSo(name: 'Read Physics: Mechanics', subtracks: subtracks),
    ];
    return [
      TracksetSo(
        name: 'CE 1-1',
        recommendedDays: 90,
        tracks: tracks,
      ),
      TracksetSo(
        name: 'CE 1-2',
        recommendedDays: 90,
        tracks: tracks,
      ),
    ];
  }
}
