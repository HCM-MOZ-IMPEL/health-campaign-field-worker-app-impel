import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:digit_components/digit_components.dart';
import 'package:digit_components/utils/date_utils.dart';
import 'package:digit_components/widgets/atoms/digit_checkbox.dart';
import 'package:digit_components/widgets/atoms/digit_toaster.dart';
import 'package:digit_components/widgets/atoms/selection_card.dart';
import 'package:digit_components/widgets/digit_dob_picker.dart';
import 'package:digit_data_model/data_model.dart';
import 'package:digit_scanner/blocs/scanner.dart';
import 'package:digit_scanner/pages/qr_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_campaign_field_worker_app/router/app_router.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:registration_delivery/models/entities/additional_fields_type.dart';
import 'package:registration_delivery/models/entities/status.dart';
import 'package:registration_delivery/registration_delivery.dart';
import 'package:registration_delivery/utils/constants.dart';
// import 'package:registration_delivery/utils/extensions/extensions.dart';

import 'package:registration_delivery/router/registration_delivery_router.gm.dart';
import 'package:registration_delivery/utils/i18_key_constants.dart' as i18;
import '../../../../utils/utils_smc/i18_key_constants.dart' as i18_local;
import '../../../utils/utils.dart' hide Constants;
import 'package:registration_delivery/widgets/back_navigation_help_header.dart';
// import 'package:registration_delivery/widgets/localized.dart';
import 'package:registration_delivery/widgets/showcase/config/showcase_constants.dart';
import 'package:registration_delivery/widgets/showcase/showcase_button.dart';

import '../../../widgets/custom_digit_dob_picker.dart';
import '../../../widgets/localized.dart';
import '../../../widgets/widgets_smc/custom_digit_dob_picker_smc.dart';
// import 'package:registration_delivery/blocs/app_localization.dart'
// as registration_delivery_localization;

@RoutePage()
class CustomIndividualDetailsSMCPage extends LocalizedStatefulWidget {
  final bool isHeadOfHousehold;

  const CustomIndividualDetailsSMCPage({
    super.key,
    super.appLocalizations,
    this.isHeadOfHousehold = true,
  });

  @override
  State<CustomIndividualDetailsSMCPage> createState() =>
      CustomIndividualDetailsSMCPageState();
}

