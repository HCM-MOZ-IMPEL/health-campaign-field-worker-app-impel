library app_utils;

import 'package:survey_form/survey_form.init.dart' as surveyForm_mappers;

import 'package:digit_dss/data/local_store/no_sql/schema/dashboard_config_schema.dart';
import 'package:health_campaign_field_worker_app/models/entities/roles_type.dart';
import 'package:inventory_management/models/entities/stock.dart';
import 'package:inventory_management/utils/utils.dart';
import 'package:complaints/complaints.init.dart' as complaints_mappers;
import 'package:referral_reconciliation/referral_reconciliation.dart'
    as referral_reconciliation_mappers;
import 'package:attendance_management/attendance_management.dart'
    as attendance_mappers;
import 'package:collection/collection.dart';
import 'package:digit_components/utils/date_utils.dart';

import 'package:disable_battery_optimization/disable_battery_optimization.dart';
import 'package:inventory_management/inventory_management.init.dart'
    as inventory_mappers;
import 'package:registration_delivery/registration_delivery.dart';
import 'package:registration_delivery/registration_delivery.init.dart'
    as registration_delivery_mappers;
import 'package:closed_household/closed_household.dart'
    as closed_household_mappers;
// import 'package:attendance_management/attendance_management.dart'
//     as attendance_mappers;
import 'package:digit_data_model/data_model.init.dart' as data_model_mappers;
import 'package:digit_dss/digit_dss.dart' as dss_mappers;
import '../../utils/i18_key_constants.dart' as i18_local;
import 'package:inventory_management/utils/i18_key_constants.dart' as i18_stock;

import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:digit_components/theme/digit_theme.dart';
import 'package:digit_components/widgets/atoms/digit_toaster.dart';
import 'package:digit_components/widgets/digit_dialog.dart';
import 'package:digit_components/widgets/digit_sync_dialog.dart';
import 'package:digit_data_model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../blocs/app_initialization/app_initialization.dart';
import '../blocs/projects_beneficiary_downsync/project_beneficiaries_downsync.dart';
import '../data/local_store/app_shared_preferences.dart';
import '../data/local_store/no_sql/schema/localization.dart';
import '../data/local_store/secure_store/secure_store.dart';
import '../models/app_config/app_config_model.dart';
import '../models/data_model.init.dart';
import '../models/entities/project_types.dart';
import '../models/entities/status.dart';
import '../router/app_router.dart';
import '../widgets/progress_indicator/progress_indicator.dart';
import 'constants.dart';
import 'extensions/extensions.dart';

export 'app_exception.dart';
export 'constants.dart';
export 'extensions/extensions.dart';

String lessThanSymbol = '<';
String greaterThanSymbol = '>';

class CustomValidator {
  /// Validates that control's value must be `true`
  static Map<String, dynamic>? requiredMin(
    AbstractControl<dynamic> control,
  ) {
    return control.value == null ||
            control.value.toString().trim().length >= 2 ||
            control.value.toString().trim().isEmpty
        ? null
        : {'required': true};
  }

  static Map<String, dynamic>? requiredMin2(
    AbstractControl<dynamic> control,
  ) {
    return control.value == null ||
            control.value.toString().trim().length >= 2 ||
            control.value.toString().trim().isEmpty
        ? null
        : {'min2': true};
  }

  static Map<String, dynamic>? requiredMin3(
    AbstractControl<dynamic> control,
  ) {
    return control.value == null ||
            control.value.toString().trim().length >= 3 ||
            control.value.toString().trim().isEmpty
        ? null
        : {'min3': true};
  }

  static Map<String, dynamic>? validMobileNumber(
    AbstractControl<dynamic> control,
  ) {
    if (control.value == null || control.value.toString().isEmpty) {
      return null;
    }

    const pattern = r'[0-9]';

    if (control.value.toString().length != 9) {
      return {'mobileNumber': true};
    }

    if (RegExp(pattern).hasMatch(control.value.toString())) return null;

    return {'mobileNumber': true};
  }

