import 'package:digit_components/digit_components.dart';
import 'package:digit_components/widgets/digit_sync_dialog.dart';
import 'package:digit_data_model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:registration_delivery/blocs/delivery_intervention/deliver_intervention.dart';
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
  bool vaccineCardPresent = false;
  bool vaccineRefused = false;
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
          ],
        ),
      );
    });
  }

  void submitTask(BuildContext context, LocationState locationState) async {
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

    if (context.mounted && (shouldSubmit ?? false)) {
      // note this will handle both cases of smc and oncho as the flow is same after this point,
      //only difference is in the question asked in the beginning and the vaccines shown for selection in case of smc
      if (!vaccineCardPresent) {
        // Navigate to deliver intervention page when vaccine card is not present (New Flow)
        context.router.push(
          CustomDeliverInterventionSMCRoute(
            interventionType: widget.interventionType,
            isEditing: false,
          ),
        );
        return;

        // TODO: Old flow - commented out for new deliver intervention flow
        // context.router.push(EligibilityChecklistViewRoute(
        //   projectBeneficiaryClientReferenceId:
        //       widget.projectBeneficiaryClientReferenceId,
        //   individual: widget.individual,
        //   interventionType: widget.interventionType,
        // ));
        // return;
      } else {
        // If vaccine card is present, show confirmation dialog and create task

        final task = getTaskModel(locationState);
        context
            .read<DeliverInterventionBloc>()
            .add(DeliverInterventionSubmitEvent(
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
    }
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