class CustomIndividualDetailsSMCPageState
    extends LocalizedState<CustomIndividualDetailsSMCPage> {
  static const _individualNameKey = 'individualName';
  static const _individualLastNameKey = 'individualLastName';
  static const _dobKey = 'dob';
  static const _genderKey = 'gender';
  static const _mobileNumberKey = 'mobileNumber';
  bool isDuplicateTag = false;
  static const maxLength = 200;
  final clickedStatus = ValueNotifier<bool>(false);
  DateTime now = DateTime.now();
  bool isEditIndividual = false;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BeneficiaryRegistrationBloc>();
    final router = context.router;
    final theme = Theme.of(context);
    DateTime before150Years = DateTime(now.year - 150, now.month, now.day);
    final beneficiaryType = RegistrationDeliverySingleton().beneficiaryType!;

    return Scaffold(
      body: ReactiveFormBuilder(
        form: () => buildForm(bloc.state),
        builder: (context, form, child) => BlocConsumer<
            BeneficiaryRegistrationBloc, BeneficiaryRegistrationState>(
          listener: (context, state) {
            state.mapOrNull(
              persisted: (value) {
                if (value.navigateToRoot) {
                  context.router.push(CustomBeneficiaryAcknowledgementSMCRoute(
                    enableViewHousehold: true,
                  ));
                } else {
                  Future.delayed(
                    const Duration(
                      milliseconds: 500,
                    ),
                    () {
                      context.read<SearchHouseholdsBloc>().add(
                            SearchHouseholdsByHouseholdsEvent(
                              householdModel: value.householdModel,
                              projectId: context.projectId,
                              isProximityEnabled: false,
                            ),
                          );
                    },
                  ).then((value) => {
                        context.router
                            .push(CustomBeneficiaryAcknowledgementSMCRoute(
                          enableViewHousehold: widget.isHeadOfHousehold,
                        )),
                      });
                }
              },
            );
          },
          builder: (context, state) {
            return ScrollableContent(
              enableFixedButton: true,
              header: Column(children: [
                BackNavigationHelpHeaderWidget(
                  showHelp: false,
                  handleBack: () {
                    if (isEditIndividual) {
                      final parent = context.router.parent() as StackRouter;
                      parent.maybePop();
                    } else {
                      context.router.maybePop();
                    }
                  },
                ),
              ]),
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
                              final age = DigitDateUtils.calculateAge(
                                form.control(_dobKey).value as DateTime?,
                              );
                              if ((age.years == 0 && age.months == 0) ||
                                  age.years >= 150 && age.months > 0) {
                                form.control(_dobKey).setErrors({'': true});
                              }

                              if (form.control(_genderKey).value == null) {
                                setState(() {
                                  form
                                      .control(_genderKey)
                                      .setErrors({'': true});
                                });
                              }
                              final userId = RegistrationDeliverySingleton()
                                  .loggedInUserUuid;
                              final projectId =
                                  RegistrationDeliverySingleton().projectId;
                              form.markAllAsTouched();
                              if (!form.valid) return;
                              FocusManager.instance.primaryFocus?.unfocus();

                              if (age.years < 18 && widget.isHeadOfHousehold) {
                                await DigitToast.show(
                                  context,
                                  options: DigitToastOptions(
                                    localizations.translate(i18_local
                                        .individualDetails.headAgeValidError),
                                    true,
                                    theme,
                                  ),
                                );

                                return;
                              }

                              final submit = await DigitDialog.show<bool>(
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

                              if (!(submit ?? false)) {
                                return;
                              }

                              state.maybeWhen(
                                orElse: () {
                                  return;
                                },
                                create: (
                                  addressModel,
                                  householdModel,
                                  individualModel,
                                  projectBeneficiaryModel,
                                  registrationDate,
                                  searchQuery,
                                  loading,
                                  isHeadOfHousehold,
                                ) {
                                  // clickedStatus.value = true;
                                  final individual = _getIndividualModel(
                                    context,
                                    form: form,
                                    oldIndividual: null,
                                  );
                                  isEditIndividual = false;
                                  final boundary =
                                      RegistrationDeliverySingleton().boundary;

                                  bloc.add(
                                    BeneficiaryRegistrationSaveIndividualDetailsEvent(
                                      model: individual,
                                      isHeadOfHousehold:
                                          widget.isHeadOfHousehold,
                                    ),
                                  );
                                  final scannerBloc =
                                      context.read<DigitScannerBloc>();

                                  if (scannerBloc.state.duplicate) {
                                    DigitToast.show(
                                      context,
                                      options: DigitToastOptions(
                                        localizations.translate(
                                          i18.deliverIntervention
                                              .resourceAlreadyScanned,
                                        ),
                                        true,
                                        theme,
                                      ),
                                    );
                                  } else {
                                    if (context.mounted) {
                                      final scannerBloc =
                                          context.read<DigitScannerBloc>();
                                      bloc.add(
                                        BeneficiaryRegistrationSummaryEvent(
                                          projectId: projectId!,
                                          userUuid: userId!,
                                          boundary: boundary!,
                                          tag: scannerBloc
                                                  .state.qrCodes.isNotEmpty
                                              ? scannerBloc.state.qrCodes.first
                                              : null,
                                        ),
                                      );
                                      // router.push(SummaryRoute());

                                      bloc.add(
                                        BeneficiaryRegistrationCreateEvent(
                                            projectId: projectId,
                                            userUuid: userId,
                                            boundary: boundary,
                                            tag: scannerBloc
                                                    .state.qrCodes.isNotEmpty
                                                ? scannerBloc
                                                    .state.qrCodes.first
                                                : null,
                                            navigateToSummary: false),
                                      );
                                    }
                                  }
                                },
                                editIndividual: (
                                  householdModel,
                                  individualModel,
                                  addressModel,
                                  projectBeneficiaryModel,
                                  loading,
                                ) {
                                  // clickedStatus.value = true;
                                  isEditIndividual = true;
                                  final scannerBloc =
                                      context.read<DigitScannerBloc>();
                                  final individual = _getIndividualModel(
                                    context,
                                    form: form,
                                    oldIndividual: individualModel,
                                  );
                                  final tag =
                                      scannerBloc.state.qrCodes.isNotEmpty
                                          ? scannerBloc.state.qrCodes.first
                                          : null;

                                  if (tag != null &&
                                      tag != projectBeneficiaryModel?.tag &&
                                      scannerBloc.state.duplicate) {
                                    DigitToast.show(
                                      context,
                                      options: DigitToastOptions(
                                        localizations.translate(
                                          i18.deliverIntervention
                                              .resourceAlreadyScanned,
                                        ),
                                        true,
                                        theme,
                                      ),
                                    );
                                  } else {
                                    bloc.add(
                                      BeneficiaryRegistrationUpdateIndividualDetailsEvent(
                                        addressModel: addressModel,
                                        householdModel: householdModel,
                                        model: individual.copyWith(
                                          clientAuditDetails: (individual
                                                          .clientAuditDetails
                                                          ?.createdBy !=
                                                      null &&
                                                  individual.clientAuditDetails
                                                          ?.createdTime !=
                                                      null)
                                              ? ClientAuditDetails(
                                                  createdBy: individual
                                                      .clientAuditDetails!
                                                      .createdBy,
                                                  createdTime: individual
                                                      .clientAuditDetails!
                                                      .createdTime,
                                                  lastModifiedBy:
                                                      RegistrationDeliverySingleton()
                                                          .loggedInUserUuid,
                                                  lastModifiedTime: context
                                                      .millisecondsSinceEpoch(),
                                                )
                                              : null,
                                        ),
                                        tag: scannerBloc
                                                .state.qrCodes.isNotEmpty
                                            ? scannerBloc.state.qrCodes.first
                                            : null,
                                      ),
                                    );
                                  }
                                },
                                addMember: (
                                  addressModel,
                                  householdModel,
                                  loading,
                                ) {
                                  // clickedStatus.value = true;
                                  final individual = _getIndividualModel(
                                    context,
                                    form: form,
                                  );

                                  bloc.add(
                                    BeneficiaryRegistrationAddMemberEvent(
                                        beneficiaryType:
                                            RegistrationDeliverySingleton()
                                                .beneficiaryType!,
                                        householdModel: householdModel,
                                        individualModel: individual,
                                        addressModel: addressModel,
                                        userUuid:
                                            RegistrationDeliverySingleton()
                                                .loggedInUserUuid!,
                                        projectId:
                                            RegistrationDeliverySingleton()
                                                .projectId!),
                                  );
                                },
                              );
                            },
                      child: Center(
                        child: Text(
                          state.mapOrNull(
                                editIndividual: (value) => localizations
                                    .translate(i18.common.coreCommonSave),
                              ) ??
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
                        Padding(
                          padding: const EdgeInsets.only(bottom: kPadding),
                          child: Text(
                            localizations.translate(
                              i18.individualDetails.individualsDetailsLabelText,
                            ),
                            style: theme.textTheme.displayMedium,
                          ),
                        ),
                        Column(children: [
                          individualDetailsShowcaseData.nameOfIndividual
                              .buildWith(
                            child: DigitTextFormField(
                              formControlName: _individualNameKey,
                              label: localizations.translate(
                                widget.isHeadOfHousehold
                                    ? i18_local.individualDetails
                                        .firstNameHeadLabelText
                                    : i18_local.individualDetails
                                        .childFirstNameLabelText,
                              ),
                              isRequired: true,
                              validationMessages: {
                                'required': (object) => localizations.translate(
                                      '${i18.individualDetails.nameLabelText}_IS_REQUIRED',
                                    ),
                                'maxLength': (object) => localizations
                                    .translate(i18.common.maxCharsRequired)
                                    .replaceAll('{}', maxLength.toString()),
                              },
                            ),
                          ),
                          DigitTextFormField(
                            formControlName: _individualLastNameKey,
                            label: localizations.translate(
                              widget.isHeadOfHousehold
                                  ? i18_local
                                      .individualDetails.lastNameHeadLabelText
                                  : i18_local
                                      .individualDetails.childLastNameLabelText,
                            ),
                            maxLength: 200,
                            isRequired: true,
                            validationMessages: {
                              'required': (object) => localizations.translate(
                                    i18_local.individualDetails
                                        .lastNameIsRequiredError,
                                  ),
                              'minLength': (object) => localizations.translate(
                                    i18_local
                                        .individualDetails.lastNameLengthError,
                                  ),
                              'maxLength': (object) => localizations.translate(
                                    i18_local
                                        .individualDetails.lastNameLengthError,
                                  ),
                              "min3": (object) => localizations.translate(
                                    i18_local.common.min3CharsRequired,
                                  ),
                            },
                          ),
                          // solution customisation
                          // Offstage(
                          //   offstage: !widget.isHeadOfHousehold,
                          //   child: DigitCheckbox(
                          //     label: localizations.translate(
                          //       i18.individualDetails.checkboxLabelText,
                          //     ),
                          //     value: widget.isHeadOfHousehold,
                          //   ),
                          // ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomDigitDobPickerSMC(
                            datePickerFormControl: _dobKey,
                            datePickerLabel: localizations.translate(
                              i18.individualDetails.dobLabelText,
                            ),
                            ageFieldLabel: localizations.translate(
                              i18.individualDetails.ageLabelText,
                            ),
                            yearsHintLabel: localizations.translate(
                              i18.individualDetails.yearsHintText,
                            ),
                            monthsHintLabel: localizations.translate(
                              i18.individualDetails.monthsHintText,
                            ),
                            separatorLabel: localizations.translate(
                              i18.individualDetails.separatorLabelText,
                            ),
                            yearsAndMonthsErrMsg: localizations.translate(
                              i18.individualDetails.yearsAndMonthsErrorText,
                            ),
                            initialDate: before150Years,
                            confirmText: localizations.translate(
                              i18.common.coreCommonOk,
                            ),
                            cancelText: localizations.translate(
                              i18.common.coreCommonCancel,
                            ),
                            onChangeOfFormControl: (formControl) {
                              // Handle changes to the control's value here
                              final value = formControl.value;
                              if (value == null) {
                                formControl.setErrors({'': true});
                              } else {
                                DigitDOBAge age =
                                    DigitDateUtils.calculateAge(value);
                                if ((age.years == 0 && age.months == 0) ||
                                    age.months > 11 ||
                                    (age.years > 150 ||
                                        (age.years == 150 && age.months > 0))) {
                                  formControl.setErrors({'': true});
                                } else {
                                  formControl.removeError('');
                                }
                              }
                            },
                          ),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                kPadding, 0, kPadding, 0),
                            child: SelectionBox<String>(
                              isRequired: true,
                              title: localizations.translate(
                                i18.individualDetails.genderLabelText,
                              ),
                              allowMultipleSelection: false,
                              width: 148,
                              initialSelection:
                                  form.control(_genderKey).value != null
                                      ? [form.control(_genderKey).value]
                                      : [],
                              options: RegistrationDeliverySingleton()
                                  .genderOptions!
                                  .map(
                                    (e) => e,
                                  )
                                  .toList(),
                              onSelectionChanged: (value) {
                                setState(() {
                                  if (value.isNotEmpty) {
                                    form.control(_genderKey).value =
                                        value.first;
                                  } // todo verify this
                                  else if (true) {
                                    form.control(_genderKey).value = null;
                                    setState(() {
                                      form
                                          .control(_genderKey)
                                          .setErrors({'': true});
                                    });
                                  }
                                });
                              },
                              valueMapper: (value) {
                                return localizations.translate(value);
                              },
                              errorMessage: form.control(_genderKey).hasErrors
                                  ? localizations
                                      .translate(i18.common.corecommonRequired)
                                  : null,
                            ),
                          ),
                        ]),
                        Offstage(
                          offstage: !widget.isHeadOfHousehold,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                                kPadding - 4, 0, kPadding - 4, 0),
                            child:
                                individualDetailsShowcaseData.mobile.buildWith(
                              child: DigitTextFormField(
                                keyboardType: TextInputType.number,
                                formControlName: _mobileNumberKey,
                                maxLength: 9,
                                label: localizations.translate(
                                  i18.individualDetails.mobileNumberLabelText,
                                ),
                                validationMessages: {
                                  'mobileNumber': (object) =>
                                      localizations.translate(i18
                                          .individualDetails
                                          .mobileNumberInvalidFormatValidationMessage),
                                  'maxLength': (object) =>
                                      localizations.translate(i18
                                          .individualDetails
                                          .mobileNumberLengthValidationMessage),
                                  'minLength': (object) =>
                                      localizations.translate(i18
                                          .individualDetails
                                          .mobileNumberLengthValidationMessage),
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  IndividualModel _getIndividualModel(
    BuildContext context, {
    required FormGroup form,
    IndividualModel? oldIndividual,
  }) {
    final dob = form.control(_dobKey).value == null
        ? null
        : form.control(_dobKey).value as DateTime?;
    String? dobString;
    if (dob != null) {
      dobString = DateFormat(Constants().dateFormat).format(dob);
    }

    var individual = oldIndividual;
    individual ??= IndividualModel(
      clientReferenceId: IdGen.i.identifier,
      tenantId: RegistrationDeliverySingleton().tenantId,
      rowVersion: 1,
      auditDetails: AuditDetails(
        createdBy: RegistrationDeliverySingleton().loggedInUserUuid!,
        createdTime: context.millisecondsSinceEpoch(),
        lastModifiedBy: RegistrationDeliverySingleton().loggedInUserUuid,
        lastModifiedTime: context.millisecondsSinceEpoch(),
      ),
      clientAuditDetails: ClientAuditDetails(
        createdBy: RegistrationDeliverySingleton().loggedInUserUuid!,
        createdTime: context.millisecondsSinceEpoch(),
        lastModifiedBy: RegistrationDeliverySingleton().loggedInUserUuid,
        lastModifiedTime: context.millisecondsSinceEpoch(),
      ),
    );

    var name = individual.name;
    name ??= NameModel(
      individualClientReferenceId: individual.clientReferenceId,
      tenantId: RegistrationDeliverySingleton().tenantId,
      rowVersion: 1,
      auditDetails: AuditDetails(
        createdBy: RegistrationDeliverySingleton().loggedInUserUuid!,
        createdTime: context.millisecondsSinceEpoch(),
        lastModifiedBy: RegistrationDeliverySingleton().loggedInUserUuid,
        lastModifiedTime: context.millisecondsSinceEpoch(),
      ),
      clientAuditDetails: ClientAuditDetails(
        createdBy: RegistrationDeliverySingleton().loggedInUserUuid!,
        createdTime: context.millisecondsSinceEpoch(),
        lastModifiedBy: RegistrationDeliverySingleton().loggedInUserUuid,
        lastModifiedTime: context.millisecondsSinceEpoch(),
      ),
    );

    var identifier = (individual.identifiers?.isNotEmpty ?? false)
        ? individual.identifiers!.first
        : null;

    identifier ??= IdentifierModel(
      clientReferenceId: individual.clientReferenceId,
      tenantId: RegistrationDeliverySingleton().tenantId,
      rowVersion: 1,
      auditDetails: AuditDetails(
        createdBy: RegistrationDeliverySingleton().loggedInUserUuid!,
        createdTime: context.millisecondsSinceEpoch(),
        lastModifiedBy: RegistrationDeliverySingleton().loggedInUserUuid,
        lastModifiedTime: context.millisecondsSinceEpoch(),
      ),
      clientAuditDetails: ClientAuditDetails(
        createdBy: RegistrationDeliverySingleton().loggedInUserUuid!,
        createdTime: context.millisecondsSinceEpoch(),
        lastModifiedBy: RegistrationDeliverySingleton().loggedInUserUuid,
        lastModifiedTime: context.millisecondsSinceEpoch(),
      ),
    );

    String? individualName = form.control(_individualNameKey).value as String?;
    individual = individual.copyWith(
      name: name.copyWith(
        givenName: individualName?.trim(),
        familyName:
            (form.control(_individualLastNameKey).value as String).trim(),
      ),
      gender: form.control(_genderKey).value == null
          ? null
          : Gender.values
              .byName(form.control(_genderKey).value.toString().toLowerCase()),
      mobileNumber: form.control(_mobileNumberKey).value,
      dateOfBirth: dobString,
      identifiers: [
        identifier.copyWith(
          identifierId: "DEFAULT",
          identifierType: "DEFAULT",
        ),
      ],
    );

    return individual;
  }

  FormGroup buildForm(BeneficiaryRegistrationState state) {
    final individual = state.mapOrNull<IndividualModel>(
      editIndividual: (value) {
        isEditIndividual = true;
        if (value.projectBeneficiaryModel?.tag != null) {
          context.read<DigitScannerBloc>().add(DigitScannerScanEvent(
              barCode: [], qrCode: [value.projectBeneficiaryModel!.tag!]));
        }

        return value.individualModel;
      },
      create: (value) {
        return value.individualModel;
      },
      summary: (value) {
        return value.individualModel;
      },
    );

    final searchQuery = state.mapOrNull<String>(
      create: (value) {
        return value.searchQuery;
      },
    );

    return fb.group(<String, Object>{
      _individualNameKey: FormControl<String>(
        validators: [
          Validators.required,
          CustomValidator.requiredMin,
          Validators.maxLength(200),
        ],
        value: individual?.name?.givenName ?? searchQuery?.trim(),
      ),
      _individualLastNameKey: FormControl<String>(
        validators: [
          Validators.required,
          CustomValidator.requiredMin,
          Validators.maxLength(200),
        ],
        value: individual?.name?.familyName ?? '',
      ),
      _dobKey: FormControl<DateTime>(
        value: individual?.dateOfBirth != null
            ? DateFormat(Constants().dateFormat).parse(
                individual!.dateOfBirth!,
              )
            : null,
      ),
      _genderKey: FormControl<String>(value: getGenderOptions(individual)),
      _mobileNumberKey: FormControl<String>(
          value: individual?.mobileNumber,
          validators: [
            CustomValidator.validMobileNumber,
            Validators.maxLength(9)
          ]),
    });
  }

  getGenderOptions(IndividualModel? individual) {
    final options = RegistrationDeliverySingleton().genderOptions;

    return options?.map((e) => e).firstWhereOrNull(
          (element) => element.toLowerCase() == individual?.gender?.name,
        );
  }
}