  static Map<String, dynamic>? validStockCount(
    AbstractControl<dynamic> control,
  ) {
    if (control.value == null || control.value.toString().isEmpty) {
      return {'required': true};
    }

    var parsed = int.tryParse(control.value) ?? 0;
    if (parsed < 0) {
      return {'min': true};
    } else if (parsed > 100000000) {
      return {'max': true};
    }

    return null;
  }
}

bool isLGAUser() {
  String? boundaryLevel =
      RegistrationDeliverySingleton().selectedProject?.address?.boundaryType;
  if (InventorySingleton().isWareHouseMgr) {
    if (boundaryLevel == Constants.lgaBoundaryLevel) {
      return true;
    }
  }
  return false;
}

bool isHFUser(BuildContext context) {
  try {
    // todo : verify this make this healthFacilitySupervsior as per kebbi
    bool isDownSyncEnabled = context.loggedInUserRoles
        .where(
          (role) =>
              role.code == RolesType.healthFacilityWorker.toValue() ||
              role.code == RolesType.healthFacilitySupervisor.toValue(),
        )
        .toList()
        .isNotEmpty;

    return isDownSyncEnabled;
  } catch (_) {
    return false;
  }
}

String formatDateFromMillis(int millis) {
  final date = DateTime.fromMillisecondsSinceEpoch(millis);
  final day = date.day.toString().padLeft(2, '0');
  final month = _monthShort(date.month);
  final year = date.year;
  return '$day $month $year';
}

String _monthShort(int month) {
  const months = [
    'Janeiro',
    'Fevereiro',
    'Março',
    'Abril',
    'Maio',
    'Junho',
    'Julho',
    'Agosto',
    'Setembro',
    'Outubro',
    'Novembro',
    'Dezembro'
  ];
  return months[month - 1];
}

String getEntryTypeLabel(StockModel? stock) {
  String label =
      '${i18_stock.stockDetails.receivedPageTitle}_${i18_stock.stockReconciliationDetails.stockLabel}';

  if (stock != null) {
    if (stock.transactionType == "RECEIVED" &&
        stock.transactionReason == "RETURNED") {
      label = i18_local.stockDetails.selectTransactingPartyReturnedFrom;
    } else if (stock.transactionType == "DISPATCHED" &&
        stock.senderType == "STAFF") {
      label = i18_local.stockDetails.returnedTo;
    } else if (stock.transactionType == "DISPATCHED") {
      label =
          '${i18_stock.stockDetails.issuedPageTitle}_${i18_stock.stockReconciliationDetails.stockLabel}';
    }
  }

  return label;
}

String getSecondaryPartyValue(StockModel? stock) {
  String value = stock?.receiverId ?? "";

  if (stock != null) {
    if ((stock.transactionType == "RECEIVED" && stock.senderType == "STAFF") ||
        (stock.transactionType == "DISPATCHED" &&
            stock.receiverType == "STAFF")) {
      value = stock.additionalFields?.fields
              .firstWhereOrNull((e) => e.key == "distributorName")
              ?.value ??
          "Delivery Team";
    } else {
      value = stock.transactionType == "RECEIVED"
          ? 'FAC_${stock.senderId}'
          : 'FAC_${stock.receiverId}';
    }
  }

  return value;
}

List<String> extractAllSkus(List<ProductVariantModel> variants) {
  return variants.map((variant) => variant.sku).whereType<String>().toList();
}

setBgRunning(bool isBgRunning) async {
  final localSecureStore = LocalSecureStore.instance;
  await localSecureStore.setBackgroundService(isBgRunning);
}

