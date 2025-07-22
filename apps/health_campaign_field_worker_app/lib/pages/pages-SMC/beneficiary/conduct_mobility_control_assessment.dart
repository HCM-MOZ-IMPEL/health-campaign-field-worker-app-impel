import 'package:digit_ui_components/widgets/atoms/digit_checkbox.dart';
import 'package:registration_delivery/blocs/household_overview/household_overview.dart';
import 'package:registration_delivery/router/registration_delivery_router.gm.dart';
import 'package:auto_route/auto_route.dart';
import 'package:digit_components/digit_components.dart';
import 'package:digit_components/widgets/atoms/digit_toaster.dart';
import 'package:digit_components/widgets/atoms/text_block.dart';
import 'package:digit_data_model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:registration_delivery/blocs/delivery_intervention/deliver_intervention.dart';
import 'package:registration_delivery/models/entities/additional_fields_type.dart';
import 'package:registration_delivery/models/entities/status.dart';
import 'package:registration_delivery/models/entities/task.dart';
import 'package:registration_delivery/utils/utils.dart';
import 'package:registration_delivery/utils/i18_key_constants.dart' as i18;
import '../../../utils/utils_smc/i18_key_constants.dart' as i18_local;
import 'package:registration_delivery/widgets/back_navigation_help_header.dart';
import '../../../widgets/localized.dart';
import '../../../utils/constants.dart';

@RoutePage()
class ConductMobilityControlAssessmentPage extends LocalizedStatefulWidget {
  const ConductMobilityControlAssessmentPage({
    super.key,
    super.appLocalizations,
  });

  @override
  State<ConductMobilityControlAssessmentPage> createState() =>
      _ConductMobilityControlAssessmentPageState();
}

class _ConductMobilityControlAssessmentPageState
    extends LocalizedState<ConductMobilityControlAssessmentPage> {
  final List<Map<String, String>> controlAssessmentQuestions = [
    {"key": "checkbox1", "value": "checkbox_1"},
    {"key": "checkbox2", "value": "checkbox_2"},
    {"key": "checkbox3", "value": "checkbox_3"},
    {"key": "checkbox4", "value": "checkbox_4"},
    {"key": "checkbox5", "value": "checkbox_5"},
  ];

  final Map<String, bool> checkboxStates = {};

  final clickedStatus = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    for (var item in controlAssessmentQuestions) {
      checkboxStates[item['value']!] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: BlocConsumer<DeliverInterventionBloc, DeliverInterventionState>(
        listener: (context, deliverState) {
          final router = context.router;
        },
        builder: (context, deliverState) {
          return ReactiveFormBuilder(
            form: () => buildForm(),
            builder: (context, form, child) {
              return ScrollableContent(
                header: const Column(children: [
                  BackNavigationHelpHeaderWidget(
                    showHelp: false,
                    showcaseButton: null,
                  ),
                ]),
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
                                if (context.mounted) {
                                  final hasSelection = checkboxStates.values
                                      .any((isSelected) => isSelected);
                                  if (!hasSelection) {
                                    DigitToast.show(
                                      context,
                                      options: DigitToastOptions(
                                        i18_local.deliverIntervention
                                            .noCheckboxSelect,
                                        true,
                                        theme,
                                      ),
                                    );
                                    return;
                                  }

                                  clickedStatus.value = true;

                                  final task = deliverState.oldTask!.copyWith(
                                    status:
                                        Status.administeredSuccess.toValue(),
                                    additionalFields: TaskAdditionalFields(
                                      version: deliverState.oldTask!
                                              .additionalFields?.version ??
                                          1,
                                      fields: [
                                        ...?deliverState
                                            .oldTask!.additionalFields?.fields,
                                        ...checkboxStates.entries
                                            .where(
                                                (entry) => entry.value == true)
                                            .map((entry) => AdditionalField(
                                                  entry.key,
                                                  Constants.trueString,
                                                )),
                                        AdditionalField(
                                          AdditionalFieldsType
                                              .dateOfVerification
                                              .toValue(),
                                          DateTime.now()
                                              .millisecondsSinceEpoch
                                              .toString(),
                                        ),
                                      ],
                                    ),
                                  );

                                  context.read<DeliverInterventionBloc>().add(
                                        DeliverInterventionSubmitEvent(
                                          task: task,
                                          isEditing: (deliverState.tasks ?? [])
                                                      .isNotEmpty &&
                                                  RegistrationDeliverySingleton()
                                                          .beneficiaryType ==
                                                      BeneficiaryType.household
                                              ? true
                                              : false,
                                          boundaryModel:
                                              RegistrationDeliverySingleton()
                                                  .boundary!,
                                        ),
                                      );

                                  final reloadState =
                                      context.read<HouseholdOverviewBloc>();

                                  reloadState.add(
                                    HouseholdOverviewReloadEvent(
                                      projectId: RegistrationDeliverySingleton()
                                          .projectId!,
                                      projectBeneficiaryType:
                                          RegistrationDeliverySingleton()
                                              .beneficiaryType!,
                                    ),
                                  );
                                  context.router.popAndPush(
                                    HouseholdAcknowledgementRoute(
                                      enableViewHousehold: true,
                                    ),
                                  );
                                }
                              },
                        child: Center(
                          child: Text(
                            localizations
                                .translate(i18.common.coreCommonSubmit),
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
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextBlock(
                            padding: const EdgeInsets.only(top: kPadding),
                            heading: localizations.translate(
                              i18_local
                                  .deliverIntervention.mobilityControlLabel,
                            ),
                            headingStyle: theme.textTheme.displayMedium,
                            body: localizations.translate(
                              i18_local
                                  .deliverIntervention.mobilityControlQuestion,
                            ),
                          ),
                          ...controlAssessmentQuestions.map((item) {
                            final checkboxValue = item['value']!;
                            return ListTile(
                              title: Text(
                                checkboxValue,
                                style: theme.textTheme.bodyLarge,
                              ),
                              leading: SizedBox(
                                width: 24,
                                height: 24,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: DigitCheckbox(
                                    value:
                                        checkboxStates[checkboxValue] ?? false,
                                    onChanged: (bool? value) => setState(() =>
                                        checkboxStates[checkboxValue] =
                                            value ?? false),
                                  ),
                                ),
                              ),
                              contentPadding: EdgeInsets.zero,
                              horizontalTitleGap: 8,
                              minLeadingWidth: 24,
                              minVerticalPadding: 0,
                            );
                          }).toList(),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  FormGroup buildForm() {
    return fb.group(<String, Object>{});
  }
}
