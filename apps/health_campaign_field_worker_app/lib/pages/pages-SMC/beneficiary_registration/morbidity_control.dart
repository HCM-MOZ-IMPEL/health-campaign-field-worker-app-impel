import 'package:auto_route/auto_route.dart';
import 'package:digit_components/digit_components.dart';
import 'package:digit_data_model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:registration_delivery/blocs/delivery_intervention/deliver_intervention.dart';
import 'package:registration_delivery/models/entities/task.dart';

import '../../../models/entities/entities_smc/intervention_types.dart';
import '../../../router/app_router.dart';
import '../../../utils/environment_config.dart';
import '../../../utils/utils_smc/utils_smc.dart';
import '../../../widgets/header/back_navigation_help_header.dart';
import '../../../widgets/localized.dart';
import 'package:registration_delivery/utils/i18_key_constants.dart' as i18;
import '../../../utils/utils_smc/i18_key_constants.dart' as i18_local;

@RoutePage()
class MorbidityControlPage extends LocalizedStatefulWidget {
  /// The individual/beneficiary whose morbidity information is being captured
  final IndividualModel? individual;
  final String? projectBeneficiaryClientReferenceId;
  final InterventionTypes interventionType;

  /// The delivery task from delivery intervention page to merge morbidity data into
  final TaskModel? deliveryTask;

  const MorbidityControlPage({
    super.key,
    super.appLocalizations,
    this.individual,
    this.projectBeneficiaryClientReferenceId,
    required this.interventionType,
    this.deliveryTask,
  });

  @override
  State<MorbidityControlPage> createState() => _MorbidityControlPageState();
}

class _MorbidityControlPageState extends LocalizedState<MorbidityControlPage> {
  // Map of disease keys to localization key references
  late final List<MapEntry<String, String>> _diseaseList;
  final clickedStatus = ValueNotifier<bool>(false);
  static const _individualNameKey = 'tinea';
  static const _individualLastNameKey = 'scabies';
  static const _dobKey = 'tungiasis';
  static const _genderKey = 'lymphaticFilariasisStageLymphedema';
  static const _mobileNumberKey = 'lymphaticFilariasisStageMale';
  static const _height = 'tracomaFolicular';
  static const _weight = 'tracomaTrichiasis';
  static const _bmi = 'suspectedLeprosy';
  static const _tineaKey = 'tinea';
  static const _scabiesKey = 'scabies';
  static const _tungiasisKey = 'tungiasis';
  static const _lymphaticFilariasisStageLymphedemaKey =
      'lymphaticFilariasisStageLymphedema';
  static const _lymphaticFilariasisStageMaleKey =
      'lymphaticFilariasisStageMale';
  static const _tracomaFolicularKey = 'tracomaFolicular';
  static const _tracomaTrichiasisKey = 'tracomaTrichiasis';
  static const _suspectedLeprosyKey = 'suspectedLeprosy';

  @override
  void initState() {
    super.initState();
    _diseaseList = _initializeDiseaseList();

    // Initialize all diseases as unselected
    for (final disease in _diseaseList) {
      _diseaseSelection[disease.key] = false;
    }
  }

  // Map to track selected diseases
  Map<String, bool> _diseaseSelection = {};