performBackgroundService({
  BuildContext? context,
  required bool stopService,
  required bool isBackground,
}) async {
  final connectivityResult = await (Connectivity().checkConnectivity());

  final isOnline = connectivityResult.firstOrNull == ConnectivityResult.wifi ||
      connectivityResult.firstOrNull == ConnectivityResult.mobile;
  final service = FlutterBackgroundService();
  var isRunning = await service.isRunning();

  if (stopService) {
    if (isRunning) {
      if (!isBackground && context != null) {
        if (context.mounted) {
          DigitToast.show(
            context,
            options: DigitToastOptions(
              'Serviço em segundo plano interrompido',
              true,
              DigitTheme.instance.mobileTheme,
            ),
          );
        }
      }
    }
  } else {
    if (!isRunning && isOnline) {
      service.startService();
      if (context != null && context.mounted) {
        requestDisableBatteryOptimization();
        DigitToast.show(
          context,
          options: DigitToastOptions(
            'Serviço em segundo plano iniciado',
            false,
            DigitTheme.instance.mobileTheme,
          ),
        );
      }
    }
  }
}

String maskString(String input) {
  // Define the character to use for masking (e.g., "*")
  const maskingChar = '*';

  // Create a new string with the same length as the input string
  final maskedString =
      List<String>.generate(input.length, (index) => maskingChar).join();

  return maskedString;
}

List<MdmsMasterDetailModel> getMasterDetailsModel(List<String> masterNames) {
  return masterNames.map((e) => MdmsMasterDetailModel(e)).toList();
}

Timer makePeriodicTimer(
  Duration duration,
  void Function(Timer timer) callback, {
  bool fireNow = false,
}) {
  var timer = Timer.periodic(duration, callback);
  if (fireNow) {
    callback(timer);
  }

  return timer;
}

final requestData = {
  "data": [
    {
      "id": 1,
      "name": "John Doe",
      "age": 30,
      "email": "johndoe@example.com",
      "address": {
        "street": "123 Main Street",
        "city": "New York",
        "state": "NY",
        "zipcode": "10001",
      },
      "orders": [
        {
          "id": 101,
          "product": "Widget A",
          "quantity": 2,
          "price": 10.99,
        },
        {
          "id": 102,
          "product": "Widget B",
          "quantity": 1,
          "price": 19.99,
        },
      ],
    },
    {
      "id": 2,
      "name": "Jane Smith",
      "age": 25,
      "email": "janesmith@example.com",
      "address": {
        "street": "456 Elm Street",
        "city": "Los Angeles",
        "state": "CA",
        "zipcode": "90001",
      },
      "orders": [
        {
          "id": 201,
          "product": "Widget C",
          "quantity": 3,
          "price": 15.99,
        },
        {
          "id": 202,
          "product": "Widget D",
          "quantity": 2,
          "price": 12.99,
        },
      ],
    },
    // ... Repeat the above structure to reach approximately 100KB in size
  ],
};

Future<bool> getIsConnected() async {
  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }

    return false;
  } on SocketException catch (_) {
    return false;
  }
}

int getAgeMonths(DigitDOBAge age) {
  return (age.years * 12) + age.months;
}

// todo verify the else condition once
// Info : will handle the ageCondition based on projectTypeCode
String? getAgeConditionString(String condition, BuildContext context) {
  String? finalCondition;
  final ageConditions =
      condition.split('and').where((element) => element.contains('age'));
  if (ageConditions.length == 2) {
    String? lessThanCondition = ageConditions.firstWhereOrNull((element) {
      return element.contains("<age");
    });
    String lessThanAge = lessThanCondition?.split(lessThanSymbol).first ?? '0';

    String? greaterThanCondition =
        ageConditions.firstWhereOrNull((element) => element.contains("age<"));

    String greaterThanAge =
        greaterThanCondition?.split(lessThanSymbol).last ?? '0';

    if (context.projectTypeCode == ProjectTypes.smc.toValue()) {
      finalCondition =
          '${int.parse(lessThanAge) + 1} - ${int.parse(greaterThanAge) - 1}';
    } else {
      finalCondition =
          '${(int.parse(greaterThanAge) / 12).round()} - ${(int.parse(lessThanAge) / 12).round()}';
    }
  } else {
    if (ageConditions.first.contains(greaterThanSymbol)) {
      String age = ageConditions.first.split(greaterThanSymbol).last;
      if (context.projectTypeCode == ProjectTypes.smc.toValue()) {
        finalCondition = '${int.parse(age)} months and above';
      } else {
        finalCondition = '${(int.parse(age) / 12).round()} yrs and above';
      }
    }
  }

  return finalCondition;
}

