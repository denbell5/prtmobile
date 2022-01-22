import 'package:prtmobile/db/db.dart';
import 'package:prtmobile/models/models.dart';
import 'package:prtmobile/utils/__mocks__/real_world.dart';
import 'package:prtmobile/utils/utils.dart';
import 'package:sqflite/sqflite.dart';

class TrackingDb {
  late final Database _db;
  final String dbName;

  Database get db => _db;

  TrackingDb({
    required this.dbName,
  });

  Future<void> open() async {
    _db = await openDatabase(
      '$dbName.db',
      version: 1,
      onCreate: _onCreate,
      onOpen: applyMigrations,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      MigrationDbo.buildCreateQuery(),
    );
  }

  Future<NormalizedList<Trackset, String>> getEnrichedTracksets() async {
    Future<List<TracksetDbo>> queryTracksets() async {
      final query = 'select * from ${TracksetDbo.schema.tableName}';
      final raw = await db.rawQuery(query);
      final dbos = raw.map((r) => TracksetDbo.fromRaw(r)).toList();
      return dbos;
    }

    Future<List<TrackDbo>> queryTracks() async {
      final query = 'select * from ${TrackDbo.schema.tableName}';
      final raw = await db.rawQuery(query);
      final dbos = raw.map((r) => TrackDbo.fromRaw(r)).toList();
      return dbos;
    }

    Future<List<SubtrackDbo>> querySubtracks() async {
      final query = 'select * from ${SubtrackDbo.schema.tableName}';
      final raw = await db.rawQuery(query);
      final dbos = raw.map((r) => SubtrackDbo.fromRaw(r)).toList();
      return dbos;
    }

    final tracksetDbos = await queryTracksets();
    final trackDbos = await queryTracks();
    final subtrackDbos = await querySubtracks();

    final subtracks = subtrackDbos.map((dbo) => dbo.toSubtrack()).toList();
    final normalizedSubtracks = normalizeSubtracks(subtracks);

    final tracks = trackDbos
        .map((dbo) => dbo.toTrack().copyWith(subtracks: normalizedSubtracks))
        .toList();

    final normalizedTracks = normalizeTracks(tracks);

    final tracksets = tracksetDbos
        .map((dbo) => dbo.toTrackset().copyWith(tracks: normalizedTracks))
        .toList();

    final normalizedTracksets = normalizeTracksets(tracksets);

    return normalizedTracksets;
  }

  /// For testing purposes only
  Future<void> seedTracksets() async {
    Future<void> insertTracksets(
      Transaction db,
      List<Trackset> tracksets,
    ) async {
      final tracksetDbos = tracksets.mapList(TracksetDbo.fromTrackset);
      final tracksetsRaw = tracksetDbos.mapList((dbo) => dbo.toRaw());
      for (var raw in tracksetsRaw) {
        await db.insert(TracksetDbo.schema.tableName, raw);
      }
    }

    Future<void> insertTracks(
      Transaction db,
      List<Track> tracks,
    ) async {
      final trackDbos = tracks.mapList(TrackDbo.fromTrack);
      final tracksRaw = trackDbos.mapList((dbo) => dbo.toRaw());
      for (var raw in tracksRaw) {
        await db.insert(TrackDbo.schema.tableName, raw);
      }
    }

    Future<void> insertSubtracks(
      Transaction db,
      List<Subtrack> subtracks,
    ) async {
      final subtrackDbos = subtracks.mapList(SubtrackDbo.fromSubtrack);
      final subtracksRaw = subtrackDbos.mapList((dbo) => dbo.toRaw());
      for (var raw in subtracksRaw) {
        await db.insert(SubtrackDbo.schema.tableName, raw);
      }
    }

    final tracksets = getRealWorldTracksets().entities;
    final tracks = tracksets.selectMany((e) => e.tracks.entities);
    final subtracks = tracks.selectMany((x) => x.subtracks.entities);

    await db.transaction((db) async {
      await insertTracksets(db, tracksets);
      await insertTracks(db, tracks);
      await insertSubtracks(db, subtracks);
    });
  }
}
