// Generated using mason. Do not modify by hand

import 'package:drift/drift.dart';

class ProjectProductVariant extends Table {
  TextColumn get productVariantId => text().nullable()();
  TextColumn get type => text().nullable()();
  BoolColumn get isBaseUnitVariant => boolean().nullable()();
  TextColumn get auditCreatedBy => text().nullable()();
  IntColumn get auditCreatedTime => integer().nullable()();
  TextColumn get auditModifiedBy => text().nullable()();
  IntColumn get auditModifiedTime => integer().nullable()();
  TextColumn get clientReferenceId => text()();
  TextColumn get tenantId => text().nullable()();
  BoolColumn get isDeleted => boolean().nullable()();
  IntColumn get rowVersion => integer().nullable()();

  @override
  Set<Column> get primaryKey => {
        auditCreatedBy,
        clientReferenceId,
      };
}
