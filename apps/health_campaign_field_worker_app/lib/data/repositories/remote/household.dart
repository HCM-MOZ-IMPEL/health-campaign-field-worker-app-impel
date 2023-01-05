import '../../../models/data_model.dart';
import '../../data_repository.dart';

class HouseholdRepository extends RemoteRepository<HouseholdModel, HouseholdRequestModel> {
  HouseholdRepository(
    super.dio, {
    required super.path,
    super.entityName = 'Household',
  });
}
