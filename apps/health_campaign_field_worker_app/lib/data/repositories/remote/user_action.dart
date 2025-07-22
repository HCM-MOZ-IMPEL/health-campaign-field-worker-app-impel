import 'package:digit_data_model/data_model.dart';
import 'package:digit_data_model/models/entities/user_action.dart';

class UserActionRemoteRepository
    extends RemoteRepository<UserActionModel, UserActionSearchModel> {
  UserActionRemoteRepository(
    super.dio, {
    required super.actionMap,
    super.entityName = 'UserAction',
  });

  @override
  DataModelType get type => DataModelType.userAction;
}
