import '../../../models/data_model.dart';
import '../../data_repository.dart';

class ProjectProductVariantRepository extends RemoteRepository<ProjectProductVariantModel, ProjectProductVariantRequestModel> {
  ProjectProductVariantRepository(
    super.dio, {
    required super.path,
    super.entityName = 'ProjectProductVariant',
  });
}
