import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:digit_components/widgets/digit_text_field.dart';
import 'package:digit_data_model/data_model.dart';
import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/models/RadioButtonModel.dart';
import 'package:digit_ui_components/services/location_bloc.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/utils/date_utils.dart';
import 'package:digit_ui_components/widgets/atoms/pop_up_card.dart';
import 'package:digit_ui_components/widgets/atoms/selection_card.dart';
import 'package:digit_ui_components/widgets/molecules/digit_card.dart';
import 'package:digit_ui_components/widgets/molecules/show_pop_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_campaign_field_worker_app/models/entities/roles_type.dart';
import 'package:registration_delivery/blocs/delivery_intervention/deliver_intervention.dart';
import 'package:registration_delivery/blocs/household_overview/household_overview.dart';
import 'package:registration_delivery/blocs/search_households/search_households.dart';
import 'package:registration_delivery/models/entities/task.dart';
import 'package:registration_delivery/router/registration_delivery_router.gm.dart';
import 'package:survey_form/survey_form.dart';
import 'package:survey_form/utils/constants.dart' as survey_constants;

import 'package:survey_form/utils/i18_key_constants.dart' as i18;
import '../../../main.dart';
import '../../../models/entities/entities_smc/intervention_types.dart';
import '../../../models/entities/project_types.dart';
import '../../../router/app_router.dart';

import '../../../utils/environment_config.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_pop_route.dart';
import '../../../utils/utils_smc/i18_key_constants.dart' as i18_local;
import 'package:survey_form/widgets/back_navigation_help_header.dart';
import '../../../widgets/localized.dart';
import '../../../utils/utils_smc/utils_smc.dart'
    show getIndividualAdditionalFields;

import '../../../models/entities/status.dart' as status_local;
import '../../../models/entities/additional_fields_type.dart'
    as additional_fields_local;

@RoutePage()
class EligibilityChecklistViewPage extends LocalizedStatefulWidget {
  final String? referralClientRefId;
  final IndividualModel? individual;
  final String? projectBeneficiaryClientReferenceId;
  final InterventionTypes interventionType;

  const EligibilityChecklistViewPage({
    super.key,
    this.referralClientRefId,
    this.individual,
    this.projectBeneficiaryClientReferenceId,
    required this.interventionType,
    super.appLocalizations,
  });

  @override
  State<EligibilityChecklistViewPage> createState() =>
      _EligibilityChecklistViewPage();
}

