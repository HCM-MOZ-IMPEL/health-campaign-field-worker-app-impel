import 'package:collection/collection.dart';
import 'package:digit_components/digit_components.dart';
import 'package:digit_components/widgets/atoms/digit_radio_button_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../utils/i18_key_constants.dart' as i18;
import '../../blocs/delivery_intervention/deliver_intervention.dart';
import '../../blocs/household_overview/household_overview.dart';
import '../../blocs/localization/app_localization.dart';
import '../../models/data_model.mapper.g.dart';
import '../../models/entities/additional_fields_type.dart';
import '../../models/entities/status.dart';
import '../../models/entities/task.dart';
import '../../router/app_router.dart';
import '../../utils/utils.dart';
import '../../widgets/header/back_navigation_help_header.dart';
import '../../widgets/localized.dart';

class RecordPastDeliveryDetailsPage extends LocalizedStatefulWidget {
  const RecordPastDeliveryDetailsPage({
    super.key,
    super.appLocalizations,
  });

  @override
  State<RecordPastDeliveryDetailsPage> createState() =>
      _RecordPastDeliveryDetailsPageState();
}

class _RecordPastDeliveryDetailsPageState
    extends LocalizedState<RecordPastDeliveryDetailsPage> {
  static const _recordDoseAdministeredKey = 'recordDoseAdministered';
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context);
    final router = context.router;
    int ischanges = 0;
    bool isbtnClicked = false;

    return Scaffold(
      body: BlocBuilder<DeliverInterventionBloc, DeliverInterventionState>(
        builder: (context, state) {
          print(ischanges);

          return ReactiveFormBuilder(
            form: () => buildForm(context),
            builder: (context, form, child) => ScrollableContent(
              header: const Column(children: [
                BackNavigationHelpHeaderWidget(
                  showHelp: false,
                ),
              ]),
              footer: SizedBox(
                height: 85,
                child: DigitCard(
                  margin: const EdgeInsets.only(top: kPadding),
                  child: DigitElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isbtnClicked = true;
                      });

                      form.markAllAsTouched();

                      if (!form.valid) return;

                      final event = context.read<DeliverInterventionBloc>();

                      // Loop through each future task
                      for (int i = 0;
                          i < (state.futureTask ?? []).length;
                          i++) {
                        // Get the value of the form control for each task

                        final formControllValue = (form
                                .control("$_recordDoseAdministeredKey.$i")
                                .value as KeyValue)
                            .key;

                        // Determine the status based on the form control value
                        final status = formControllValue
                            ? Status.delivered.toValue()
                            : Status.notDelivered.toValue();

                        // Create a new task with the updated status
                        final result =
                            state.futureTask![i].copyWith(status: status);

                        // Add the updated task to the event
                        event.add(DeliverInterventionSubmitEvent(
                          result,
                          true,
                          context.boundary,
                        ));
                      }
                      await DigitDialog.show<bool>(
                        context,
                        options: DigitDialogOptions(
                          titleText: i18.deliverIntervention
                              .didYouObservePreviousAdvEventsTitle,
                          barrierDismissible: true,
                          primaryAction: DigitDialogActions(
                            label: localizations.translate(
                              i18.common.coreCommonNo,
                            ),
                            action: (ctx) {
                              router.pop();
                              final bloc =
                                  context.read<HouseholdOverviewBloc>();

                              bloc.add(HouseholdOverviewReloadEvent(
                                projectId: context.projectId,
                                projectBeneficiaryType: context.beneficiaryType,
                              ));
                              event.add(DeliverInterventionSearchEvent(
                                TaskSearchModel(
                                  projectBeneficiaryClientReferenceId: bloc
                                      .state
                                      .householdMemberWrapper
                                      .projectBeneficiaries
                                      .map((e) => e.clientReferenceId)
                                      .toList(),
                                ),
                              ));
                              Navigator.of(
                                ctx,
                                rootNavigator: true,
                              ).pop();
                              router.push(
                                BeneficiaryDetailsRoute(),
                              );
                            },
                          ),
                          secondaryAction: DigitDialogActions(
                            label: localizations.translate(
                              i18.common.coreCommonYes,
                            ),
                            action: (ctx) {
                              router.pop();
                              Navigator.of(
                                ctx,
                                rootNavigator: true,
                              ).pop();
                              router.push(
                                AdverseEventsRoute(
                                  tasks: [(state.futureTask ?? []).last],
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                    child: Center(
                      child: Text(
                        localizations.translate(i18.common.coreCommonNext),
                      ),
                    ),
                  ),
                ),
              ),
              children: [
                DigitCard(
                  child: Column(
                    children: [
                      Text(
                        localizations.translate(
                          i18.deliverIntervention.recordPastDeliveryDeatils,
                        ),
                        style: theme.textTheme.displayMedium,
                      ),
                      ...(state.futureTask?.asMap().entries.map((entry) {
                            final int doseNumber =
                                int.parse(entry.value.additionalFields!.fields
                                    .firstWhereOrNull(
                                      (ele) =>
                                          ele.key ==
                                          AdditionalFieldsType.doseIndex
                                              .toValue(),
                                    )!
                                    .value);

                            return StatefulBuilder(
                              builder: (context, setState) {
                                return Column(
                                  children: [
                                    DigitRadioButtonList(
                                      labelText: "${localizations.translate(
                                        i18.deliverIntervention
                                            .wasDosePastDeliveryDetails,
                                      )} $doseNumber ${localizations.translate(
                                        i18.deliverIntervention
                                            .wasDosePastRecordDeliveryDetails,
                                      )} ${localizations.translate(
                                        i18.beneficiaryDetails.beneficiaryDose,
                                      )} ${doseNumber - 1} ? *",
                                      labelStyle: theme.textTheme.displayMedium,
                                      formControlName:
                                          "$_recordDoseAdministeredKey.${state.futureTask!.indexOf(entry.value)}",
                                      valueMapper: (val) =>
                                          localizations.translate(val.label),
                                      options: Constants.yesNo,
                                      onValueChange: (val) {
                                        setState(() {
                                          ischanges = ischanges + 1;
                                        });

                                        form
                                            .control(
                                              "$_recordDoseAdministeredKey.${state.futureTask!.indexOf(entry.value)}",
                                            )
                                            .value = val;
                                      },
                                    ),
                                    Offstage(
                                      offstage: !form
                                          .control(
                                            "$_recordDoseAdministeredKey.${state.futureTask!.indexOf(entry.value)}",
                                          )
                                          .invalid,
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          localizations.translate(
                                            i18.common.corecommonRequired,
                                          ),
                                          style: TextStyle(
                                            color: theme.colorScheme.error,
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (entry.key !=
                                        state.futureTask!.length - 1)
                                      const Divider(), // Add Divider conditionally
                                  ],
                                );
                              },
                            );
                          }).toList() ??
                          []),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  FormGroup buildForm(BuildContext context) {
    final bloc = context.read<DeliverInterventionBloc>().state;

    // Create a form group with a FormArray of KeyValue form controls
    return fb.group(
      {
        _recordDoseAdministeredKey: FormArray<KeyValue>([
          ...bloc.futureTask?.map(
                (e) => FormControl<KeyValue>(validators: [Validators.required]),
              ) ??
              [],
        ]),
      },
    );
  }
}
