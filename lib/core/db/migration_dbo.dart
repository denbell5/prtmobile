class _MigrationDboSchema {
  const _MigrationDboSchema();

  final String tableName = 'migrations';

  final String name = 'name';
  final String appliedAt = 'appliedAt';
}

class MigrationDbo {
  static const _MigrationDboSchema schema = _MigrationDboSchema();

  final String name;
  final DateTime appliedAt;

  MigrationDbo({
    required this.name,
    required this.appliedAt,
  });

  Map<String, dynamic> toRaw() {
    return {
      schema.name: name,
      schema.appliedAt: appliedAt.toIso8601String(),
    };
  }

  static MigrationDbo fromRaw(Map<String, dynamic> map) {
    return MigrationDbo(
      name: map[schema.name],
      appliedAt: DateTime.parse(map[schema.appliedAt]),
    );
  }

  static String buildCreateQuery() {
    return 'CREATE TABLE ${schema.tableName} ('
        '${schema.name} TEXT PRIMARY KEY NOT NULL,'
        '${schema.appliedAt} TEXT NOT NULL'
        ')';
  }
}