class _EligibilityChecklistViewPage
    extends LocalizedState<EligibilityChecklistViewPage> {
  String isStateChanged = '';
  var submitTriggered = false;
  bool triggerLocalization = false;
  List<TextEditingController> controller = [];
  List<TextEditingController> additionalController = [];
  List<AttributesModel>? initialAttributes;
  ServiceDefinitionModel? selectedServiceDefinition;
  bool isControllersInitialized = false;
  List<int> visibleSurveyFormIndexes = [];
  GlobalKey<FormState> surveyFormKey = GlobalKey<FormState>();
  String othersText = "OTHERS";
  final String yes = "YES";
  String multiSelectionSeparator = ".";
  Map<String?, String> responses = {};

  List<int> visibleChecklistIndexes = [];
  GlobalKey<FormState> checklistFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    context.read<ServiceBloc>().add(
          ServiceSurveyFormEvent(
            value: Random().nextInt(100).toString(),
            submitTriggered: true,
          ),
        );
    context.read<LocationBloc>().add(const LocationEvent.load());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);

    var ifReferral = false;
    var ifDeliver = false;
    var ifIneligible = false;
    var ifAdministration = false;

    bool isHealthFacilityWorker = context.loggedInUserRoles
        .where((role) => role.code == RolesType.healthFacilityWorker.toValue())
        .toList()
        .isNotEmpty;

    var projectBeneficiaryClientReferenceId =
        widget.projectBeneficiaryClientReferenceId;

    return WillPopScope(
      onWillPop: () async => _onBackPressed(context),
      child: GlobalBackHandler(
        child: Scaffold(
          body: BlocBuilder<HouseholdOverviewBloc, HouseholdOverviewState>(
              builder: (context, householdOverviewState) {
            return BlocBuilder<ServiceDefinitionBloc, ServiceDefinitionState>(
              builder: (context, state) {
                state.mapOrNull(
                  serviceDefinitionFetch: (value) {
                    selectedServiceDefinition =
                        serviceDefinitionBasedOnProjectType(
                            value.serviceDefinitionList);

                    initialAttributes = selectedServiceDefinition?.attributes;
                    if (!isControllersInitialized) {
                      initialAttributes?.forEach((e) {
                        controller.add(TextEditingController());
                        additionalController.add(TextEditingController());
                      });

                      // Set the flag to true after initializing controllers
                      isControllersInitialized = true;
                    }
                  },
                );
                return state.maybeMap(
                  orElse: () => Text(state.runtimeType.toString()),
                  serviceDefinitionFetch: (value) {
                    return BlocBuilder<LocationBloc, LocationState>(
                      builder: (context, locationState) {
                        return ScrollableContent(
                          header: const BackNavigationHelpHeaderWidget(),
                          enableFixedDigitButton: true,
                          footer: DigitCard(
                              cardType: CardType.primary,
                              margin: const EdgeInsets.only(top: spacer2),
                              children: [
                                DigitButton(
                                  label: localizations
                                      .translate(i18.common.coreCommonSubmit),
                                  type: DigitButtonType.primary,
                                  size: DigitButtonSize.large,
                                  mainAxisSize: MainAxisSize.max,
                                  onPressed: () async {
                                    final router = context.router;
                                    submitTriggered = true;

                                    context.read<ServiceBloc>().add(
                                          const ServiceSurveyFormEvent(
                                            value: '',
                                            submitTriggered: true,
                                          ),
                                        );
                                    final isValid =
                                        surveyFormKey.currentState?.validate();
                                    if (!isValid!) {
                                      return;
                                    }

                                    final itemsAttributes = initialAttributes;

                                    for (int i = 0;
                                        i < controller.length;
                                        i++) {
                                      if (itemsAttributes?[i].required ==
                                              true &&
                                          visibleSurveyFormIndexes
                                              .any((e) => e == i) &&
                                          controller[i].text == '') {
                                        return;
                                      }
                                    }

                                    for (int i = 0;
                                        i < controller.length;
                                        i++) {
                                      initialAttributes;
                                      var attributeCode =
                                          '${initialAttributes?[i].code}';
                                      var value = initialAttributes?[i]
                                                  .dataType !=
                                              'SingleValueList'
                                          ? controller[i]
                                                  .text
                                                  .toString()
                                                  .trim()
                                                  .isNotEmpty
                                              ? controller[i].text.toString()
                                              : (initialAttributes?[i]
                                                          .dataType !=
                                                      'Number'
                                                  ? ''
                                                  : '0')
                                          : visibleSurveyFormIndexes.contains(i)
                                              ? controller[i].text.toString()
                                              : i18_local
                                                  .checklist.notSelectedKey;
                                      responses[attributeCode] = value;
                                    }

                                    double? latitude = locationState.latitude;
                                    double? longitude = locationState.longitude;
                                    String? boundaryCode =
                                        SurveyFormSingleton().boundary?.code;

                                    List<String>? referralReasons = [];
                                    List<String?> ineligibilityReasons = [];
                                    List<bool> checkIfIneligibleFlow = [];

                                    ifReferral =
                                        isReferral(responses, referralReasons);
                                    ifDeliver = isDelivery(responses);
                                    checkIfIneligibleFlow = widget
                                                .interventionType ==
                                            InterventionTypes.smc
                                        ? isIneligible(
                                            responses,
                                            ineligibilityReasons,
                                            ifAdministration,
                                          )
                                        : isIneligibleOncho(
                                            responses, ineligibilityReasons);
                                    if (checkIfIneligibleFlow.isNotEmpty &&
                                        checkIfIneligibleFlow.length >= 2) {
                                      ifIneligible = checkIfIneligibleFlow[0];
                                      ifAdministration =
                                          checkIfIneligibleFlow[1];
                                    }

                                    var descriptionText = ifIneligible
                                        ? localizations.translate(
                                            i18_local.deliverIntervention
                                                .beneficiaryIneligibleDescription,
                                          )
                                        : ifReferral &&
                                                widget.interventionType ==
                                                    InterventionTypes.smc
                                            ? localizations.translate(
                                                i18_local.deliverIntervention
                                                    .beneficiaryReferralDescription,
                                              )
                                            : localizations.translate(
                                                i18_local.deliverIntervention
                                                    .spaqRedirectionScreenDescription,
                                              );

                                    final shouldSubmit = await showCustomPopup(
                                        context: context,
                                        builder: (popUpContext) => Popup(
                                                type: PopUpType.simple,
                                                title: localizations.translate(
                                                  i18_local.checklist
                                                      .submitButtonDialogLabelText,
                                                ),
                                                description: localizations
                                                    .translate(
                                                      i18_local.checklist
                                                          .checklistDialogDynamicDescription,
                                                    )
                                                    .replaceFirst(
                                                        '{}', descriptionText),
                                                actions: [
                                                  DigitButton(
                                                      label: localizations
                                                          .translate(
                                                        i18.surveyForm
                                                            .surveyFormDialogPrimaryAction,
                                                      ),
                                                      onPressed: () {
                                                        List<ServiceAttributesModel>
                                                            attributes = [];
                                                        var referenceId =
                                                            IdGen.i.identifier;
                                                        for (int i = 0;
                                                            i <
                                                                controller
                                                                    .length;
                                                            i++) {
                                                          final attribute =
                                                              initialAttributes;
                                                          String? additionalDetailValue = ((attribute?[
                                                                              i]
                                                                          .values
                                                                          ?.firstWhereOrNull(
                                                                            (element) =>
                                                                                element.toUpperCase() ==
                                                                                othersText,
                                                                          ) !=
                                                                      null &&
                                                                  controller[i]
                                                                          .text
                                                                          .split(
                                                                            multiSelectionSeparator,
                                                                          )
                                                                          .firstWhereOrNull(
                                                                            (element) =>
                                                                                element.toUpperCase() ==
                                                                                othersText,
                                                                          ) !=
                                                                      null))
                                                              ? additionalController[
                                                                          i]
                                                                      .text
                                                                      .toString()
                                                                      .isEmpty
                                                                  ? null
                                                                  : additionalController[
                                                                          i]
                                                                      .text
                                                                      .toString()
                                                              : null;
                                                          attributes.add(
                                                              ServiceAttributesModel(
                                                            attributeCode:
                                                                '${attribute?[i].code}',
                                                            dataType:
                                                                attribute?[i]
                                                                    .dataType,
                                                            clientReferenceId:
                                                                IdGen.i
                                                                    .identifier,
                                                            referenceId:
                                                                referenceId,
                                                            serviceClientReferenceId:
                                                                referenceId,

                                                            // todo verify this , this top level check works for single and multi value list only
                                                            value: visibleSurveyFormIndexes
                                                                    .contains(i)
                                                                ? (attribute?[i]
                                                                            .dataType ==
                                                                        'MultiValueList'
                                                                    ? controller[i]
                                                                            .text
                                                                            .toString()
                                                                            .isNotEmpty
                                                                        ? controller[i]
                                                                            .text
                                                                            .toString()
                                                                            .substring(
                                                                                1)
                                                                        : i18
                                                                            .surveyForm
                                                                            .notSelectedKey
                                                                    : attribute?[i].dataType !=
                                                                            'SingleValueList'
                                                                        ? controller[i]
                                                                                .text
                                                                                .toString()
                                                                                .trim()
                                                                                .isNotEmpty
                                                                            ? controller[i]
                                                                                .text
                                                                                .toString()
                                                                            : (attribute?[i].dataType != 'Number'
                                                                                ? i18
                                                                                    .surveyForm.notSelectedKey
                                                                                : '0')
                                                                        : visibleSurveyFormIndexes.contains(
                                                                                i)
                                                                            ? controller[i]
                                                                                .text
                                                                                .toString()
                                                                            : i18
                                                                                .surveyForm.notSelectedKey)
                                                                : i18.surveyForm
                                                                    .notSelectedKey,
                                                            rowVersion: 1,
                                                            additionalDetails:
                                                                additionalDetailValue,
                                                            additionalFields:
                                                                additionalDetailValue !=
                                                                        null
                                                                    ? ServiceAttributesAdditionalFields(
                                                                        version:
                                                                            1,
                                                                        fields: [
                                                                            AdditionalField('additionalValue',
                                                                                additionalDetailValue)
                                                                          ])
                                                                    : null,
                                                            tenantId:
                                                                attribute?[i]
                                                                    .tenantId,
                                                          ));
                                                        }

                                                        context
                                                            .read<ServiceBloc>()
                                                            .add(
                                                              ServiceCreateEvent(
                                                                serviceModel:
                                                                    ServiceModel(
                                                                        createdAt:
                                                                            DigitDateUtils
                                                                                .getDateFromTimestamp(
                                                                          DateTime.now()
                                                                              .toLocal()
                                                                              .millisecondsSinceEpoch,
                                                                          dateFormat: survey_constants
                                                                              .Constants
                                                                              .SurveyFormViewDateFormat,
                                                                        ),
                                                                        tenantId:
                                                                            selectedServiceDefinition!
                                                                                .tenantId,
                                                                        clientId:
                                                                            referenceId,
                                                                        referenceId:
                                                                            referenceId,
                                                                        serviceDefId:
                                                                            selectedServiceDefinition
                                                                                ?.id,
                                                                        attributes:
                                                                            attributes,
                                                                        rowVersion:
                                                                            1,
                                                                        accountId:
                                                                            SurveyFormSingleton()
                                                                                .projectId,
                                                                        auditDetails:
                                                                            AuditDetails(
                                                                          createdBy:
                                                                              SurveyFormSingleton().loggedInUserUuid,
                                                                          createdTime:
                                                                              DateTime.now().millisecondsSinceEpoch,
                                                                        ),
                                                                        clientAuditDetails:
                                                                            ClientAuditDetails(
                                                                          createdBy:
                                                                              SurveyFormSingleton().loggedInUserUuid,
                                                                          createdTime:
                                                                              context.millisecondsSinceEpoch(),
                                                                          lastModifiedBy:
                                                                              SurveyFormSingleton().loggedInUserUuid,
                                                                          lastModifiedTime:
                                                                              context.millisecondsSinceEpoch(),
                                                                        ),
                                                                        additionalFields: ServiceAdditionalFields(
                                                                            version:
                                                                                1,
                                                                            fields: [
                                                                              if (longitude != null)
                                                                                AdditionalField('lng', longitude),
                                                                              if (latitude != null)
                                                                                AdditionalField('lat', latitude),
                                                                              if (boundaryCode != null)
                                                                                AdditionalField('boundaryCode', boundaryCode)
                                                                            ])),
                                                              ),
                                                            );
                                                        Navigator.of(
                                                          context,
                                                          rootNavigator: true,
                                                        ).pop(true);
                                                      },
                                                      type: DigitButtonType
                                                          .primary,
                                                      size: DigitButtonSize
                                                          .large),
                                                  DigitButton(
                                                      label: localizations
                                                          .translate(
                                                        i18.surveyForm
                                                            .surveyFormDialogSecondaryAction,
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(
                                                          context,
                                                          rootNavigator: true,
                                                        ).pop(false);
                                                      },
                                                      type: DigitButtonType
                                                          .secondary,
                                                      size:
                                                          DigitButtonSize.large)
                                                ])) as bool?;

                                    if (shouldSubmit ?? false) {
                                      if (context.mounted &&
                                          ((ifDeliver || ifAdministration) ||
                                              ifIneligible ||
                                              ifReferral)) {
                                        if (ifIneligible) {
                                          // added the deliversubmitevent here
                                          final clientReferenceId =
                                              IdGen.i.identifier;
                                          final task = TaskModel(
                                            projectBeneficiaryClientReferenceId:
                                                projectBeneficiaryClientReferenceId,
                                            clientReferenceId:
                                                clientReferenceId,
                                            tenantId:
                                                envConfig.variables.tenantId,
                                            rowVersion: 1,
                                            auditDetails: AuditDetails(
                                              createdBy:
                                                  context.loggedInUserUuid,
                                              createdTime: context
                                                  .millisecondsSinceEpoch(),
                                            ),
                                            projectId: context.projectId,
                                            status: status_local
                                                .Status.beneficiaryInEligible
                                                .toValue(),
                                            clientAuditDetails:
                                                ClientAuditDetails(
                                              createdBy:
                                                  context.loggedInUserUuid,
                                              createdTime: context
                                                  .millisecondsSinceEpoch(),
                                              lastModifiedBy:
                                                  context.loggedInUserUuid,
                                              lastModifiedTime: context
                                                  .millisecondsSinceEpoch(),
                                            ),
                                            additionalFields:
                                                TaskAdditionalFields(
                                              version: 1,
                                              fields: [
                                                AdditionalField(
                                                  'taskStatus',
                                                  status_local.Status
                                                      .beneficiaryInEligible
                                                      .toValue(),
                                                ),
                                                AdditionalField(
                                                  'ineligibleReasons',
                                                  ineligibilityReasons
                                                      .join(","),
                                                ),
                                                ...getIndividualAdditionalFields(
                                                  widget.individual,
                                                  householdOverviewState
                                                      .householdMemberWrapper,
                                                ),
                                                if (longitude != null)
                                                  AdditionalField(
                                                      'lng', longitude),
                                                if (latitude != null)
                                                  AdditionalField(
                                                      'lat', latitude),
                                                if (boundaryCode != null)
                                                  AdditionalField(
                                                      'boundaryCode',
                                                      boundaryCode),
                                                if (widget.interventionType !=
                                                    null)
                                                  AdditionalField(
                                                    additional_fields_local
                                                        .AdditionalFieldsType
                                                        .interventionType
                                                        .toValue(),
                                                    widget.interventionType
                                                        .toValue(),
                                                  ),
                                              ],
                                            ),
                                            address: widget
                                                .individual!.address?.first
                                                .copyWith(
                                              relatedClientReferenceId:
                                                  clientReferenceId,
                                              id: null,
                                            ),
                                          );
                                          context
                                              .read<DeliverInterventionBloc>()
                                              .add(
                                                DeliverInterventionSubmitEvent(
                                                    task: task,
                                                    isEditing: false,
                                                    boundaryModel:
                                                        context.boundary,
                                                    navigateToSummary: false,
                                                    householdMemberWrapper:
                                                        householdOverviewState
                                                            .householdMemberWrapper),
                                              );
                                          final searchBloc = context
                                              .read<SearchHouseholdsBloc>();
                                          searchBloc.add(
                                            const SearchHouseholdsClearEvent(),
                                          );

                                          router.push(
                                            CustomHouseholdAcknowledgementSMCRoute(
                                                enableViewHousehold: true),
                                          );
                                        } else if (ifReferral &&
                                            widget.interventionType ==
                                                InterventionTypes.smc) {
                                          router.push(
                                            CustomReferBeneficiarySMCRoute(
                                              projectBeneficiaryClientRefId:
                                                  projectBeneficiaryClientReferenceId ??
                                                      "",
                                              individual: widget.individual!,
                                              referralReasons: referralReasons,
                                            ),
                                          );
                                        } else {
                                          router
                                              .push(BeneficiaryDetailsRoute());
                                        }
                                      }
                                    }
                                  },
                                ),
                              ]),
                          children: [
                            Form(
                              key: surveyFormKey, //assigning key to form
                              child: DigitCard(
                                  cardType: CardType.primary,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: spacer2),
                                      child: Text(
                                        '${localizations.translate(
                                          selectedServiceDefinition!.code
                                              .toString(),
                                        )} ${localizations.translate(i18.surveyForm.surveyForm)}',
                                        style: textTheme.headingXl,
                                      ),
                                    ),
                                    ...initialAttributes!
                                        .where((att) => att.isActive == true)
                                        .map((
                                      e,
                                    ) {
                                      String? description = e
                                          .additionalFields?.fields
                                          .where((a) => a.key == 'helpText')
                                          .firstOrNull
                                          ?.value;
                                      int index =
                                          (initialAttributes ?? []).indexOf(e);
                                      return Column(children: [
                                        if (e.dataType == 'String' &&
                                            !(e.code ?? '').contains('.')) ...[
                                          FormField<String>(
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              validator: (value) {
                                                if (((controller[index].text ==
                                                            null ||
                                                        controller[index]
                                                                .text ==
                                                            '') &&
                                                    e.required == true)) {
                                                  return localizations
                                                      .translate(i18.common
                                                          .corecommonRequired);
                                                }
                                                if (e.regex != null) {
                                                  return (RegExp(e.regex!)
                                                          .hasMatch(
                                                              controller[index]
                                                                  .text!))
                                                      ? null
                                                      : localizations.translate(
                                                          "${e.code}_REGEX");
                                                }

                                                return null;
                                              },
                                              builder: (field) {
                                                return LabeledField(
                                                    label:
                                                        localizations.translate(
                                                      '${selectedServiceDefinition?.code}.${e.code}',
                                                    ),
                                                    capitalizedFirstLetter:
                                                        false,
                                                    charCondition: true,
                                                    description:
                                                        description != null
                                                            ? localizations
                                                                .translate(
                                                                '${selectedServiceDefinition?.code}.$description',
                                                              )
                                                            : null,
                                                    isRequired:
                                                        e.required ?? false,
                                                    child: DigitTextFormInput(
                                                      onChange: (value) {
                                                        field.didChange(value);
                                                        controller[index].text =
                                                            value;
                                                        // surveyFormKey.currentState
                                                        //     ?.validate();
                                                      },
                                                      errorMessage:
                                                          field.errorText,
                                                      controller:
                                                          controller[index],
                                                      inputFormatters: [
                                                        FilteringTextInputFormatter
                                                            .allow(RegExp(
                                                          "[a-zA-Z0-9 ]",
                                                        )),
                                                      ],
                                                    ));
                                              }),
                                        ] else if (e.dataType == 'Number' &&
                                            !(e.code ?? '').contains('.')) ...[
                                          FormField<String>(
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              validator: (value) {
                                                if (((controller[index].text ==
                                                            null ||
                                                        controller[index]
                                                                .text ==
                                                            '') &&
                                                    e.required == true)) {
                                                  return localizations
                                                      .translate(
                                                    i18.common
                                                        .corecommonRequired,
                                                  );
                                                }
                                                if (e.regex != null) {
                                                  return (RegExp(e.regex!)
                                                          .hasMatch(
                                                              controller[index]
                                                                  .text!))
                                                      ? null
                                                      : localizations.translate(
                                                          "${e.code}_REGEX");
                                                }

                                                return null;
                                              },
                                              builder: (field) {
                                                return LabeledField(
                                                  label: localizations
                                                      .translate(
                                                        '${selectedServiceDefinition?.code}.${e.code}',
                                                      )
                                                      .trim(),
                                                  description: description !=
                                                          null
                                                      ? localizations.translate(
                                                          '${selectedServiceDefinition?.code}.$description',
                                                        )
                                                      : null,
                                                  isRequired:
                                                      e.required ?? false,
                                                  capitalizedFirstLetter: false,
                                                  charCondition: true,
                                                  child: DigitTextFormInput(
                                                    onChange: (value) {
                                                      field.didChange(value);
                                                      controller[index].text =
                                                          value;
                                                      // surveyFormKey.currentState
                                                      //     ?.validate();
                                                    },
                                                    errorMessage:
                                                        field.errorText,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .allow(RegExp(
                                                        "[0-9]",
                                                      )),
                                                    ],
                                                    controller:
                                                        controller[index],
                                                  ),
                                                );
                                              }),
                                        ] else if (e.dataType ==
                                                'MultiValueList' &&
                                            !(e.code ?? '').contains('.')) ...[
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    '${localizations.translate(
                                                      '${selectedServiceDefinition?.code}.${e.code}',
                                                    )} ${e.required == true ? '*' : ''}',
                                                    style: textTheme.headingS,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          BlocBuilder<ServiceBloc,
                                              ServiceState>(
                                            builder: (context, state) {
                                              visibleSurveyFormIndexes
                                                  .add(index);
                                              return Column(
                                                children: e.values!
                                                    .where((e1) =>
                                                        e1 !=
                                                        i18.surveyForm
                                                            .notSelectedKey)
                                                    .toList()
                                                    .map((e) => Column(
                                                          children: [
                                                            DigitCheckbox(
                                                              label:
                                                                  localizations
                                                                      .translate(
                                                                          e),
                                                              value: controller[
                                                                      index]
                                                                  .text
                                                                  .split('.')
                                                                  .contains(e),
                                                              onChanged:
                                                                  (value) {
                                                                context
                                                                    .read<
                                                                        ServiceBloc>()
                                                                    .add(
                                                                      ServiceSurveyFormEvent(
                                                                        value: e
                                                                            .toString(),
                                                                        submitTriggered:
                                                                            submitTriggered,
                                                                      ),
                                                                    );
                                                                final String
                                                                    ele;
                                                                var val =
                                                                    controller[
                                                                            index]
                                                                        .text
                                                                        .split(
                                                                            '.');
                                                                if (val
                                                                    .contains(
                                                                        e)) {
                                                                  val.remove(e);
                                                                  ele =
                                                                      val.join(
                                                                          ".");
                                                                } else {
                                                                  ele =
                                                                      "${controller[index].text}.$e";
                                                                }
                                                                controller[index]
                                                                        .value =
                                                                    TextEditingController
                                                                        .fromValue(
                                                                  TextEditingValue(
                                                                    text: ele,
                                                                  ),
                                                                ).value;
                                                              },
                                                            ),
                                                            SizedBox(
                                                              height: theme
                                                                  .spacerTheme
                                                                  .spacer3,
                                                            )
                                                          ],
                                                        ))
                                                    .toList(),
                                              );
                                            },
                                          ),
                                          BlocBuilder<ServiceBloc,
                                              ServiceState>(
                                            builder: (context, state) {
                                              return (e.values
                                                              ?.firstWhereOrNull(
                                                            (element) =>
                                                                element
                                                                    .toUpperCase() ==
                                                                othersText,
                                                          ) !=
                                                          null &&
                                                      controller[index]
                                                          .text
                                                          .contains(othersText))
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        left: 4.0,
                                                        right: 4.0,
                                                        bottom: 16,
                                                      ),
                                                      child: DigitTextField(
                                                        maxLength: 1000,
                                                        controller:
                                                            additionalController[
                                                                index],
                                                        label:
                                                            '${localizations.translate(
                                                          '${selectedServiceDefinition?.code}.${e.code}.ADDITIONAL_FIELD',
                                                        )}*',
                                                        validator: (value1) {
                                                          if (value1 == null ||
                                                              value1 == '') {
                                                            return localizations
                                                                .translate(
                                                              i18_local.common
                                                                  .coreCommonOthersRequired,
                                                            );
                                                          }

                                                          return null;
                                                        },
                                                      ),
                                                    )
                                                  : const SizedBox();
                                            },
                                          ),
                                          BlocBuilder<ServiceBloc,
                                              ServiceState>(
                                            builder: (context, state) {
                                              final hasError =
                                                  (e.required == true &&
                                                      controller[index]
                                                          .text
                                                          .isEmpty &&
                                                      submitTriggered);

                                              return Offstage(
                                                offstage: !hasError,
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    localizations.translate(
                                                      i18.common
                                                          .corecommonRequired,
                                                    ),
                                                    style: TextStyle(
                                                      color: theme
                                                          .colorScheme.error,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ] else if (e.dataType ==
                                            'SingleValueList') ...[
                                          if (!(e.code ?? '').contains('.'))
                                            DigitCard(
                                                cardType: CardType.secondary,
                                                children: [
                                                  _buildSurveyForm(
                                                    e,
                                                    index,
                                                    selectedServiceDefinition,
                                                    context,
                                                    description,
                                                  ),
                                                ]),
                                        ] else if (e.dataType == 'Boolean') ...[
                                          if (!(e.code ?? '').contains('.'))
                                            DigitCard(
                                                cardType: CardType.primary,
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              spacer2),
                                                      child: LabeledField(
                                                        label: localizations
                                                            .translate(
                                                          '${selectedServiceDefinition?.code}.${e.code}',
                                                        ),
                                                        description:
                                                            description != null
                                                                ? localizations
                                                                    .translate(
                                                                    '${selectedServiceDefinition?.code}.$description',
                                                                  )
                                                                : null,
                                                        isRequired:
                                                            e.required ?? false,
                                                        capitalizedFirstLetter:
                                                            false,
                                                        charCondition: true,
                                                        child: BlocBuilder<
                                                            ServiceBloc,
                                                            ServiceState>(
                                                          builder:
                                                              (context, state) {
                                                            return FormField<
                                                                bool>(
                                                              autovalidateMode:
                                                                  AutovalidateMode
                                                                      .onUserInteraction,
                                                              validator:
                                                                  (value) {
                                                                if (e.required ==
                                                                        true &&
                                                                    (controller[index].text ==
                                                                            null ||
                                                                        controller[index].text ==
                                                                            '')) {
                                                                  return localizations
                                                                      .translate(
                                                                    i18.common
                                                                        .corecommonRequired,
                                                                  );
                                                                }

                                                                return null;
                                                              },
                                                              builder: (field) =>
                                                                  SelectionCard<
                                                                      bool>(
                                                                errorMessage: field
                                                                    .errorText,
                                                                allowMultipleSelection:
                                                                    false,
                                                                valueMapper:
                                                                    (value) {
                                                                  return value
                                                                      ? localizations
                                                                          .translate(
                                                                          i18.common
                                                                              .coreCommonYes,
                                                                        )
                                                                      : localizations
                                                                          .translate(
                                                                          i18.common
                                                                              .coreCommonNo,
                                                                        );
                                                                },
                                                                initialSelection: controller[index]
                                                                            .text ==
                                                                        'true'
                                                                    ? [true]
                                                                    : controller[index].text ==
                                                                            'false'
                                                                        ? [
                                                                            false
                                                                          ]
                                                                        : [],
                                                                options: const [
                                                                  true,
                                                                  false
                                                                ],
                                                                onSelectionChanged:
                                                                    (curValue) {
                                                                  field.didChange(
                                                                      curValue
                                                                          .first);
                                                                  if (curValue
                                                                      .isNotEmpty) {
                                                                    context
                                                                        .read<
                                                                            ServiceBloc>()
                                                                        .add(
                                                                          ServiceSurveyFormEvent(
                                                                            value:
                                                                                curValue.toString(),
                                                                            submitTriggered:
                                                                                submitTriggered,
                                                                          ),
                                                                        );
                                                                    controller[index]
                                                                            .value =
                                                                        TextEditingValue(
                                                                      text: curValue
                                                                          .first
                                                                          .toString(),
                                                                    );
                                                                  }
                                                                },
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ]),
                                        ],
                                      ]);
                                    }),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                  ]),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            );
          }),
        ),
      ),
    );
  }

  Widget _buildSurveyForm(
      AttributesModel item,
      int index,
      ServiceDefinitionModel? selectedServiceDefinition,
      BuildContext context,
      String? description) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);
    /* Check the data type of the attribute*/
    if (item.dataType == 'SingleValueList') {
      final childItems = getNextQuestions(
        item.code.toString(),
        initialAttributes ?? [],
      );
      List<int> excludedIndexes = [];

      // Ensure the current index is added to visible indexes and not excluded
      if (!visibleSurveyFormIndexes.contains(index) &&
          !excludedIndexes.contains(index)) {
        visibleSurveyFormIndexes.add(index);
      }

      // Determine excluded indexes
      for (int i = 0; i < (initialAttributes ?? []).length; i++) {
        if (!visibleSurveyFormIndexes.contains(i)) {
          excludedIndexes.add(i);
        }
      }

      return Align(
        alignment: Alignment.topLeft,
        child: LabeledField(
            label: localizations.translate(
              '${selectedServiceDefinition?.code}.${item.code}',
            ),
            description: description != null
                ? localizations.translate(
                    '${selectedServiceDefinition?.code}.$description',
                  )
                : null,
            capitalizedFirstLetter: false,
            charCondition: true,
            isRequired: item.required ?? false,
            child: Column(children: [
              BlocBuilder<ServiceBloc, ServiceState>(
                builder: (context, state) {
                  return Align(
                      alignment: Alignment.topLeft,
                      child: FormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value1) {
                            if (item.required == true &&
                                (controller[index].text == null ||
                                    controller[index].text == '')) {
                              return localizations.translate(
                                i18.common.corecommonRequired,
                              );
                            }

                            return null;
                          },
                          builder: (field) => RadioList(
                                radioDigitButtons: item.values != null
                                    ? item.values!
                                        .where((e) =>
                                            e != i18.surveyForm.notSelectedKey)
                                        .toList()
                                        .map((item) => RadioButtonModel(
                                              code: item,
                                              name: localizations.translate(
                                                '${selectedServiceDefinition?.code}.${item.trim()}',
                                              ),
                                            ))
                                        .toList()
                                    : [],
                                errorMessage: field.errorText,
                                groupValue: controller[index].text.trim(),
                                onChanged: (value) {
                                  field.didChange(value);
                                  context.read<ServiceBloc>().add(
                                        ServiceSurveyFormEvent(
                                          value:
                                              Random().nextInt(100).toString(),
                                          submitTriggered: submitTriggered,
                                        ),
                                      );
                                  setState(() {
                                    // Clear child controllers and update visibility
                                    for (final matchingChildItem
                                        in childItems) {
                                      final childIndex = initialAttributes
                                          ?.indexOf(matchingChildItem);
                                      if (childIndex != null) {
                                        // controller[childIndex].clear();
                                        visibleSurveyFormIndexes.removeWhere(
                                            (v) => v == childIndex);
                                      }
                                    }

                                    // Update the current controller's value
                                    controller[index].value =
                                        TextEditingController.fromValue(
                                      TextEditingValue(
                                        text: value!.code,
                                      ),
                                    ).value;

                                    if (excludedIndexes.isNotEmpty) {
                                      for (int i = 0;
                                          i < excludedIndexes.length;
                                          i++) {
                                        // Clear excluded child controllers
                                        if (item.dataType !=
                                            'SingleValueList') {
                                          // controller[excludedIndexes[i]].value =
                                          //     TextEditingController.fromValue(
                                          //   const TextEditingValue(
                                          //     text: '',
                                          //   ),
                                          // ).value;
                                        }
                                      }
                                    }

                                    // Remove corresponding controllers based on the removed attributes
                                  });
                                },
                              )));
                },
              ),
              BlocBuilder<ServiceBloc, ServiceState>(
                builder: (context, state) {
                  return (controller[index].text == item.values?[1].trim() &&
                          item.dataType != 'SingleValueList')
                      ? Padding(
                          padding: const EdgeInsets.only(
                            left: spacer1,
                            right: spacer1,
                            bottom: spacer4,
                          ),
                          child: FormField<String>(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value1) {
                              if (item.required == true &&
                                  (additionalController[index].text == null ||
                                      additionalController[index].text == '')) {
                                return localizations.translate(
                                  i18.common.corecommonRequired,
                                );
                              }

                              return null;
                            },
                            builder: (field) {
                              return LabeledField(
                                  label: localizations.translate(
                                    '${selectedServiceDefinition?.code}.${item.code}.ADDITIONAL_FIELD',
                                  ),
                                  description: description != null
                                      ? localizations.translate(
                                          '${selectedServiceDefinition?.code}.$description',
                                        )
                                      : null,
                                  isRequired: item.required ?? false,
                                  capitalizedFirstLetter: false,
                                  charCondition: true,
                                  child: DigitTextFormInput(
                                    onChange: (value) {
                                      field.didChange(value);
                                      additionalController[index].text = value;
                                    },
                                    errorMessage: field.errorText,
                                    maxLength: 1000,
                                    charCount: true,
                                    controller: additionalController[index],
                                  ));
                            },
                          ),
                        )
                      : const SizedBox();
                },
              ),
              if (childItems.isNotEmpty &&
                  controller[index].text.trim().isNotEmpty) ...[
                _buildNestedSurveyForm(
                  item.code.toString(),
                  index,
                  controller[index].text.trim(),
                  context,
                  description,
                ),
              ],
            ])),
      );
    } else if (item.dataType == 'String') {
      return FormField<String>(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (((controller[index].text == null ||
                    controller[index].text == '') &&
                item.required == true)) {
              return localizations.translate(i18.common.corecommonRequired);
            }
            if (item.regex != null) {
              return (RegExp(item.regex!).hasMatch(controller[index].text!))
                  ? null
                  : localizations.translate("${item.code}_REGEX");
            }

            return null;
          },
          builder: (field) {
            return LabeledField(
              label: localizations.translate(
                '${selectedServiceDefinition?.code}.${item.code}',
              ),
              description: description != null
                  ? localizations.translate(
                      '${selectedServiceDefinition?.code}.$description',
                    )
                  : null,
              isRequired: item.required ?? false,
              capitalizedFirstLetter: false,
              charCondition: true,
              child: DigitTextFormInput(
                maxLength: 1000,
                charCount: true,
                onChange: (value) {
                  field.didChange(value);
                  controller[index].text = value;
                },
                errorMessage: field.errorText,
                controller: controller[index],
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(
                    "[a-zA-Z0-9 ]",
                  )),
                ],
              ),
            );
          });
    } else if (item.dataType == 'Number') {
      return FormField<String>(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (((controller[index].text == null ||
                    controller[index].text == '') &&
                item.required == true)) {
              return localizations.translate(
                i18.common.corecommonRequired,
              );
            }
            if (item.regex != null) {
              return (RegExp(item.regex!).hasMatch(controller[index].text!))
                  ? null
                  : localizations.translate("${item.code}_REGEX");
            }

            return null;
          },
          builder: (field) {
            return LabeledField(
              label: localizations
                  .translate(
                    '${selectedServiceDefinition?.code}.${item.code}',
                  )
                  .trim(),
              description: description != null
                  ? localizations.translate(
                      '${selectedServiceDefinition?.code}.$description',
                    )
                  : null,
              isRequired: item.required ?? false,
              capitalizedFirstLetter: false,
              charCondition: true,
              child: DigitTextFormInput(
                onChange: (value) {
                  field.didChange(value);
                  controller[index].text = value;
                },
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(
                    "[0-9]",
                  )),
                ],
                errorMessage: field.errorText,
                controller: controller[index],
              ),
            );
          });
    } else if (item.dataType == 'MultiValueList') {
      visibleSurveyFormIndexes.add(index);
      return Column(children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Text(
                  '${localizations.translate(
                    '${selectedServiceDefinition?.code}.${item.code}',
                  )} ${item.required == true ? '*' : ''}',
                  style: textTheme.headingS,
                ),
              ],
            ),
          ),
        ),
        BlocBuilder<ServiceBloc, ServiceState>(builder: (context, state) {
          return Column(
            children: item.values!
                .where((e1) => e1 != i18.surveyForm.notSelectedKey)
                .toList()
                .map((e) => Column(
                      children: [
                        DigitCheckbox(
                          label: localizations.translate(e),
                          value: controller[index].text.split('.').contains(e),
                          onChanged: (value) {
                            context.read<ServiceBloc>().add(
                                  ServiceSurveyFormEvent(
                                    value: e.toString(),
                                    submitTriggered: submitTriggered,
                                  ),
                                );
                            final String ele;
                            var val = controller[index].text.split('.');
                            if (val.contains(e)) {
                              val.remove(e);
                              ele = val.join(".");
                            } else {
                              ele = "${controller[index].text}.$e";
                            }
                            setState(() {
                              controller[index].value =
                                  TextEditingController.fromValue(
                                TextEditingValue(
                                  text: ele,
                                ),
                              ).value;
                            });
                          },
                        ),
                        SizedBox(
                          height: theme.spacerTheme.spacer3,
                        )
                      ],
                    ))
                .toList(),
          );
        }),
        BlocBuilder<ServiceBloc, ServiceState>(
          builder: (context, state) {
            return item.values?.firstWhereOrNull(
                          (element) => element.toUpperCase() == othersText,
                        ) !=
                        null &&
                    controller[index].text.contains(othersText)
                ? Padding(
                    padding: const EdgeInsets.only(
                      left: 4.0,
                      right: 4.0,
                      bottom: 16,
                    ),
                    child: DigitTextField(
                      maxLength: 1000,
                      controller: additionalController[index],
                      label: '${localizations.translate(
                        '${selectedServiceDefinition?.code}.${item.code}.ADDITIONAL_FIELD',
                      )}*',
                      validator: (value1) {
                        if (value1 == null || value1 == '') {
                          return localizations.translate(
                            i18_local.common.coreCommonOthersRequired,
                          );
                        }

                        return null;
                      },
                    ),
                  )
                : const SizedBox();
          },
        ),
        BlocBuilder<ServiceBloc, ServiceState>(
          builder: (context, state) {
            final hasError = (item.required == true &&
                controller[index].text.isEmpty &&
                submitTriggered);

            return Offstage(
              offstage: !hasError,
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
            );
          },
        ),
      ]);
    } else if (item.dataType == 'Boolean') {
      return Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.all(spacer2),
          child: LabeledField(
            label: localizations.translate(
              '${selectedServiceDefinition?.code}.${item.code}',
            ),
            description: description != null
                ? localizations.translate(
                    '${selectedServiceDefinition?.code}.$description',
                  )
                : null,
            isRequired: item.required ?? false,
            capitalizedFirstLetter: false,
            charCondition: true,
            child: BlocBuilder<ServiceBloc, ServiceState>(
              builder: (context, state) {
                return FormField<bool>(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (item.required == true &&
                        (controller[index].text == null ||
                            controller[index].text == '')) {
                      return localizations.translate(
                        i18.common.corecommonRequired,
                      );
                    }

                    return null;
                  },
                  builder: (field) => SelectionCard(
                    errorMessage: field.errorText,
                    allowMultipleSelection: false,
                    valueMapper: (value) {
                      return value
                          ? localizations.translate(
                              i18.common.coreCommonYes,
                            )
                          : localizations.translate(
                              i18.common.coreCommonNo,
                            );
                    },
                    initialSelection: const [false],
                    options: const [true, false],
                    onSelectionChanged: (value) {
                      field.didChange(value.first);
                      context.read<ServiceBloc>().add(
                            ServiceSurveyFormEvent(
                              value: value.toString(),
                              submitTriggered: submitTriggered,
                            ),
                          );
                      final String ele;
                      var val = controller[index].text.split('.');
                      if (val.contains(e)) {
                        val.remove(e);
                        ele = val.join(".");
                      } else {
                        ele = "${controller[index].text}.$e";
                      }
                      controller[index].value = TextEditingController.fromValue(
                        TextEditingValue(
                          text: ele,
                        ),
                      ).value;
                    },
                  ),
                );
              },
            ),
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  // Function to build nested SurveyForm for child attributes
  Widget _buildNestedSurveyForm(String parentCode, int parentIndex,
      String parentControllerValue, BuildContext context, String? description) {
    // Retrieve child items for the given parent code
    final childItems = getNextQuestions(
      parentCode,
      initialAttributes ?? [],
    );

    return Column(
      children: [
        // Build cards for each matching child attribute
        for (final matchingChildItem in childItems.where((childItem) =>
            childItem.code!.startsWith('$parentCode.$parentControllerValue.')))
          DigitCard(
              cardType: CardType.secondary,
              margin: const EdgeInsets.only(
                  bottom: spacer2, left: spacer2, right: spacer2),
              children: [
                _buildSurveyForm(
                    matchingChildItem,
                    initialAttributes?.indexOf(matchingChildItem) ??
                        parentIndex,
                    // Pass parentIndex here as we're building at the same level
                    selectedServiceDefinition,
                    context,
                    description),
              ]),
      ],
    );
  }

  // Function to get the next questions (child attributes) based on a parent code
  List<AttributesModel> getNextQuestions(
    String parentCode,
    List<AttributesModel> surveyFormItems,
  ) {
    final childCodePrefix = '$parentCode.';
    final nextSurveyForm = surveyFormItems.where((item) {
      return item.code!.startsWith(childCodePrefix) &&
          item.code?.split('.').length == parentCode.split('.').length + 2;
    }).toList();

    return nextSurveyForm;
  }

  int countDots(String inputString) {
    int dotCount = 0;
    for (int i = 0; i < inputString.length; i++) {
      if (inputString[i] == '.') {
        dotCount++;
      }
    }

    return dotCount;
  }

  List<bool> isIneligible(
    Map<String?, String> responses,
    List<String?> ineligibilityReasons,
    bool ifAdministration,
  ) {
    var isIneligible = false;
    var q4Key = "SEA3";

    Map<String, String> keyVsReason = {
      q4Key: "CHILD_ON_MEDICATION_1",
    };

    if (responses.isNotEmpty) {
      if (!isIneligible &&
          (responses.containsKey(q4Key) && responses[q4Key]!.isNotEmpty)) {
        isIneligible = responses[q4Key] == yes ? true : false;
      }

      // passing all the reasons which have response as true
      if (isIneligible) {
        for (var entry in responses.entries) {
          if (entry.key == q4Key) {
            entry.value == yes
                ? ineligibilityReasons.add(keyVsReason[entry.key])
                : null;
          }
        }
      }
    }

    return [isIneligible, ifAdministration];
  }

  List<bool> isIneligibleOncho(
      Map<String?, String> responses, List<String?> ineligibilityReasons) {
    var isIneligible = false;
    var ifAdministration = false;

    for (var entry in responses.entries) {
      if (entry.value == yes) {
        isIneligible = true;
        break;
      }
    }

    for (var entry in responses.entries) {
      if (entry.value == yes) {
        ineligibilityReasons.add(entry.key);
      }
    }

    return [isIneligible, ifAdministration];
  }

  bool isReferral(
    Map<String?, String> responses,
    List<String?> referralReasons,
  ) {
    var isReferral = false;
    var q1Key = "SEA1";
    var q2Key = "SEA1.YES.ADT1";
    var q3Key = "SEA2";
    Map<String, String> referralKeysVsCode = {
      q1Key: "SICK",
      q2Key: "FEVER",
      q3Key: "DRUG_SE_PC",
    };
    // TODO Configure the reasons ,verify hardcoded strings

    if (responses.isNotEmpty) {
      if (responses.containsKey(q1Key) && responses[q1Key]!.isNotEmpty) {
        isReferral = responses[q1Key] == yes ? true : false;
      }
      if (!isReferral &&
          (responses.containsKey(q2Key) && responses[q2Key]!.isNotEmpty)) {
        isReferral = responses[q2Key] == yes ? true : false;
      }
      if (!isReferral &&
          (responses.containsKey(q3Key) && responses[q3Key]!.isNotEmpty)) {
        isReferral = responses[q3Key] == yes ? true : false;
      }
    }
    if (isReferral) {
      for (var entry in referralKeysVsCode.entries) {
        if (responses.containsKey(entry.key) &&
            responses[entry.key]!.isNotEmpty) {
          if (responses[entry.key] == yes) {
            referralReasons.add(entry.value);
          }
        }
      }
    }

    return isReferral;
  }

// todo complete this method to handle and return correct service definition based on project type and other conditions
  ServiceDefinitionModel? serviceDefinitionBasedOnProjectType(
      List<ServiceDefinitionModel> serviceDefinitions) {
    ServiceDefinitionModel? serviceDefinition;

// Note: dob is necessary to determine the service definition for smc and oncho project types as they have different service definitions based on age criteria. For other project types, dob is not necessary as there is only one service definition for eligibility assessment.
    DigitDOBAgeConvertor individualAge = widget.individual?.dateOfBirth != null
        ? DigitDateUtils.calculateAge(
            DigitDateUtils.getFormattedDateToDateTime(
                  widget.individual!.dateOfBirth!,
                ) ??
                DateTime.now(),
          )
        : DigitDOBAgeConvertor(days: 0, months: 0, years: 0);

    final ageInMonths = individualAge.years * 12 + individualAge.months;

    // add check for oncho and smc

    if (context.isSmcAndOnchoFlow) {
      if (ageInMonths < 60) {
        serviceDefinition = serviceDefinitions
            .where((element) => element.code.toString().contains(
                  '${context.selectedProject.name}.ELIGIBLITY_ASSESSMENT.${context.isCommunityDistributor ? RolesType.communityDistributor.toValue() : RolesType.healthFacilitySupervisor.toValue()}',
                ))
            .toList()
            .first;
      } else {
        serviceDefinition = serviceDefinitions
            .where((element) => element.code.toString().contains(
                  '${context.selectedProject.name}.ELIGIBILITY_ASSESSMENT_TWO.${context.isCommunityDistributor ? RolesType.communityDistributor.toValue() : RolesType.healthFacilitySupervisor.toValue()}',
                ))
            .toList()
            .first;
      }
    } else {
      serviceDefinition = serviceDefinitions
          .where((element) => element.code.toString().contains(
                '${context.selectedProject.name}.ELIGIBLITY_ASSESSMENT.${context.isCommunityDistributor ? RolesType.communityDistributor.toValue() : RolesType.healthFacilitySupervisor.toValue()}',
              ))
          .toList()
          .first;
    }

    return serviceDefinition;
  }

  bool isDelivery(Map<String?, String> responses) {
    var isDeliver = true;
    // exclude the questions SEAA4 and SEAA4.YES.ADT1 while checking for delivery,
    // as they not needed for flow decision now
    for (var entry in responses.entries) {
      if (entry.value == yes &&
          !(entry.key!.contains('SEAA4') ||
              entry.key!.contains('SEAA4.YES.ADT1'))) {
        isDeliver = false;
        break;
      }
    }

    return isDeliver;
  }

  Future<bool> _onBackPressed(BuildContext context) async {
    bool? shouldNavigateBack = await showDialog<bool>(
      context: context,
      builder: (context) => Popup(
        title: localizations.translate(
          i18.surveyForm.surveyFormBackDialogLabel,
        ),
        type: PopUpType.simple,
        description: localizations.translate(
          i18.surveyForm.surveyFormBackDialogDescription,
        ),
        actions: [
          DigitButton(
              label: localizations
                  .translate(i18.surveyForm.surveyFormBackDialogPrimaryAction),
              onPressed: () {
                Navigator.of(
                  context,
                  rootNavigator: true,
                ).pop(true);
              },
              type: DigitButtonType.primary,
              size: DigitButtonSize.large),
          DigitButton(
              label: localizations.translate(
                  i18.surveyForm.surveyFormBackDialogSecondaryAction),
              onPressed: () {
                Navigator.of(
                  context,
                  rootNavigator: true,
                ).pop(false);
              },
              type: DigitButtonType.secondary,
              size: DigitButtonSize.large)
        ],
      ),
    );

    return shouldNavigateBack ?? false;
  }
}
