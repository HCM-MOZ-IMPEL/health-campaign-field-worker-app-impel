import 'package:drift/drift.dart';

import '../../../../models/data_model.dart';
import '../../../data_repository.dart';

abstract class HFReferralLocalBaseRepository
    extends LocalRepository<HFReferralModel, HFReferralSearchModel> {
  const HFReferralLocalBaseRepository(super.sql, super.opLogManager);

  @override
  DataModelType get type => DataModelType.hFReferral;

  @override
  TableInfo get table => sql.hFReferral;
}