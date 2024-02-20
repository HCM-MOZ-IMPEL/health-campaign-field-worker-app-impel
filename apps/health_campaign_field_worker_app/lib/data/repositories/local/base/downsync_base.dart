import 'package:drift/drift.dart';

import '../../../../models/data_model.dart';
import '../../../data_repository.dart';

abstract class DownsyncLocalBaseRepository
    extends LocalRepository<DownsyncModel, DownsyncSearchModel> {
  const DownsyncLocalBaseRepository(super.sql, super.opLogManager);

  @override
  DataModelType get type => DataModelType.downsync;

  @override
  TableInfo get table => sql.downsync;
}