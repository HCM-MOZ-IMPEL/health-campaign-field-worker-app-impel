import 'dart:async';

import 'package:digit_data_model/data_model.dart';
import 'package:digit_data_model/models/entities/user_action.dart';

class UserActionLocalRepository
    extends LocalRepository<UserActionModel, UserActionSearchModel> {
  const UserActionLocalRepository(super.sql, super.opLogManager);

  @override
  DataModelType get type => DataModelType.userAction;

  @override
  FutureOr<List<UserActionModel>> search(UserActionSearchModel query) {
    // TODO: implement search
    throw UnimplementedError();
  }
}
