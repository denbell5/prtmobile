import 'package:prtmobile/db/db.dart';
import 'package:sqflite/sqflite.dart';
export 'migration_dbo.dart';
export 'migrations_applier.dart';

typedef MigrationFunction = Future<void> Function(Transaction db);

abstract class Migration {
  String get name => runtimeType.toString();
  Future<void> execute(Transaction db);
}

final migrations = [
  _CreateTracksetsTable(),
];

class _CreateTracksetsTable extends Migration {
  @override
  Future<void> execute(Transaction db) async {
    await db.execute(
      TracksetDbo.buildCreateQuery(),
    );
  }
}