List<HouseholdMemberWrapper> sortHouseholdVsDate(
    List<HouseholdMemberWrapper> listHousehold,
    {bool order = false}) {
  final sortedHouseholdByDate = [...listHousehold]..sort((a, b) {
      final aTime =
          a.members?.firstOrNull?.clientAuditDetails?.lastModifiedTime ?? 0;
      final bTime =
          b.members?.firstOrNull?.clientAuditDetails?.lastModifiedTime ?? 0;
      return order ? bTime.compareTo(aTime) : aTime.compareTo(bTime);
    });

  return sortedHouseholdByDate;
}

String? getAgeConditionStringFromVariant(
    DeliveryProductVariant productVariant, List<ProductVariantModel>? variant) {
  String? finalCondition;
  String? value = variant
      ?.firstWhereOrNull(
        (element) => element.id == productVariant.productVariantId,
      )
      ?.sku;

  if (value != null) {
    finalCondition = value.split('(').last.split(')').first;
  }

  return finalCondition;
}

void showDownloadDialog(
  BuildContext context, {
  required DownloadBeneficiary model,
  required DigitProgressDialogType dialogType,
  bool isPop = true,
  StreamController<double>? downloadProgressController,
}) {
  if (isPop) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  switch (dialogType) {
    case DigitProgressDialogType.failed:
    case DigitProgressDialogType.checkFailed:
      DigitSyncDialog.show(
        context,
        type: DigitSyncDialogType.failed,
        label: model.title,
        primaryAction: DigitDialogActions(
          label: model.primaryButtonLabel ?? '',
          action: (ctx) {
            if (dialogType == DigitProgressDialogType.failed ||
                dialogType == DigitProgressDialogType.checkFailed) {
              Navigator.of(context, rootNavigator: true).pop();
              context.read<BeneficiaryDownSyncBloc>().add(
                    DownSyncGetBatchSizeEvent(
                      appConfiguration: [model.appConfiguartion!],
                      projectId: context.projectId,
                      boundaryCode: model.boundary,
                      pendingSyncCount: model.pendingSyncCount ?? 0,
                      boundaryName: model.boundaryName,
                    ),
                  );
            } else {
              Navigator.of(context, rootNavigator: true).pop();
              context.router.maybePop();
            }
          },
        ),
        secondaryAction: DigitDialogActions(
          label: model.secondaryButtonLabel ?? '',
          action: (ctx) {
            Navigator.of(context, rootNavigator: true).pop();
            context.router.maybePop();
          },
        ),
      );
    case DigitProgressDialogType.dataFound:
    case DigitProgressDialogType.pendingSync:
    case DigitProgressDialogType.insufficientStorage:
      DigitDialog.show(
        context,
        options: DigitDialogOptions(
          titleText: model.title,
          titleIcon: Icon(
            dialogType == DigitProgressDialogType.insufficientStorage
                ? Icons.warning
                : Icons.info_outline_rounded,
            color: dialogType == DigitProgressDialogType.insufficientStorage
                ? DigitTheme.instance.colorScheme.error
                : DigitTheme.instance.colorScheme.surfaceTint,
          ),
          contentText: model.content,
          primaryAction: DigitDialogActions(
            label: model.primaryButtonLabel ?? '',
            action: (ctx) {
              if (dialogType == DigitProgressDialogType.pendingSync) {
                Navigator.of(context, rootNavigator: true).pop();
                // context.router.popUntilRouteWithName(Home.name);
                (context.selectedProject.additionalDetails?.projectType?.code ==
                        ProjectTypes.smc.toValue())
                    ? context.router.popUntilRouteWithName(SMCWrapperRoute.name)
                    : (context.selectedProject.additionalDetails?.projectType
                                ?.code ==
                            ProjectTypes.irs.toValue())
                        ? context.router
                            .popUntilRouteWithName(IRSWrapperRoute.name)
                        : context.router
                            .popUntilRouteWithName(BednetWrapperRoute.name);
              } else {
                if ((model.totalCount ?? 0) > 0) {
                  context.read<BeneficiaryDownSyncBloc>().add(
                        DownSyncBeneficiaryEvent(
                          projectId: context.projectId,
                          boundaryCode: model.boundary,
                          // Batch Size need to be defined based on Internet speed.
                          batchSize: model.batchSize ?? 1,
                          initialServerCount: model.totalCount ?? 0,
                          boundaryName: model.boundaryName,
                        ),
                      );
                } else {
                  Navigator.of(context, rootNavigator: true).pop();
                  context.read<BeneficiaryDownSyncBloc>().add(
                        const DownSyncResetStateEvent(),
                      );
                }
              }
            },
          ),
          secondaryAction: model.secondaryButtonLabel != null
              ? DigitDialogActions(
                  label: model.secondaryButtonLabel ?? '',
                  action: (ctx) async {
                    await LocalSecureStore.instance.setManualSyncTrigger(false);
                    if (context.mounted) {
                      Navigator.of(context, rootNavigator: true).pop();
                      (context.selectedProject.additionalDetails?.projectType
                                  ?.code ==
                              (ProjectTypes.smc.toValue()))
                          ? context.router.replaceAll([
                              const SMCWrapperRoute(),
                            ])
                          : (context.selectedProject.additionalDetails
                                      ?.projectType?.code ==
                                  ProjectTypes.irs.toValue())
                              ? context.router.replaceAll([
                                  const IRSWrapperRoute(),
                                ])
                              : context.router.replaceAll([
                                  const BednetWrapperRoute(),
                                ]);
                    }
                  },
                )
              : null,
        ),
      );
    case DigitProgressDialogType.inProgress:
      DigitDialog.show(
        context,
        options: DigitDialogOptions(
          title: StreamBuilder<double>(
            stream: downloadProgressController?.stream,
            builder: (context, snapshot) {
              return ProgressIndicatorContainer(
                label: '',
                prefixLabel: '',
                suffixLabel:
                    '${(snapshot.data == null ? 0 : snapshot.data! * model.totalCount!.toDouble()).toInt()}/${model.suffixLabel}',
                value: snapshot.data ?? 0,
                valueColor: AlwaysStoppedAnimation<Color>(
                  DigitTheme.instance.colorScheme.secondary,
                ),
                subLabel: model.title,
              );
            },
          ),
        ),
      );
    default:
      return;
  }
}

