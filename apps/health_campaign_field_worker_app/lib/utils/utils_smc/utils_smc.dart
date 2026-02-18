library app_utils;

import 'package:digit_data_model/data_model.init.dart';
import 'package:digit_dss/data/local_store/no_sql/schema/dashboard_config_schema.dart';
import 'package:digit_ui_components/utils/date_utils.dart'
    as digit_ui_date_utils;
import 'package:intl/intl.dart';
import 'package:referral_reconciliation/referral_reconciliation.dart'
    as referral_reconciliation_mappers;
import 'package:attendance_management/attendance_management.dart'
    as attendance_mappers;
import 'package:collection/collection.dart';
import 'package:digit_components/utils/date_utils.dart';

import 'package:disable_battery_optimization/disable_battery_optimization.dart';
import 'package:inventory_management/inventory_management.init.dart'
    as inventory_mappers;
import 'package:registration_delivery/models/entities/additional_fields_type.dart';
import 'package:registration_delivery/registration_delivery.dart';
import 'package:registration_delivery/registration_delivery.init.dart'
    as registration_delivery_mappers;
import 'package:closed_household/closed_household.dart'
    as closed_household_mappers;
// import 'package:attendance_management/attendance_management.dart'
//     as attendance_mappers;
import 'package:digit_data_model/data_model.init.dart' as data_model_mappers;
import 'package:digit_dss/digit_dss.dart' as dss_mappers;
import 'package:formula_parser/formula_parser.dart';

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
import 'package:registration_delivery/utils/utils.dart';
import 'package:registration_delivery/models/entities/status.dart'
    as reg_del_status;

import '../../blocs/app_initialization/app_initialization.dart';
import '../../blocs/projects_beneficiary_downsync/project_beneficiaries_downsync.dart';
import '../../data/local_store/app_shared_preferences.dart';
import '../../data/local_store/no_sql/schema/localization.dart';
import '../../data/local_store/no_sql/schema/app_configuration.dart'
    as app_configuration_schema;
import '../../data/local_store/secure_store/secure_store.dart';
import '../../models/app_config/app_config_model.dart';
import '../../models/entities/entities_smc/intervention_types.dart';
import '../../models/entities/project_types.dart';
import '../../models/entities/status.dart';
import '../../router/app_router.dart';
import '../../widgets/progress_indicator/progress_indicator.dart';
import '../constants.dart';
import '../extensions/extensions.dart';

import '../../models/entities/additional_fields_type.dart'
    as additional_fields_local;

export '../app_exception.dart';
export '../constants.dart';
export '../extensions/extensions.dart';

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

  static Map<String, dynamic>? validateHeight(
      AbstractControl<dynamic> control) {
    final value = control.value;
    if (value != null && value.isNotEmpty) {
      final height = int.tryParse(value);
      if (height == null || height < 30 || height > 250) {
        return {'invalidHeight': true};
      }
    }
    return null;
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
      await Future.delayed(const Duration(milliseconds: 500));
      service.invoke("stopService");
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

String getIndividualAge(IndividualModel individualModel) {
  // Guard and validate the DOB string
  final dobString = individualModel.dateOfBirth?.trim();

  // Check for null or empty string
  if (dobString == null || dobString.isEmpty) {
    return '00'; // Default fallback for missing DOB
  }

  try {
    // Safely parse the date of birth
    final dateOfBirth = DateFormat("dd/MM/yyyy").parse(dobString);
    final age = DigitDateUtils.calculateAge(dateOfBirth);

    // Get months and format with leading zero if needed
    final months = getAgeMonths(age);
    return months.toString().length == 1 ? '0$months' : months.toString();
  } on FormatException catch (_) {
    // Fallback to safe default age (0 months) on parse error
    return '00';
  }
}

String? getBeneficiaryId(IndividualModel individualModel) {
  return individualModel.identifiers
      ?.firstWhereOrNull((e) =>
          e.identifierType == IdentifierTypes.uniqueBeneficiaryID.toValue())
      ?.identifierId;
}

List<AdditionalField> getIndividualAdditionalFields(
    IndividualModel? individualModel,
    HouseholdMemberWrapper? householdMemberWrapper) {
  // find height weight from additional fields

  return [
    if (individualModel != null)
      AdditionalField(
        AdditionalFieldsType.age.toValue(),
        getIndividualAge(individualModel),
      ),
    if (individualModel?.gender != null)
      AdditionalField(
        AdditionalFieldsType.gender.toValue(),
        individualModel?.gender,
      ),
    if (individualModel?.clientReferenceId != null)
      AdditionalField(
        'individualClientReferenceId',
        individualModel?.clientReferenceId,
      ),
    if (individualModel != null && getBeneficiaryId(individualModel) != null)
      AdditionalField(
        'uniqueBeneficiaryId',
        getBeneficiaryId(individualModel),
      ),
    if (individualModel?.name?.givenName != null)
      AdditionalField(
        'individualName',
        individualModel?.name?.givenName,
      ),
    if (individualModel?.name?.familyName != null)
      AdditionalField(
        'individualFamilyName',
        individualModel?.name?.familyName,
      ),
  ];
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
                    : context.router
                        .popUntilRouteWithName(IRSWrapperRoute.name);
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
                          ? context.router
                              .popUntilRouteWithName(SMCWrapperRoute.name)
                          : context.router
                              .popUntilRouteWithName(IRSWrapperRoute.name);
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
  ];
  await Future.wait(initializations);
}

