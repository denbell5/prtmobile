import 'package:sqflite/sqflite.dart';

import 'db.dart';

Future<void> applyMigrations(Database db, List<Migration> migrations) async {
  final appliedMigrationsRaw = await db.query(MigrationDbo.schema.tableName);

  final appliedMigrations =
      appliedMigrationsRaw.map((m) => MigrationDbo.fromRaw(m)).toList();

  appliedMigrations.sort(
    (a, b) => a.appliedAt.compareTo(b.appliedAt),
  );

  final migrationsToApply = migrations
      .where((m) => !appliedMigrations.any((am) => am.name == m.name))
      .toList();

  for (var migration in migrationsToApply) {
    await db.transaction(
      (transaction) async {
        await migration.execute(transaction);
        await _insertMigrationDbo(
          transaction: transaction,
          migrationName: migration.name,
        );
      },
    );
  }
}

Future<void> _insertMigrationDbo({
  required Transaction transaction,
  required String migrationName,
}) {
  final now = DateTime.now().toUtc();
  final migrationDbo = MigrationDbo(
    name: migrationName,
    appliedAt: now,
  ).toRaw();
  return transaction.insert(
    MigrationDbo.schema.tableName,
    migrationDbo,
  );
}
