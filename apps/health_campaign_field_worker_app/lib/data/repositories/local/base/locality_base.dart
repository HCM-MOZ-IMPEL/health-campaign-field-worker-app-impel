import 'package:drift/drift.dart';

import '../../../../models/data_model.dart';
import '../../../data_repository.dart';

abstract class LocalityLocalBaseRepository
    extends LocalRepository<LocalityModel, LocalitySearchModel> {
  const LocalityLocalBaseRepository(super.sql, super.opLogManager);

  @override
  DataModelType get type => DataModelType.locality;

  @override
  TableInfo get table => sql.locality;
}