  /// Initialize and return the disease list with localization key references
  List<MapEntry<String, String>> _initializeDiseaseList() {
    return [
      MapEntry(_tineaKey, i18_local.morbidityControl.tinea),
      MapEntry(_scabiesKey, i18_local.morbidityControl.scabies),
      MapEntry(_tungiasisKey, i18_local.morbidityControl.tungiasis),
      MapEntry(
        _lymphaticFilariasisStageLymphedemaKey,
        i18_local.morbidityControl.lymphaticFilariasisStageLymphedema,
      ),
      MapEntry(
        _lymphaticFilariasisStageMaleKey,
        i18_local.morbidityControl.lymphaticFilariasisStageMale,
      ),
      MapEntry(
          _tracomaFolicularKey, i18_local.morbidityControl.tracomaFolicular),
      MapEntry(
          _tracomaTrichiasisKey, i18_local.morbidityControl.tracomaTrichiasis),
      MapEntry(
          _suspectedLeprosyKey, i18_local.morbidityControl.suspectedLeprosy),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollableContent(
        header: BackNavigationHelpHeaderWidget(
          handleBack: () => Navigator.pop(context),
          showHelp: false,
          showcaseButton: null,
        ),
        enableFixedButton: true,
        footer: DigitCard(
          margin: const EdgeInsets.fromLTRB(0, kPadding, 0, 0),
          padding: const EdgeInsets.fromLTRB(kPadding, 0, kPadding, 0),
          child: ValueListenableBuilder(
            valueListenable: clickedStatus,
            builder: (context, bool isClicked, _) {
              return DigitElevatedButton(
                onPressed: isClicked
                    ? null
                    : () async {
                        _handleSubmit(context);
                      },
                child: Center(
                  child: Text(
                    localizations.translate(i18.common.coreCommonSubmit),
                  ),
                ),
              );
            },
          ),
        ),
        slivers: [
          SliverToBoxAdapter(
            child: DigitCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    localizations
                        .translate(i18_local.morbidityControl.pageTitle),
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  // Question
                  Text(
                    localizations
                        .translate(i18_local.morbidityControl.questionPrompt),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  // Disease checkboxes list
                  ..._buildDiseaseCheckboxList(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build the list of disease checkboxes
  List<Widget> _buildDiseaseCheckboxList(BuildContext context) {
    return _diseaseList.map((diseaseEntry) {
      final diseaseKey = diseaseEntry.key;
      final localizationKey = diseaseEntry.value;
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: _diseaseSelection[diseaseKey] ?? false,
            onChanged: (bool? selected) {
              setState(() {
                _diseaseSelection[diseaseKey] = selected ?? false;
              });
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Text(
                localizations.translate(localizationKey),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
        ],
      );
    }).toList();
  }

  /// Handle submit button press with disease selection persistence
  void _handleSubmit(BuildContext context) async {
    // Show confirmation dialog before submission
    final shouldSubmit = await DigitDialog.show<bool>(
      context,
      options: DigitDialogOptions(
        titleText: localizations.translate(
          i18.deliverIntervention.dialogTitle,
        ),
        contentText: localizations.translate(
          i18.deliverIntervention.dialogContent,
        ),
        primaryAction: DigitDialogActions(
          label: localizations.translate(
            i18.common.coreCommonSubmit,
          ),
          action: (context) {
            clickedStatus.value = true;
            Navigator.of(
              context,
              rootNavigator: true,
            ).pop(true);
          },
        ),
        secondaryAction: DigitDialogActions(
          label: localizations.translate(
            i18.common.coreCommonCancel,
          ),
          action: (context) => Navigator.of(
            context,
            rootNavigator: true,
          ).pop(false),
        ),
      ),
    );

    if (!context.mounted) return;

    if (shouldSubmit ?? false) {
      // Get selected diseases from the _diseaseSelection map
      final selectedDiseases = _diseaseSelection.entries
          .where((entry) => entry.value)
          .map((entry) => entry.key)
          .toList();

      // Use the delivery task passed from delivery intervention page
      // and add morbidity data to it
      TaskModel? deliveryTask = widget.deliveryTask;

      if (deliveryTask != null) {
        // Add morbidity fields to the existing delivery task
        final existingFields = deliveryTask.additionalFields?.fields ?? [];
        final updatedFields = [
          ...existingFields,
          AdditionalField(
            'selectedDiseases',
            selectedDiseases.join(' | '),
          ),
          AdditionalField(
            'morbidityStatus',
            selectedDiseases.isNotEmpty ? 'Yes' : 'No',
          ),
        ];

        deliveryTask = deliveryTask.copyWith(
          additionalFields: TaskAdditionalFields(
            version: deliveryTask.additionalFields?.version ?? 1,
            fields: updatedFields,
          ),
        );
      } else {
        // Fallback: Create a new task if deliveryTask is not provided
        deliveryTask = TaskModel(
          projectBeneficiaryClientReferenceId:
              widget.projectBeneficiaryClientReferenceId,
          clientReferenceId: IdGen.i.identifier,
          tenantId: envConfig.variables.tenantId,
          rowVersion: 1,
          auditDetails: AuditDetails(
            createdBy: context.loggedInUserUuid,
            createdTime: context.millisecondsSinceEpoch(),
          ),
          projectId: context.projectId,
          clientAuditDetails: ClientAuditDetails(
            createdBy: context.loggedInUserUuid,
            createdTime: context.millisecondsSinceEpoch(),
            lastModifiedBy: context.loggedInUserUuid,
            lastModifiedTime: context.millisecondsSinceEpoch(),
          ),
          additionalFields: TaskAdditionalFields(
            version: 1,
            fields: [
              AdditionalField(
                'selectedDiseases',
                selectedDiseases.join(','),
              ),
              AdditionalField(
                'morbidityStatus',
                selectedDiseases.isNotEmpty ? 'Yes' : 'No',
              ),
            ],
          ),
        );
      }

      // Dispatch the submit event to persist the combined data
      if (context.mounted) {
        context.read<DeliverInterventionBloc>().add(
              DeliverInterventionSubmitEvent(
                task: deliveryTask,
                isEditing: false,
                boundaryModel: context.boundary,
                navigateToSummary: false,
              ),
            );

        // Navigate to next screen after submission
        context.router.push(
          CustomHouseholdAcknowledgementSMCRoute(
            enableViewHousehold: true,
          ),
        );
      }
    }
  }
}
