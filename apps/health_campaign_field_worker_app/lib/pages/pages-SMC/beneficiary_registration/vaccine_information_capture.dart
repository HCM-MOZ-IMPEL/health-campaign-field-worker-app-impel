import 'package:digit_components/digit_components.dart';
import 'package:digit_components/widgets/atoms/digit_toaster.dart';
import 'package:digit_components/widgets/digit_sync_dialog.dart';
import 'package:digit_data_model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:registration_delivery/blocs/delivery_intervention/deliver_intervention.dart';
import 'package:registration_delivery/blocs/household_overview/household_overview.dart';
import 'package:registration_delivery/blocs/search_households/search_households.dart';
import 'package:registration_delivery/models/entities/task.dart';

import '../../../blocs/app_initialization/app_initialization.dart';
import '../../../data/local_store/no_sql/schema/app_configuration.dart';
import '../../../models/entities/entities_smc/intervention_types.dart';
import '../../../router/app_router.dart';
import '../../../utils/environment_config.dart';
import '../../../utils/utils_smc/utils_smc.dart';
import '../../../widgets/header/back_navigation_help_header.dart';
import '../../../widgets/localized.dart';
import '../../../models/entities/status.dart' as status_local;
import 'package:registration_delivery/utils/i18_key_constants.dart' as i18;
import '../../../utils/utils_smc/i18_key_constants.dart' as i18_smc;
import '../../../models/entities/additional_fields_type.dart'
    as additional_fields_local;

@RoutePage()
class VaccineInformationCapturePage extends LocalizedStatefulWidget {
  /// The individual/beneficiary whose vaccine information is being captured
  final IndividualModel? individual;
  final String? projectBeneficiaryClientReferenceId;
  final InterventionTypes interventionType;

  const VaccineInformationCapturePage({
    super.key,
    super.appLocalizations,
    this.individual,
    this.projectBeneficiaryClientReferenceId,
    required this.interventionType,
  });

  @override
  State<VaccineInformationCapturePage> createState() =>
      _VaccineInformationCapturePageState();
}

