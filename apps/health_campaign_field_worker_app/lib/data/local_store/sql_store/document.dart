import 'package:drift/drift.dart';

class DocumentTable extends Table {
  TextColumn get id => text()();
  TextColumn get tenantId => text()();
  TextColumn get documentType => text()();
  TextColumn get fileStoreId => text()();
  TextColumn get documentUid => text()();
  

  @override
  Set<Column>? get primaryKey => {  };
}