//Function to read the localizations from ISAR,
getLocalizationString(Isar isar, String selectedLocale) async {
  List<dynamic> localizationValues = [];

  final List<LocalizationWrapper> localizationList =
      await isar.localizationWrappers
          .filter()
          .localeEqualTo(
            selectedLocale.toString(),
          )
          .findAll();
  if (localizationList.isNotEmpty) {
    localizationValues.addAll(localizationList.first.localization!);
  }

  return localizationValues;
}

getSelectedLanguage(AppInitialized state, int index) {
  if (AppSharedPreferences().getSelectedLocale == null) {
    AppSharedPreferences()
        .setSelectedLocale(state.appConfiguration.languages!.last.value);
  }
  final selectedLanguage = AppSharedPreferences().getSelectedLocale;
  final isSelected =
      state.appConfiguration.languages![index].value == selectedLanguage;

  return isSelected;
}

initializeAllMappers() async {
  List<Future> initializations = [
    Future(() => initializeMappers()),
    Future(() => data_model_mappers.initializeMappers()),
    Future(() => registration_delivery_mappers.initializeMappers()),
    Future(() => inventory_mappers.initializeMappers()),
    Future(() => dss_mappers.initializeMappers()),
    Future(() => attendance_mappers.initializeMappers()),
    Future(() => referral_reconciliation_mappers.initializeMappers()),
    Future(() => complaints_mappers.initializeMappers()),
    Future(() => surveyForm_mappers.initializeMappers()),
  ];
  await Future.wait(initializations);
}