class _VaccineInformationCapturePageState
    extends LocalizedState<VaccineInformationCapturePage> {
  List<Vaccine>? vaccineData = [];
  List<VaccineGroup>? vaccineGroupData = [];
  VaccineGroup? applicableVaccineGroup;
  List<Vaccine>? applicableVaccines = [];
  Map<String, bool> vaccineSelection = {};
  bool vaccineCardPresent = true;
  bool vaccineRefused = true;
  String? vaccineRefusalReason;
  final clickedStatus = ValueNotifier<bool>(false);

  @override
  void initState() {
    context.read<LocationBloc>().add(const LoadLocationEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppInitializationBloc, AppInitializationState>(
        builder: (context, initState) {
      initState.maybeWhen(
        initialized: (appConfiguration, _, __) {
          if (widget.interventionType == InterventionTypes.smc) {
            // Use mdmsData to access the loaded MDMS data
            vaccineData = appConfiguration.vaccine;
            vaccineGroupData = appConfiguration.vaccineGroups;

            // Get the applicable vaccine group based on individual's age
            applicableVaccineGroup = getApplicableVaccineGroup(
              widget.individual,
              vaccineGroupData,
            );

            // Get vaccines for the applicable group
            if (applicableVaccineGroup != null) {
              applicableVaccines = getVaccinesForGroup(
                applicableVaccineGroup,
                vaccineData,
              );

              // Initialize vaccine selection map
              for (final vaccine in applicableVaccines!) {
                vaccineSelection.putIfAbsent(vaccine.code ?? '', () => false);
              }
            }
          }
        },
        orElse: () => const Offstage(),
      );

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
                    return BlocBuilder<LocationBloc, LocationState>(
                        builder: (context, locationState) {
                      return DigitElevatedButton(
                        onPressed: () async {
                          context
                              .read<LocationBloc>()
                              .add(const LoadLocationEvent());

                          if (context.mounted && widget.individual != null) {
                            DigitComponentsUtils().showLocationCapturingDialog(
                                context,
                                localizations
                                    .translate(i18.common.locationCapturing),
                                DigitSyncDialogType.inProgress);

                            Future.delayed(const Duration(seconds: 2), () {
                              // After delay, hide the initial dialog
                              DigitComponentsUtils().hideDialog(context);

                              submitTask(context, locationState);
                            });
                          }
                          // create a task
                        },
                        child: Center(
                          child: Text(
                            localizations.translate(
                              i18.common.coreCommonSubmit,
                            ),
                          ),
                        ),
                      );
                    });
                  })),
          slivers: [
            // Vaccine Card Present Question Section
            SliverToBoxAdapter(
              child: DigitCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.interventionType == InterventionTypes.smc
                      ? [
                          Text(
                            localizations.translate(i18_smc
                                .deliverIntervention.vaccineCardPresentLabel),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Radio<bool>(
                                        value: true,
                                        groupValue: vaccineCardPresent,
                                        onChanged: (value) {
                                          if (value != null) {
                                            setState(() {
                                              vaccineCardPresent = value;
                                            });
                                          }
                                        },
                                      ),
                                      Text(
                                        localizations.translate(
                                            i18.common.coreCommonYes),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 24),
                                  Row(
                                    children: [
                                      Radio<bool>(
                                        value: false,
                                        groupValue: vaccineCardPresent,
                                        onChanged: (value) {
                                          if (value != null) {
                                            setState(() {
                                              vaccineCardPresent = value;
                                            });
                                          }
                                        },
                                      ),
                                      Text(
                                        localizations
                                            .translate(i18.common.coreCommonNo),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ]
                      : [
                          Text(
                            localizations.translate(i18_smc.deliverIntervention
                                .didBeneficiaryRefuseVaccineLabel),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Radio<bool>(
                                        value: true,
                                        groupValue: vaccineRefused,
                                        onChanged: (value) {
                                          if (value != null) {
                                            setState(() {
                                              vaccineRefused = value;
                                            });
                                          }
                                        },
                                      ),
                                      Text(
                                        localizations.translate(
                                            i18.common.coreCommonYes),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 24),
                                  Row(
                                    children: [
                                      Radio<bool>(
                                        value: false,
                                        groupValue: vaccineRefused,
                                        onChanged: (value) {
                                          if (value != null) {
                                            setState(() {
                                              vaccineRefused = value;
                                            });
                                          }
                                        },
                                      ),
                                      Text(
                                        localizations
                                            .translate(i18.common.coreCommonNo),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                ),
              ),
            ),
            // Show vaccine groups and list only if card is present
            if (vaccineCardPresent &&
                InterventionTypes.smc == widget.interventionType)
              SliverToBoxAdapter(
                child: DigitCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Applicable Vaccine Group Section
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: DigitCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                localizations.translate(i18_smc
                                    .deliverIntervention.vaccineGroupLabel),
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 12),
                              Container(
                                padding: const EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                  color:
                                      DigitTheme.instance.colorScheme.surface,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      getVaccineAgeGroupLabel(
                                        applicableVaccineGroup,
                                      ),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Vaccines List Section
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: DigitCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                localizations.translate(i18_smc
                                    .deliverIntervention
                                    .vaccinesToAdministerLabel),
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 16),
                              ..._buildVaccineList(context),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            // Show vaccine refusal reason only if vaccine is refused
            if (vaccineRefused &&
                widget.interventionType == InterventionTypes.oncho)
              SliverToBoxAdapter(
                child: DigitCard(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          localizations.translate(
                            i18_smc
                                .deliverIntervention.vaccineRefusalReasonLabel,
                          ),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 16),
                        DigitCard(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                BlocBuilder<AppInitializationBloc,
                                        AppInitializationState>(
                                    builder: (context, state) {
                                  if (state is! AppInitialized) {
                                    return const Offstage();
                                  }

                                  final vaccineRefusalReasonsLoaded = state
                                          .appConfiguration
                                          .vaccineRefusalReasons ??
                                      <RefusalReasons>[];
                                  return Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: DigitTheme.instance.colorScheme
                                            .outlineVariant,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      value: vaccineRefusalReason,
                                      underline: const SizedBox.shrink(),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0,
                                        vertical: 8.0,
                                      ),
                                      items: vaccineRefusalReasonsLoaded
                                          .map((reason) =>
                                              DropdownMenuItem<String>(
                                                value: reason.code,
                                                child: Text(reason.name ?? ''),
                                              ))
                                          .toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          vaccineRefusalReason = value;
                                        });
                                      },
                                    ),
                                  );
                                })
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }

  void submitTask(BuildContext context, LocationState locationState) async {
    final shouldSubmit = await DigitDialog.show<bool>(
      context,
      options: DigitDialogOptions(
        titleText: localizations.translate(i18.deliverIntervention.dialogTitle),
        contentText:
            localizations.translate(i18.deliverIntervention.dialogContent),
        primaryAction: DigitDialogActions(
          label: localizations.translate(i18.common.coreCommonSubmit),
          action: (context) {
            clickedStatus.value = true;
            Navigator.of(context, rootNavigator: true).pop(true);
          },
        ),
        secondaryAction: DigitDialogActions(
          label: localizations.translate(i18.common.coreCommonCancel),
          action: (context) =>
              Navigator.of(context, rootNavigator: true).pop(false),
        ),
      ),
    );

    if (!context.mounted || !(shouldSubmit ?? false)) return;

    if (widget.interventionType == InterventionTypes.oncho) {
      _handleOnchoFlow(context, locationState);
    } else if (widget.interventionType == InterventionTypes.smc) {
      _handleSmcFlow(context, locationState);
    }
  }

  void _handleOnchoFlow(
      BuildContext context, LocationState locationState) async {
    final theme = Theme.of(context);
    if (vaccineRefused && (vaccineRefusalReason ?? '').isEmpty) {
      await DigitToast.show(
        context,
        options: DigitToastOptions(
          localizations.translate(
            i18_smc.deliverIntervention.refusalReasonEmpty,
          ),
          true,
          theme,
        ),
      );

      return;
    }

    if (!vaccineRefused) {
      context.router.push(EligibilityChecklistViewRoute(
        projectBeneficiaryClientReferenceId:
            widget.projectBeneficiaryClientReferenceId,
        individual: widget.individual,
        interventionType: widget.interventionType,
      ));
      return;
    }

    final refusedTask = getRefusedTaskModel(locationState);
    context.read<DeliverInterventionBloc>().add(DeliverInterventionSubmitEvent(
          task: refusedTask,
          isEditing: false,
          boundaryModel: context.boundary,
          navigateToSummary: false,
        ));

    context
        .read<SearchHouseholdsBloc>()
        .add(const SearchHouseholdsClearEvent());

    Future.delayed(const Duration(milliseconds: 1000), () {
      context.read<HouseholdOverviewBloc>().add(HouseholdOverviewReloadEvent(
            projectId: context.projectId,
            projectBeneficiaryType: context.beneficiaryType,
          ));
    }).then((_) => context.router.popAndPush(
          CustomHouseholdAcknowledgementSMCRoute(enableViewHousehold: true),
        ));
  }

  void _handleSmcFlow(BuildContext context, LocationState locationState) {
    if (!vaccineCardPresent) {
      context.router.push(EligibilityChecklistViewRoute(
        projectBeneficiaryClientReferenceId:
            widget.projectBeneficiaryClientReferenceId,
        individual: widget.individual,
        interventionType: widget.interventionType,
      ));
      return;
    }

    final task = getTaskModel(locationState);
    context.read<DeliverInterventionBloc>().add(DeliverInterventionSubmitEvent(
          task: task,
          isEditing: false,
          boundaryModel: context.boundary,
          navigateToSummary: false,
        ));

    context.router.push(EligibilityChecklistViewRoute(
      projectBeneficiaryClientReferenceId:
          widget.projectBeneficiaryClientReferenceId,
      individual: widget.individual,
      interventionType: widget.interventionType,
    ));
  }

  TaskModel getRefusedTaskModel(LocationState locationState) {
    final clientReferenceId = IdGen.i.identifier;
    final lat = locationState.latitude;
    final long = locationState.longitude;

    return TaskModel(
      projectBeneficiaryClientReferenceId:
          widget.projectBeneficiaryClientReferenceId,
      clientReferenceId: clientReferenceId,
      tenantId: envConfig.variables.tenantId,
      rowVersion: 1,
      auditDetails: AuditDetails(
        createdBy: context.loggedInUserUuid,
        createdTime: context.millisecondsSinceEpoch(),
      ),
      projectId: context.projectId,
      status: status_local.Status.beneficiaryRefused.toValue(),
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
            'taskStatus',
            status_local.Status.beneficiaryRefused.toValue(),
          ),
          if (lat != null)
            AdditionalField(
              'latitude',
              lat,
            ),
          if (long != null)
            AdditionalField(
              'longitude',
              long,
            ),
          if (widget.interventionType == InterventionTypes.oncho)
            AdditionalField(
              additional_fields_local.AdditionalFieldsType.interventionType
                  .toValue(),
              InterventionTypes.oncho.toValue(),
            ),
          if (vaccineRefused && vaccineRefusalReason != null)
            AdditionalField(
              'vaccineRefusalReason',
              vaccineRefusalReason,
            ),
        ],
      ),
      address: widget.individual!.address?.first.copyWith(
        relatedClientReferenceId: clientReferenceId,
        id: null,
      ),
    );
  }

  TaskModel getTaskModel(LocationState locationState) {
    final clientReferenceId = IdGen.i.identifier;
    final lat = locationState.latitude;
    final long = locationState.longitude;

    return TaskModel(
      projectBeneficiaryClientReferenceId:
          widget.projectBeneficiaryClientReferenceId,
      clientReferenceId: clientReferenceId,
      tenantId: envConfig.variables.tenantId,
      rowVersion: 1,
      auditDetails: AuditDetails(
        createdBy: context.loggedInUserUuid,
        createdTime: context.millisecondsSinceEpoch(),
      ),
      projectId: context.projectId,
      status: status_local.Status.vaccineStatus.toValue(),
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
            'taskStatus',
            status_local.Status.vaccineStatus.toValue(),
          ),
          AdditionalField(
            additional_fields_local.AdditionalFieldsType.interventionType
                .toValue(),
            InterventionTypes.smc.toValue(),
          ),
          if (lat != null)
            AdditionalField(
              'latitude',
              lat,
            ),
          if (long != null)
            AdditionalField(
              'longitude',
              long,
            ),
          // Add selected vaccines as additional fields
          ...vaccineSelection.entries
              .where((entry) => entry.value) // Only include selected vaccines
              .map((entry) => AdditionalField(
                    'vaccine_${entry.key}',
                    entry.value,
                  )),
        ],
      ),
      address: widget.individual!.address?.first.copyWith(
        relatedClientReferenceId: clientReferenceId,
        id: null,
      ),
    );
  }

  /// Build the list of vaccines with checkboxes for selection
  List<Widget> _buildVaccineList(BuildContext context) {
    if (applicableVaccines == null || applicableVaccines!.isEmpty) {
      return [const SizedBox.shrink()];
    }

    return applicableVaccines!.map((vaccine) {
      final vaccineCode = vaccine.code ?? '';
      final vaccineName = vaccine.name ?? 'Unknown Vaccine';

      return Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: DigitTheme.instance.colorScheme.outlineVariant,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: CheckboxListTile(
            title: Text(vaccineName),
            value: vaccineSelection[vaccineCode] ?? false,
            onChanged: (bool? selected) {
              setState(() {
                vaccineSelection[vaccineCode] = selected ?? false;
              });
            },
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 4.0,
              vertical: 2.0,
            ),
          ),
        ),
      );
    }).toList();
  }
}
