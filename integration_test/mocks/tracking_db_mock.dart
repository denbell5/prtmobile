import 'package:prtmobile/core/core.dart';
import 'package:prtmobile/features/tracking/tracking.dart';
import 'package:sqflite/sqflite.dart';

class BaseMockTrackingDb implements TrackingDb {
  @override
  Future<NormalizedList<Trackset, String>> getEnrichedTracksets() =>
      throw UnimplementedError();
  @override
  Database get db => throw UnimplementedError();
  @override
  String get dbName => throw UnimplementedError();
  @override
  Future<void> deleteSubtracks(List<String> ids) => throw UnimplementedError();
  @override
  Future<void> deleteTracks(List<String> ids) => throw UnimplementedError();
  @override
  Future<void> deleteTracksets(List<String> ids) => throw UnimplementedError();
  @override
  Future<void> insertSubtrack(Subtrack subtrack) => throw UnimplementedError();
  @override
  Future<void> insertTrack(Track track) => throw UnimplementedError();
  @override
  Future<void> insertTrackset(Trackset trackset) => throw UnimplementedError();
  @override
  Future<void> insertTracksetEnriched(Trackset trackset) =>
      throw UnimplementedError();
  @override
  Future<void> open() => throw UnimplementedError();
  @override
  Future<void> seedTracksets() => throw UnimplementedError();
  @override
  Future<void> updateSubtrack(Subtrack subtrack) => throw UnimplementedError();
  @override
  Future<void> updateTrack(Track track) => throw UnimplementedError();
  @override
  Future<void> updateTrackset(Trackset trackset) => throw UnimplementedError();
}
