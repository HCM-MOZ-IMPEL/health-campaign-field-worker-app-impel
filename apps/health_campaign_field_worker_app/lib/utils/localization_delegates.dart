import 'package:inventory_management/blocs/app_localization.dart'
    as inventory_localization;
import 'package:registration_delivery/blocs/app_localization.dart'
    as registration_delivery_localization;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:isar/isar.dart';

import '../blocs/localization/app_localization.dart';
import '../data/local_store/no_sql/schema/app_configuration.dart';
import 'utils.dart';

getAppLocalizationDelegates({
  required Isar isar,
  required AppConfiguration appConfig,
  required String selectedLocale,
}) {
  return [
    AppLocalizations.getDelegate(
      appConfig,
      isar,
    ),
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    registration_delivery_localization.RegistrationDeliveryLocalization
        .getDelegate(
      getLocalizationString(
        isar,
        selectedLocale,
      ),
      appConfig.languages!,
    ),
    inventory_localization.InventoryLocalization.getDelegate(
      getLocalizationString(
        isar,
        selectedLocale,
      ),
      appConfig.languages!,
    ),
  ];
}
