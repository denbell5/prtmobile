import 'package:prtmobile/core/db/db.dart';
import 'package:sqflite/sqflite.dart';

import '../db.dart';

final migrations = [
  _CreateTracksetsTable(),
  _CreateTracksTable(),
  _CreateSubtracksTable(),
  _AddIsDeletedToTrackset(),
  _MakeTrackIdForeignKeyInSubtrack(),
  _AddUpdatedAtToSubtrack(),
];

class _CreateTracksetsTable extends Migration {
  @override
  Future<void> execute(Transaction db) async {
    await db.execute(
      TracksetDbo.buildCreateQuery(),
    );
  }
}

class _CreateTracksTable extends Migration {
  @override
  Future<void> execute(Transaction db) async {
    await db.execute(
      TrackDbo.buildCreateQuery(),
    );
  }
}

class _CreateSubtracksTable extends Migration {
  @override
  Future<void> execute(Transaction db) async {
    await db.execute(
      SubtrackDbo.buildCreateQuery(),
    );
  }
}

class _AddIsDeletedToTrackset extends Migration {
  @override
  Future<void> execute(Transaction db) async {
    const schema = TracksetDbo.schema;
    final script = '''
      ALTER TABLE ${schema.tableName}
      ADD ${schema.isDeleted} Bit NOT NULL DEFAULT(0)
    ''';
    await db.execute(script);
  }
}

class _MakeTrackIdForeignKeyInSubtrack extends Migration {
  @override
  Future<void> execute(Transaction db) async {
    const subtrackSchema = SubtrackDbo.schema;
    const trackSchema = TrackDbo.schema;
    await db.execute(
      'ALTER TABLE ${subtrackSchema.tableName} RENAME TO ${subtrackSchema.tableName}_old;',
    );
    await db.execute('''
      CREATE TABLE ${subtrackSchema.tableName} (
        ${subtrackSchema.id} TEXT PRIMARY KEY,
        ${subtrackSchema.trackId} TEXT,
        ${subtrackSchema.start} INTEGER,
        ${subtrackSchema.end} INTEGER,
        ${subtrackSchema.pointer} INTEGER,
        CONSTRAINT FK_${subtrackSchema.tableName}_${trackSchema.tableName}_${subtrackSchema.trackId}
          FOREIGN KEY (${subtrackSchema.trackId})
          REFERENCES ${trackSchema.tableName}(${trackSchema.id})
          ON DELETE CASCADE
      );
    ''');
    await db.execute(
      'INSERT INTO ${subtrackSchema.tableName} SELECT * FROM ${subtrackSchema.tableName}_old;',
    );
    await db.execute(
      'DROP TABLE ${subtrackSchema.tableName}_old;',
    );
  }
}

class _AddUpdatedAtToSubtrack extends Migration {
  @override
  Future<void> execute(Transaction db) async {
    const schema = SubtrackDbo.schema;
    final script = '''
      ALTER TABLE ${schema.tableName}
      ADD ${schema.updatedAt} TEXT NULL
    ''';
    await db.execute(script);
  }
}
