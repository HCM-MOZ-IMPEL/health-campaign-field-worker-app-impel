import 'package:drift/drift.dart';

import '../../../../models/data_model.dart';
import '../../../data_repository.dart';

abstract class AddressLocalBaseRepository
    extends LocalRepository<AddressModel, AddressSearchModel> {
  const AddressLocalBaseRepository(super.sql, super.opLogManager);

  @override
  DataModelType get type => DataModelType.address;

  @override
  TableInfo get table => sql.address;
}