int getSyncCount(List<OpLog> oplogs) {
  int count = oplogs.where((element) {
    if (element.syncedDown == false && element.syncedUp == true) {
      switch (element.entityType) {
        case DataModelType.household:
        case DataModelType.individual:
        case DataModelType.householdMember:
        case DataModelType.projectBeneficiary:
        case DataModelType.task:
        case DataModelType.stock:
        case DataModelType.stockReconciliation:
        case DataModelType.sideEffect:
        case DataModelType.referral:
        case DataModelType.hFReferral:
        case DataModelType.attendance:
          return true;
        default:
          return false;
      }
    } else {
      switch (element.entityType) {
        case DataModelType.household:
        case DataModelType.individual:
        case DataModelType.householdMember:
        case DataModelType.projectBeneficiary:
        case DataModelType.task:
        case DataModelType.stock:
        case DataModelType.stockReconciliation:
        case DataModelType.service:
        case DataModelType.complaints:
        case DataModelType.sideEffect:
        case DataModelType.referral:
        case DataModelType.hFReferral:
        case DataModelType.attendance:
          return true;
        default:
          return false;
      }
    }
  }).length;

  return count;
}

bool checkEligibilityForHouseType(List<String> selectedHouseStructureTypes) {
  if (selectedHouseStructureTypes.contains("METAL") ||
      selectedHouseStructureTypes.contains("GLASS") ||
      selectedHouseStructureTypes.contains("PAPER") ||
      selectedHouseStructureTypes.contains("PLASTIC") ||
      selectedHouseStructureTypes.contains("UNDER_CONSTRUCTION")) {
    return false;
  }
  return true;
}

bool checkIfBeneficiaryIneligible(
  List<TaskModel>? tasks,
) {
  final isBeneficiaryIneligible = (tasks != null &&
      (tasks ?? []).isNotEmpty &&
      tasks.last.status == Status.beneficiaryIneligible.toValue());

  return isBeneficiaryIneligible;
}

Future<void> requestDisableBatteryOptimization() async {
  bool isIgnoringBatteryOptimizations =
      await DisableBatteryOptimization.isBatteryOptimizationDisabled ?? false;

  if (!isIgnoringBatteryOptimizations) {
    await DisableBatteryOptimization.showDisableBatteryOptimizationSettings();
  }
}

class LocalizationParams {
  static final LocalizationParams _singleton = LocalizationParams._internal();

  factory LocalizationParams() {
    return _singleton;
  }

  LocalizationParams._internal();

  List<String>? _code;
  List<String>? _module;
  Locale? _locale;
  bool? _exclude = true;

  void setCode(List<String>? code) {
    _code = code;
  }

  void setModule(List<String>? module, bool? exclude) {
    _module = module;
    _exclude = exclude;
  }

  void setLocale(Locale locale) {
    _locale = locale;
  }

  void clear() {
    _code = null;
    _module = null;
  }

  List<String>? get code => _code;

  List<String>? get module => _module;

  Locale? get locale => _locale;

  bool? get exclude => _exclude;
}

List<DashboardConfigSchema?> filterDashboardConfig(
    List<DashboardConfigSchema?> dashboardConfig, String projectTypeCode) {
  return dashboardConfig
      .where((element) =>
          element != null && element.projectTypeCode == projectTypeCode)
      .toList();
}