bool isHeadBednetDelivered(List<TaskModel>? tasks) {
  if (tasks == null || tasks.isEmpty) return false;
  return tasks.any((task) {
    if (task == null) return false;
    final additionalFields = task.additionalFields?.fields;
    if (additionalFields == null || additionalFields.isEmpty) return false;

    try {
      final headBednetField = additionalFields.firstWhere(
        (field) => field != null && field.key == 'head_bednet_delivery',
        orElse: () => AdditionalField('', null),
      );

      final fieldValue = headBednetField.value;
      if (fieldValue == null) return false;

      return fieldValue == true ||
          fieldValue == 'true' ||
          fieldValue.toString().toLowerCase() == 'true';
    } catch (e) {
      return false;
    }
  });
}

bool isSMCDelivered(List<TaskModel>? tasks) {
  if (tasks == null || tasks.isEmpty) return false;
  return tasks.any((task) {
    if (task == null) return false;
    final additionalFields = task.additionalFields?.fields;
    if (additionalFields == null || additionalFields.isEmpty) return false;

    try {
      final smcDileveredField = additionalFields.firstWhere(
        (field) => field != null && field.key == 'smc_delivered',
        orElse: () => AdditionalField('', null),
      );

      final fieldValue = smcDileveredField.value;
      if (fieldValue == null) return false;

      return fieldValue == true ||
          fieldValue == 'true' ||
          fieldValue.toString().toLowerCase() == 'true';
    } catch (e) {
      return false;
    }
  });
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

///  * Returns [true] if the individual is in the same cycle and is eligible for the next dose,
bool checkEligibilityForAgeAndSideEffectOncho(
  digit_ui_date_utils.DigitDOBAgeConvertor age,
  ProjectTypeModel? projectType,
  TaskModel? tasks,
  List<SideEffectModel>? sideEffects,
) {
  int totalAgeMonths = age.years * 12 + age.months;
  final currentCycle = projectType?.cycles?.firstWhereOrNull(
    (e) =>
        (e.startDate!) < DateTime.now().millisecondsSinceEpoch &&
        (e.endDate!) > DateTime.now().millisecondsSinceEpoch,
    // Return null when no matching cycle is found
  );
  if (currentCycle != null &&
      currentCycle.startDate != null &&
      currentCycle.endDate != null) {
    bool recordedSideEffect = false;
    if ((tasks != null) && sideEffects != null && sideEffects.isNotEmpty) {
      final lastTaskTime =
          tasks.clientReferenceId == sideEffects.last.taskClientReferenceId
              ? tasks.clientAuditDetails?.createdTime
              : null;
      recordedSideEffect = lastTaskTime != null &&
          (lastTaskTime >= currentCycle.startDate! &&
              lastTaskTime <= currentCycle.endDate!);

      return projectType?.validMinAge != null
          ? totalAgeMonths >= 72
              ? recordedSideEffect && !checkStatusOncho([tasks], currentCycle)
                  ? false
                  : true
              : false
          : false;
    } else {
      // add validMin and max age check here
      if (true) {
        return totalAgeMonths >= 72! ? true : false;
      }
      return false;
    }
  }

  return false;
}

DeliveryDoseCriteria? fetchProductVariantForProjectType(
  ProjectTypeModel? projectType,
  IndividualModel? individualModel,
  HouseholdModel? householdModel,
) {
  if (projectType != null) {
    var currentDelivery = projectType.cycles
        ?.firstWhereOrNull((cycle) =>
            cycle.startDate! < DateTime.now().millisecondsSinceEpoch &&
            cycle.endDate! > DateTime.now().millisecondsSinceEpoch)
        ?.deliveries
        ?.firstWhereOrNull((delivery) => delivery.doseCriteria != null);

    return fetchProductVariantLocal(
        currentDelivery, individualModel, householdModel);
  }

  return null;
}

DeliveryDoseCriteria? fetchProductVariantLocal(
    ProjectCycleDelivery? currentDelivery,
    IndividualModel? individualModel,
    HouseholdModel? householdModel) {
  if (currentDelivery != null) {
    var individualAgeInMonths = 0;
    var gender;
    var roomCount;
    var memberCount;
    var height;
    String? structureType;

    if (individualModel != null) {
      final individualAge = DigitDateUtils.calculateAge(
        DigitDateUtils.getFormattedDateToDateTime(
              individualModel.dateOfBirth!,
            ) ??
            DateTime.now(),
      );
      individualAgeInMonths = individualAge.years * 12 + individualAge.months;

      gender = individualModel.gender?.index;

      final heightValue = individualModel.additionalFields?.fields
          .where((element) => element.key == Constants.height)
          .firstOrNull
          ?.value;
      height = int.tryParse(heightValue?.toString() ?? '0') ?? 0;
    }
    if (householdModel != null && householdModel.additionalFields != null) {
      memberCount = householdModel.memberCount;
      roomCount = int.tryParse(householdModel.additionalFields?.fields
              .where((h) => h.key == AdditionalFieldsType.noOfRooms.toValue())
              .firstOrNull
              ?.value
              .toString() ??
          '1')!;
      structureType = householdModel.additionalFields?.fields
          .where((h) =>
              h.key == AdditionalFieldsType.houseStructureTypes.toValue())
          .firstOrNull
          ?.value
          .toString();
    }

    final filteredCriteria = currentDelivery.doseCriteria?.where((criteria) {
      final condition = criteria.condition;
      if (condition != null) {
        if (condition.contains('and')) {
          final conditions = condition.split('and');

          List expressionParser = [];
          for (var element in conditions) {
            final expression = FormulaParser(
              element,
              {
                'age': individualAgeInMonths,
                if (gender != null) 'gender': gender,
                if (memberCount != null) 'memberCount': memberCount,
                if (roomCount != null) 'roomCount': roomCount,
                if (height != null) 'height': height
              },
            );
            final error = expression.parse;
            expressionParser.add(error["value"]);
          }

          return expressionParser.where((element) => element == true).length ==
              conditions.length;
        } else if (condition.contains('or')) {
          final conditions = condition.split('or');

          List expressionParser = [];
          for (var element in conditions) {
            final expression = CustomFormulaParser.parseCondition(element, {
              if (individualModel != null && individualAgeInMonths != 0)
                'age': individualAgeInMonths,
              if (gender != null) 'gender': gender,
              if (memberCount != null) 'memberCount': memberCount,
              if (roomCount != null) 'roomCount': roomCount,
              if (height != null) 'height': height,
              if (structureType != null) 'type_of_structure': structureType
            }, stringKeys: [
              'type_of_structure'
            ]);
            final error = expression;
            expressionParser.add(error["value"]);
          }

          return expressionParser.where((element) => element == true).isNotEmpty
              ? true
              : false;
        } else {
          final conditions = condition.split(
              'and'); // Assuming there's only one condition since we have contain for and check above and split with and will return the first condition so this is valid

          List expressionParser = [];
          for (var element in conditions) {
            final expression = CustomFormulaParser.parseCondition(element, {
              if (individualModel != null && individualAgeInMonths != 0)
                'age': individualAgeInMonths,
              if (gender != null) 'gender': gender,
              if (memberCount != null) 'memberCount': memberCount,
              if (roomCount != null) 'roomCount': roomCount,
              if (structureType != null) 'type_of_structure': structureType
            }, stringKeys: [
              'type_of_structure'
            ]);
            final error = expression;
            expressionParser.add(error["value"]);
          }

          return expressionParser.where((element) => element == true).length ==
              conditions.length;
        }
      }

      return false;
    }).toList();

    return (filteredCriteria ?? []).isNotEmpty ? filteredCriteria?.first : null;
  }

  return null;
}

DeliveryDoseCriteria? fetchProductVariantSMC(
    ProjectCycleDelivery? currentDelivery,
    IndividualModel? individualModel,
    HouseholdModel? householdModel) {
  if (currentDelivery != null) {
    var individualAgeInMonths = 0;
    var gender;
    var roomCount;
    var memberCount;
    String? structureType;
    var height;

    if (individualModel != null) {
      final individualAge = DigitDateUtils.calculateAge(
        DigitDateUtils.getFormattedDateToDateTime(
              individualModel.dateOfBirth!,
            ) ??
            DateTime.now(),
      );
      individualAgeInMonths = individualAge.years * 12 + individualAge.months;

      gender = individualModel.gender?.index;
      final heightValue = individualModel.additionalFields?.fields
          .where((element) => element.key == Constants.height)
          .firstOrNull
          ?.value;
      height = int.tryParse(heightValue?.toString() ?? '0') ?? 0;
    }
    if (householdModel != null && householdModel.additionalFields != null) {
      memberCount = householdModel.memberCount;
      final roomCountValue = householdModel.additionalFields?.fields
          .where((h) => h.key == AdditionalFieldsType.noOfRooms.toValue())
          .firstOrNull
          ?.value;
      roomCount = int.tryParse(roomCountValue?.toString() ?? '1') ?? 1;
      structureType = householdModel.additionalFields?.fields
          .where((h) =>
              h.key == AdditionalFieldsType.houseStructureTypes.toValue())
          .firstOrNull
          ?.value
          .toString();
    }

    final filteredCriteria = currentDelivery.doseCriteria?.where((criteria) {
      final condition = criteria.condition;
      if (condition != null) {
        if (condition.contains('and')) {
          final conditions = condition.split('and');

          List expressionParser = [];
          for (var element in conditions) {
            final expression = FormulaParser(
              element,
              {
                'age': individualAgeInMonths,
                if (gender != null) 'gender': gender,
                if (memberCount != null) 'memberCount': memberCount,
                if (roomCount != null) 'roomCount': roomCount,
                if (height != null) 'height': height
              },
            );
            final error = expression.parse;
            expressionParser.add(error["value"]);
          }

          return expressionParser.where((element) => element == true).length ==
              conditions.length;
        } else if (condition.contains('or')) {
          final conditions = condition.split('or');

          List expressionParser = [];
          for (var element in conditions) {
            final expression = CustomFormulaParser.parseCondition(element, {
              if (individualModel != null && individualAgeInMonths != 0)
                'age': individualAgeInMonths,
              if (gender != null) 'gender': gender,
              if (memberCount != null) 'memberCount': memberCount,
              if (roomCount != null) 'roomCount': roomCount,
              if (height != null) 'height': height,
              if (structureType != null) 'type_of_structure': structureType
            }, stringKeys: [
              'type_of_structure'
            ]);
            final error = expression;
            expressionParser.add(error["value"]);
          }

          return expressionParser.where((element) => element == true).isNotEmpty
              ? true
              : false;
        } else {
          final conditions = condition.split(
              'and'); // Assuming there's only one condition since we have contain for and check above and split with and will return the first condition so this is valid

          List expressionParser = [];
          for (var element in conditions) {
            final expression = CustomFormulaParser.parseCondition(element, {
              if (individualModel != null && individualAgeInMonths != 0)
                'age': individualAgeInMonths,
              if (gender != null) 'gender': gender,
              if (memberCount != null) 'memberCount': memberCount,
              if (roomCount != null) 'roomCount': roomCount,
              if (height != null) 'height': height,
              if (structureType != null) 'type_of_structure': structureType
            }, stringKeys: [
              'type_of_structure'
            ]);
            final error = expression;
            expressionParser.add(error["value"]);
          }

          return expressionParser.where((element) => element == true).length ==
              conditions.length;
        }
      }

      return false;
    }).toList();

    return (filteredCriteria ?? []).isNotEmpty ? filteredCriteria?.first : null;
  }

  return null;
}

bool checkEligibleBasedOnAgeAndHeight(
    DeliverInterventionState deliverInterventionState,
    ProjectTypeModel? projectType,
    IndividualModel? individualModel,
    HouseholdModel? householdModel) {
  final currentCycle =
      deliverInterventionState.cycle >= 0 ? deliverInterventionState.cycle : 0;
  final currentDose =
      deliverInterventionState.dose >= 0 ? deliverInterventionState.dose : 0;
  final item =
      projectType?.cycles?[currentCycle - 1].deliveries?[currentDose - 1];
  final conditions =
      fetchProductVariantSMC(item, individualModel, householdModel)
          ?.condition
          ?.split('and');

  return conditions == null ? true : false;
}

String convertToRange(List<String>? conditions) {
  if (conditions == null || conditions.isEmpty) {
    return '';
  }

  double extractNumber(String? condition, double defaultValue) {
    if (condition == null || condition.isEmpty) {
      return defaultValue;
    }
    final RegExp regExp = RegExp(r'\d+(\.\d+)?');
    final match = regExp.firstMatch(condition);
    return match != null ? double.parse(match.group(0)!) : defaultValue;
  }

  if (conditions.length == 2) {
    String firstCondition = conditions[0];
    String secondCondition = conditions[1];

    if (firstCondition.contains('age') &&
        secondCondition.contains('age') &&
        firstCondition.contains('<') &&
        secondCondition.contains('<')) {
      double ageLimit = extractNumber(secondCondition, 6);
      double heightLimit = (ageLimit * 8) - 0;
      return "0-${heightLimit.toInt()}";
    }

    if (secondCondition.contains('height') && secondCondition.contains('>')) {
      double minHeight = extractNumber(secondCondition, 138);
      return ">${minHeight.toInt()}";
    }
  }

  if (conditions.length == 3) {
    String lastCondition = conditions[2];
    if (lastCondition.contains('height') &&
        lastCondition.contains('<') &&
        lastCondition.indexOf('<') < lastCondition.indexOf('height')) {
      double minHeight = extractNumber(lastCondition, 138);
      return ">${minHeight.toInt()}";
    }

    String condition1 = conditions[1];
    String condition2 = conditions[2];
    double num1 = extractNumber(condition1, 0);
    double num2 = extractNumber(condition2, 100);
    List<double> numbers = [num1, num2]..sort();
    return "${numbers[0].toInt()}-${numbers[1].toInt()}";
  }

  String? condition1, condition2;
  if (conditions.length >= 4) {
    condition1 = conditions[2];
    condition2 = conditions[3];
  }

  if (condition1 == null || condition2 == null) {
    return '';
  }

  double num1 = extractNumber(condition1, 0);
  double num2 = extractNumber(condition2, 100);
  List<double> numbers = [num1, num2]..sort();
  return "${numbers[0].toInt()}-${numbers[1].toInt()}";
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

bool assessmentSMCPending(List<TaskModel>? tasks, ProjectCycle? currentCycle) {
  // this task confirms eligibility and dose administrations is done
  if (currentCycle == null) {
    return true;
  }
  if ((tasks ?? []).isEmpty) {
    return true;
  }
  var successfulTask = tasks!
      .where((element) =>
          element.status == reg_del_status.Status.administeredSuccess.toValue())
      .lastOrNull;

  final successfulTaskCreatedTime =
      successfulTask?.clientAuditDetails?.createdTime;

  if (successfulTaskCreatedTime == null) {
    return true;
  }

  final date = DateTime.fromMillisecondsSinceEpoch(successfulTaskCreatedTime);

  final isLastCycleRunning =
      successfulTaskCreatedTime >= currentCycle.startDate &&
          successfulTaskCreatedTime <= currentCycle.endDate;

  return !isLastCycleRunning;

  //return successfulTask == null;
}

bool assessmentOnchoPending(
    List<TaskModel>? tasks, ProjectCycle? currentCycle) {
  // this task confirms eligibility and dose administrations is done
  if (currentCycle == null) {
    return true;
  }
  if ((tasks ?? []).isEmpty) {
    return true;
  }
  var successfulTask = tasks!
      .where((element) =>
          element.status ==
              reg_del_status.Status.administeredSuccess.toValue() &&
          element.additionalFields?.fields.firstWhereOrNull(
                (e) =>
                    e.key ==
                        additional_fields_local
                            .AdditionalFieldsType.interventionType
                            .toValue() &&
                    e.value == InterventionTypes.oncho.toValue(),
              ) !=
              null)
      .lastOrNull;

  final successfulTaskCreatedTime =
      successfulTask?.clientAuditDetails?.createdTime;

  if (successfulTaskCreatedTime == null) {
    return true;
  }

  final date = DateTime.fromMillisecondsSinceEpoch(successfulTaskCreatedTime);

  final isLastCycleRunning =
      successfulTaskCreatedTime >= currentCycle.startDate &&
          successfulTaskCreatedTime <= currentCycle.endDate;

  return !isLastCycleRunning;

  //return successfulTask == null;
}

bool allDosesDelivered(
  List<TaskModel>? tasks,
  ProjectCycle? selectedCycle,
  List<SideEffectModel>? sideEffects,
  IndividualModel? individualModel,
) {
  if (selectedCycle == null ||
      selectedCycle.id == 0 ||
      (selectedCycle.deliveries ?? []).isEmpty) {
    return true;
  } else {
    if ((tasks ?? []).isNotEmpty) {
      final lastCycle = int.tryParse(tasks?.last.additionalFields?.fields
              .where(
                (e) => e.key == AdditionalFieldsType.cycleIndex.name,
              )
              .firstOrNull
              ?.value ??
          '');
      final lastDose = int.tryParse(tasks?.last.additionalFields?.fields
              .where(
                (e) => e.key == AdditionalFieldsType.doseIndex.name,
              )
              .firstOrNull
              ?.value ??
          '');
      if (lastDose != null &&
          lastDose == selectedCycle.deliveries?.length &&
          lastCycle != null &&
          lastCycle == selectedCycle.id &&
          tasks?.last.status != Status.delivered.name) {
        return true;
      } else if (selectedCycle.id == lastCycle &&
          tasks?.last.status == Status.delivered.name) {
        return false;
      } else if ((sideEffects ?? []).isNotEmpty) {
        return recordedSideEffect(selectedCycle, tasks?.last, sideEffects);
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}

bool checkStatusSMC(List<TaskModel>? tasks, ProjectCycle? currentCycle) {
  if (currentCycle == null) {
    return false;
  }

  if (tasks == null || tasks.isEmpty) {
    return true;
  }

  if (tasks.firstWhereOrNull((e) =>
          e.additionalFields?.fields.firstWhereOrNull(
            (element) =>
                element.key ==
                    additional_fields_local
                        .AdditionalFieldsType.interventionType
                        .toValue() &&
                element.value == InterventionTypes.smc.toValue(),
          ) !=
          null) ==
      null) {
    return true;
  }

  final lastTask = tasks.last;
  final lastTaskCreatedTime = lastTask.clientAuditDetails?.createdTime;

  if (lastTaskCreatedTime == null) {
    return false;
  }

  final date = DateTime.fromMillisecondsSinceEpoch(lastTaskCreatedTime);
  final diff = DateTime.now().difference(date);
  final isLastCycleRunning = lastTaskCreatedTime >= currentCycle.startDate &&
      lastTaskCreatedTime <= currentCycle.endDate;

  if (isLastCycleRunning) {
    if (lastTask.status == Status.delivered.name) {
      return true;
    }

    return false;
  }

  return true;
}

bool checkStatusOncho(List<TaskModel>? tasks, ProjectCycle? currentCycle) {
  if (currentCycle == null) {
    return false;
  }

  if (tasks == null || tasks.isEmpty) {
    return true;
  }

  if (tasks.firstWhereOrNull((e) =>
          e.additionalFields?.fields.firstWhereOrNull(
            (element) =>
                element.key ==
                    additional_fields_local
                        .AdditionalFieldsType.interventionType
                        .toValue() &&
                element.value == InterventionTypes.oncho.toValue(),
          ) !=
          null) ==
      null) {
    return true;
  }

  final lastTask = tasks.last;
  final lastTaskCreatedTime = lastTask.clientAuditDetails?.createdTime;

  if (lastTaskCreatedTime == null) {
    return false;
  }

  final date = DateTime.fromMillisecondsSinceEpoch(lastTaskCreatedTime);
  final diff = DateTime.now().difference(date);
  final isLastCycleRunning = lastTaskCreatedTime >= currentCycle.startDate &&
      lastTaskCreatedTime <= currentCycle.endDate;

  if (isLastCycleRunning) {
    if (lastTask.status == Status.delivered.name) {
      return true;
    }
    return diff.inHours >= 24; // [TODO: Move gap between doses to config]
  }

  return true;
}

bool checkStatusBednet(List<TaskModel>? tasks, ProjectCycle? currentCycle) {
  if (currentCycle == null) {
    return false;
  }

  if (tasks == null || tasks.isEmpty) {
    return true;
  }

  if (tasks.firstWhereOrNull((e) =>
          e.additionalFields?.fields.firstWhereOrNull(
            (element) =>
                element.key ==
                    additional_fields_local
                        .AdditionalFieldsType.interventionType
                        .toValue() &&
                element.value == InterventionTypes.bednet.toValue(),
          ) !=
          null) ==
      null) {
    return true;
  }

  final lastTask = tasks.last;
  final lastTaskCreatedTime = lastTask.clientAuditDetails?.createdTime;

  if (lastTaskCreatedTime == null) {
    return false;
  }

  final date = DateTime.fromMillisecondsSinceEpoch(lastTaskCreatedTime);
  final diff = DateTime.now().difference(date);
  final isLastCycleRunning = lastTaskCreatedTime >= currentCycle.startDate &&
      lastTaskCreatedTime <= currentCycle.endDate;

  if (isLastCycleRunning) {
    if (lastTask.status == Status.delivered.name) {
      return true;
    }
    return diff.inHours >= 24; // [TODO: Move gap between doses to config]
  }

  return true;
}

bool checkIfBeneficiaryRefusedOncho(
  List<TaskModel>? tasks,
) {
  final isBeneficiaryRefused = (tasks != null &&
      (tasks ?? []).isNotEmpty &&
      tasks
              .where((element) =>
                  element.additionalFields?.fields.firstWhereOrNull(
                    (e) =>
                        e.key ==
                            additional_fields_local
                                .AdditionalFieldsType.interventionType
                                .toValue() &&
                        e.value == InterventionTypes.oncho.toValue(),
                  ) !=
                  null)
              .lastOrNull
              ?.status ==
          Status.beneficiaryRefused.toValue());

  return isBeneficiaryRefused;
}

bool checkIfBeneficiaryIneligibleOncho(
  List<TaskModel>? tasks,
) {
  final isBeneficiaryIneligible = (tasks != null &&
      (tasks ?? []).isNotEmpty &&
      tasks
              .where((element) =>
                  element.additionalFields?.fields.firstWhereOrNull(
                    (e) =>
                        e.key ==
                            additional_fields_local
                                .AdditionalFieldsType.interventionType
                                .toValue() &&
                        e.value == InterventionTypes.oncho.toValue(),
                  ) !=
                  null)
              .lastOrNull
              ?.status ==
          Status.beneficiaryIneligible.toValue());

  return isBeneficiaryIneligible;
}

bool checkIfBeneficiaryReferredOncho(
  List<TaskModel>? tasks,
) {
  final isBeneficiaryReferred = (tasks != null &&
      (tasks ?? []).isNotEmpty &&
      tasks
              .where((element) =>
                  element.additionalFields?.fields.firstWhereOrNull(
                    (e) =>
                        e.key ==
                            additional_fields_local
                                .AdditionalFieldsType.interventionType
                                .toValue() &&
                        e.value == InterventionTypes.oncho.toValue(),
                  ) !=
                  null)
              .lastOrNull
              ?.status ==
          Status.beneficiaryReferred.toValue());

  return isBeneficiaryReferred;
}

bool isSmcAndOnchoFlow(
  BuildContext context,
) {
  final isSmcAndOnchoFlow = context.isSmcAndOnchoFlow;

  return isSmcAndOnchoFlow;
}

bool isSmcAndBednetFlow(
  BuildContext context,
) {
  final isSmcAndBednetFlow = context.isSmcAndBednetFlow;

  return isSmcAndBednetFlow;
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

// ============== VACCINE UTILITY METHODS ==============

/// Calculate the age of a child from their date of birth
/// Returns [DigitDOBAge] with years, months, and days
DigitDOBAge? calculateVaccineAge(String? dateOfBirth) {
  if (dateOfBirth == null || dateOfBirth.isEmpty) {
    return null;
  }

  try {
    final dob = DigitDateUtils.getFormattedDateToDateTime(
          dateOfBirth,
        ) ??
        DateTime.now();
    return DigitDateUtils.calculateAge(dob);
  } catch (e) {
    return null;
  }
}

/// Get the appropriate vaccine group based on the child's age
/// [individual] - The individual model containing the date of birth
/// [vaccineGroups] - List of available vaccine groups
/// Returns the matching [VaccineGroup] or null if no match is found
app_configuration_schema.VaccineGroup? getApplicableVaccineGroup(
  IndividualModel? individual,
  List<app_configuration_schema.VaccineGroup>? vaccineGroups,
) {
  if (individual?.dateOfBirth == null ||
      individual!.dateOfBirth!.isEmpty ||
      vaccineGroups == null ||
      vaccineGroups.isEmpty) {
    return null;
  }

  final age = calculateVaccineAge(individual.dateOfBirth);
  if (age == null) {
    return null;
  }

  // Convert age to total months for easier comparison
  final ageInMonths = (age.years * 12) + age.months;

  // Find the matching vaccine group based on age
  // This logic should match your vaccine group definitions
  // Example: 0-3 months = 0-3, 3-6 months = 3-6, etc.
  for (final group in vaccineGroups) {
    if (_vaccineAgeMatchesGroup(ageInMonths, group)) {
      return group;
    }
  }

  return null;
}

/// Check if a given age in months matches a vaccine group
/// This method extracts age ranges from the group code or name
/// Adjust the logic based on your vaccine group naming convention
bool _vaccineAgeMatchesGroup(
    int ageInMonths, app_configuration_schema.VaccineGroup group) {
  final name = group.name?.toLowerCase() ?? '';

  // Try to match range format first (e.g., "0-3 months" -> min: 0, max: 3)
  final RegExp rangeRegex = RegExp(r'(\d+)-(\d+)');
  final rangeMatch = rangeRegex.firstMatch(name);

  if (rangeMatch != null) {
    final minAge = int.tryParse(rangeMatch.group(1) ?? '0') ?? 0;
    final maxAge = int.tryParse(rangeMatch.group(2) ?? '0') ?? 0;

    // Check if ageInMonths falls within the range (inclusive)
    return ageInMonths >= minAge && ageInMonths <= maxAge;
  }

  // Handle single age value format (e.g., "6 months", ">9 months", ">=12 months")
  final RegExp singleValueRegex = RegExp(r'(>=?|<=?)?(\d+)');
  final singleMatch = singleValueRegex.firstMatch(name);

  if (singleMatch != null) {
    final operator = singleMatch.group(1) ?? '';
    final ageValue = int.tryParse(singleMatch.group(2) ?? '0') ?? 0;

    switch (operator) {
      case '>':
        return ageInMonths > ageValue;
      case '>=':
        return ageInMonths >= ageValue;
      case '<':
        return ageInMonths < ageValue;
      case '<=':
        return ageInMonths <= ageValue;
      default:
        // No operator, exact match
        return ageInMonths == ageValue;
    }
  }

  return false;
}

/// Get the list of vaccines applicable for a specific vaccine group
/// [vaccineGroup] - The vaccine group containing vaccine codes
/// [allVaccines] - The list of all available vaccines
/// Returns a list of [Vaccine] objects that are in the group
List<app_configuration_schema.Vaccine> getVaccinesForGroup(
  app_configuration_schema.VaccineGroup? vaccineGroup,
  List<app_configuration_schema.Vaccine>? allVaccines,
) {
  if (vaccineGroup?.vaccineData == null ||
      vaccineGroup!.vaccineData!.isEmpty ||
      allVaccines == null ||
      allVaccines.isEmpty) {
    return [];
  }

  final applicableVaccines = <app_configuration_schema.Vaccine>[];

  // Iterate through the vaccine codes in the group
  for (final vaccineCode in vaccineGroup.vaccineData!) {
    // Find the matching vaccine from the list
    final vaccine = allVaccines.firstWhereOrNull(
      (vaccine) => vaccine.code == vaccineCode,
    );

    if (vaccine != null) {
      applicableVaccines.add(vaccine);
    }
  }

  return applicableVaccines;
}

/// Get all vaccine groups applicable for a specific individual
/// [individual] - The individual model containing the date of birth
/// [vaccineGroups] - List of available vaccine groups
/// Returns a map of vaccine group codes to their corresponding vaccines
Map<String, List<app_configuration_schema.Vaccine>>
    getApplicableVaccinesByGroup(
  IndividualModel? individual,
  List<app_configuration_schema.VaccineGroup>? vaccineGroups,
  List<app_configuration_schema.Vaccine>? allVaccines,
) {
  final result = <String, List<app_configuration_schema.Vaccine>>{};

  if (vaccineGroups == null || vaccineGroups.isEmpty) {
    return result;
  }

  for (final group in vaccineGroups) {
    final applicableVaccines = getVaccinesForGroup(group, allVaccines);
    if (applicableVaccines.isNotEmpty) {
      result[group.code ?? 'unknown'] = applicableVaccines;
    }
  }

  return result;
}

/// Format vaccine age group for display
/// Returns a user-friendly age group label
String getVaccineAgeGroupLabel(app_configuration_schema.VaccineGroup? group) {
  return group?.name ?? 'Unknown Age Group';
}

/// Get child age in a readable format
String getVaccineAgeDisplayText(IndividualModel? individual) {
  if (individual?.dateOfBirth == null || individual!.dateOfBirth!.isEmpty) {
    return 'Age unknown';
  }

  final age = calculateVaccineAge(individual.dateOfBirth);
  if (age == null) {
    return 'Invalid date of birth';
  }

  if (age.years > 0) {
    return '${age.years} year${age.years > 1 ? 's' : ''} ${age.months} month${age.months != 1 ? 's' : ''}';
  } else if (age.months > 0) {
    return '${age.months} month${age.months != 1 ? 's' : ''} ${age.days} day${age.days != 1 ? 's' : ''}';
  } else {
    return '${age.days} day${age.days != 1 ? 's' : ''}';
  }
}
