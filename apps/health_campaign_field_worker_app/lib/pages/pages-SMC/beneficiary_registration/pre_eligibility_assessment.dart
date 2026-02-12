import 'package:digit_components/digit_components.dart';
import 'package:digit_components/widgets/digit_sync_dialog.dart';
import 'package:digit_data_model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:registration_delivery/blocs/delivery_intervention/deliver_intervention.dart';
import 'package:registration_delivery/models/entities/task.dart';

import '../../../router/app_router.dart';
import '../../../utils/environment_config.dart';
import '../../../utils/utils_smc/utils_smc.dart';
import '../../../widgets/header/back_navigation_help_header.dart';
import '../../../widgets/localized.dart';
import '../../../models/entities/status.dart' as status_local;
import 'package:registration_delivery/utils/i18_key_constants.dart' as i18;
import '../../../utils/utils_smc/i18_key_constants.dart' as i18_smc;

@RoutePage()
class PreEligibilityAssessmentPage extends LocalizedStatefulWidget {
  /// The individual/beneficiary whose vaccine information is being captured
  final IndividualModel? individual;
  final String? projectBeneficiaryClientReferenceId;

  const PreEligibilityAssessmentPage({
    super.key,
    super.appLocalizations,
    this.individual,
    this.projectBeneficiaryClientReferenceId,
  });

  @override
  State<PreEligibilityAssessmentPage> createState() =>
      _PreEligibilityAssessmentPageState();
}

class _PreEligibilityAssessmentPageState
    extends LocalizedState<PreEligibilityAssessmentPage> {
  bool medicationRefused = false;
  final clickedStatus = ValueNotifier<bool>(false);
  @override
  void initState() {
    context.read<LocationBloc>().add(const LoadLocationEvent());
    super.initState();
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
                          localizations.translate(i18.common.locationCapturing),
                          DigitSyncDialogType.inProgress,
                        );

                        Future.delayed(const Duration(seconds: 2), () {
                          DigitComponentsUtils().hideDialog(context);
                          submitTask(context, locationState);
                        });
                      }
                    },
                    child: Center(
                      child: Text(
                        localizations.translate(
                          i18.common.coreCommonSubmit,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        slivers: [
          // Pre-Eligibility Assessment Section
          SliverToBoxAdapter(
            child: DigitCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localizations.translate(
                      i18_smc.deliverIntervention.vaccineCardPresentLabel,
                    ),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    localizations.translate(
                      i18.common.coreCommonNo,
                    ),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color:
                              DigitTheme.instance.colorScheme.onSurfaceVariant,
                        ),
                  ),
                  const SizedBox(height: 24),
                  _buildMedicationRefusalQuestion(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicationRefusalQuestion(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: DigitTheme.instance.colorScheme.outlineVariant,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              localizations.translate(
                i18.common.coreCommonNo,
              ),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Radio<bool>(
                        value: true,
                        groupValue: medicationRefused,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              medicationRefused = value;
                            });
                          }
                        },
                      ),
                      Expanded(
                        child: Text(
                          localizations.translate(i18.common.coreCommonYes),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Row(
                    children: [
                      Radio<bool>(
                        value: false,
                        groupValue: medicationRefused,
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              medicationRefused = value;
                            });
                          }
                        },
                      ),
                      Expanded(
                        child: Text(
                          localizations.translate(i18.common.coreCommonNo),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
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
      // If beneficiary refused medication, navigate to next page
      if (medicationRefused) {
        context.router.push(EligibilityChecklistViewRoute(
          projectBeneficiaryClientReferenceId:
              widget.projectBeneficiaryClientReferenceId,
          individual: widget.individual,
        ));
        return;
      }

      // If beneficiary did not refuse, create task and navigate
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
      ));
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
      status: // TODO add correct status here,
          status_local.Status.vaccineStatus.toValue(),
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
            'medicationRefused',
            medicationRefused,
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
        ],
      ),
      address: widget.individual!.address?.first.copyWith(
        relatedClientReferenceId: clientReferenceId,
        id: null,
      ),
    );
  }
}
