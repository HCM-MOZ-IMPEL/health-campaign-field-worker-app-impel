import 'package:auto_route/auto_route.dart';
import 'package:digit_components/digit_components.dart';
import 'package:digit_components/widgets/atoms/text_block.dart';
import 'package:digit_components/widgets/digit_sync_dialog.dart';
import 'package:digit_data_model/data_model.dart';
import 'package:digit_data_model/models/entities/address_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_campaign_field_worker_app/models/entities/project_types.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'package:registration_delivery/blocs/beneficiary_registration/beneficiary_registration.dart';
import 'package:registration_delivery/router/registration_delivery_router.gm.dart';
import '../../../router/app_router.dart';
import '../../../utils/extensions/extensions.dart' as contextLocal;
import '../../../utils/utils_smc/i18_key_constants.dart' as i18Local;
import 'package:registration_delivery/utils/i18_key_constants.dart' as i18;

import 'package:registration_delivery/utils/utils.dart';
import 'package:registration_delivery/widgets/back_navigation_help_header.dart';
import 'package:registration_delivery/widgets/localized.dart';
import 'package:registration_delivery/widgets/showcase/config/showcase_constants.dart';
import 'package:registration_delivery/widgets/showcase/showcase_button.dart';

import '../../../widgets/widgets_smc/custom_digit_text_form_field.dart';

@RoutePage()
class CustomHouseholdLocationSMCPage extends LocalizedStatefulWidget {
  const CustomHouseholdLocationSMCPage({
    super.key,
    super.appLocalizations,
  });

  @override
  State<CustomHouseholdLocationSMCPage> createState() =>
      _CustomHouseholdLocationSMCPageState();
}

class _CustomHouseholdLocationSMCPageState
    extends LocalizedState<CustomHouseholdLocationSMCPage> {
  static const _administrationAreaKey = 'administrationArea';
  static const _latKey = 'lat';
  static const _lngKey = 'lng';
  static const _accuracyKey = 'accuracy';
  static const maxLength = 64;

  @override
  void initState() {
    final regState = context.read<BeneficiaryRegistrationBloc>().state;
    context.read<LocationBloc>().add(const LoadLocationEvent());
    final router = context.router;

    regState.maybeMap(
      orElse: () => false,
      editHousehold: (value) => false,
      // editIndividual: (value) {
      //   WidgetsBinding.instance.addPostFrameCallback((_) {
      //     router.push(CustomIndividualDetailsSMCRoute());
      //   });
      //   return true;
      // },
      create: (value) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // Show the dialog after the first frame is built
          DigitComponentsUtils().showLocationCapturingDialog(
            context,
            localizations.translate(i18Local.common.locationCapturing),
            DigitSyncDialogType.inProgress,
          );
        });
        return true;
      },
      // addMember: (value) {
      //   WidgetsBinding.instance.addPostFrameCallback((_) {
      //     router
      //         .push(CustomIndividualDetailsSMCRoute(isHeadOfHousehold: false));
      //   });
      //   return true;
      // },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bloc = context.read<BeneficiaryRegistrationBloc>();
    final router = context.router;

    return Scaffold(
      body: BlocBuilder<BeneficiaryRegistrationBloc,
          BeneficiaryRegistrationState>(builder: (context, registrationState) {
        return ReactiveFormBuilder(
          form: () => buildForm(bloc.state),
          builder: (_, form, __) => BlocListener<LocationBloc, LocationState>(
            listener: (context, locationState) {
              registrationState.maybeMap(
                  orElse: () => false,
                  create: (value) {
                    if (locationState.accuracy != null) {
                      //Hide the dialog after 1 seconds
                      Future.delayed(const Duration(seconds: 1), () {
                        DigitComponentsUtils().hideDialog(context);
                      });
                    }
                  });
              if (locationState.accuracy != null) {
                final lat = locationState.latitude;
                final lng = locationState.longitude;
                final accuracy = locationState.accuracy;

                form.control(_latKey).value ??= lat;
                form.control(_lngKey).value ??= lng;
                form.control(_accuracyKey).value ??= accuracy;
              }
            },
            listenWhen: (previous, current) {
              final lat = form.control(_latKey).value;
              final lng = form.control(_lngKey).value;
              final accuracy = form.control(_accuracyKey).value;

              return lat != null || lng != null || accuracy != null
                  ? false
                  : true;
            },
            child: ScrollableContent(
              enableFixedButton: true,
              header: const Column(
                children: [
                  BackNavigationHelpHeaderWidget(
                    showHelp: false,
                  ),
                ],
              ),
              footer: DigitCard(
                margin: const EdgeInsets.fromLTRB(0, kPadding, 0, 0),
                padding: const EdgeInsets.fromLTRB(kPadding, 0, kPadding, 0),
                child: BlocBuilder<LocationBloc, LocationState>(
                  builder: (context, locationState) {
                    return DigitElevatedButton(
                      onPressed: () {
                        form.markAllAsTouched();
                        if (!form.valid) return;

                        registrationState.maybeWhen(orElse: () {
                          return;
                        }, create: (
                          addressModel,
                          householdModel,
                          individualModel,
                          projectBeneficiaryModel,
                          registrationDate,
                          searchQuery,
                          loading,
                          isHeadOfHousehold,
                        ) {
                          var addressModel = AddressModel(
                            type: AddressType.correspondence,
                            latitude: form.control(_latKey).value ??
                                locationState.latitude,
                            longitude: form.control(_lngKey).value ??
                                locationState.longitude,
                            locationAccuracy:
                                form.control(_accuracyKey).value ??
                                    locationState.accuracy,
                            locality: LocalityModel(
                              code: RegistrationDeliverySingleton()
                                  .boundary!
                                  .code!,
                              name: RegistrationDeliverySingleton()
                                  .boundary!
                                  .name,
                            ),
                            tenantId: RegistrationDeliverySingleton().tenantId,
                            rowVersion: 1,
                            auditDetails: AuditDetails(
                              createdBy: RegistrationDeliverySingleton()
                                  .loggedInUserUuid!,
                              createdTime: context.millisecondsSinceEpoch(),
                            ),
                            clientAuditDetails: ClientAuditDetails(
                              createdBy: RegistrationDeliverySingleton()
                                  .loggedInUserUuid!,
                              createdTime: context.millisecondsSinceEpoch(),
                              lastModifiedBy: RegistrationDeliverySingleton()
                                  .loggedInUserUuid,
                              lastModifiedTime:
                                  context.millisecondsSinceEpoch(),
                            ),
                          );

                          bloc.add(
                            BeneficiaryRegistrationSaveAddressEvent(
                              addressModel,
                            ),
                          );

                          router.push(CustomHouseHoldDetailsSMCRoute(
                              isEligible: false));
                        }, editHousehold: (
                          address,
                          householdModel,
                          individuals,
                          registrationDate,
                          projectBeneficiaryModel,
                          loading,
                          headOfHousehold,
                        ) {
                          var addressModel = address.copyWith(
                            type: AddressType.correspondence,
                            latitude: form.control(_latKey).value,
                            longitude: form.control(_lngKey).value,
                            locationAccuracy: form.control(_accuracyKey).value,
                          );
                          // TODO [Linking of Voucher for Household based project  need to be handled]

                          bloc.add(
                            BeneficiaryRegistrationSaveAddressEvent(
                              addressModel,
                            ),
                          );
                          router.push(CustomHouseHoldDetailsSMCRoute(
                              isEligible: false));
                        });
                      },
                      child: Center(
                        child: Text(
                          localizations.translate(
                            i18Local.householdLocation.actionLabel,
                          ),
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
                              i18Local
                                  .householdLocation.householdLocationLabelText,
                            ),
                            headingStyle: theme.textTheme.displayMedium,
                            body: localizations.translate(
                              i18Local.householdLocation
                                  .householdLocationDescriptionText,
                            )),
                        Column(children: [
                          householdLocationShowcaseData.administrativeArea
                              .buildWith(
                            child: DigitTextFormField(
                              formControlName: _administrationAreaKey,
                              label: localizations.translate(
                                i18Local.householdLocation
                                    .administrationAreaFormLabel,
                              ),
                              readOnly: true,
                              isRequired: true,
                              validationMessages: {
                                'required': (_) => localizations.translate(
                                      i18Local.householdLocation
                                          .administrationAreaRequiredValidation,
                                    ),
                              },
                            ),
                          ),
                          householdLocationShowcaseData.gpsAccuracy.buildWith(
                            child: CustomDigitTextFormField(
                              suffixString: localizations.translate(
                                i18Local.common.metersLabel,
                              ),
                              readOnly: true,
                              formControlName: _accuracyKey,
                              label: localizations.translate(
                                  i18.householdLocation.gpsAccuracyLabel),
                              colorCondition: (value) =>
                                  value != null && value > 5,
                            ),
                          ),
                        ]),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  FormGroup buildForm(BeneficiaryRegistrationState state) {
    final addressModel = state.mapOrNull(
      editHousehold: (value) => value.addressModel,
    );

    return fb.group(<String, Object>{
      _administrationAreaKey: FormControl<String>(
        value: localizations.translate(
            RegistrationDeliverySingleton().boundary!.code.toString()),
        validators: [Validators.required],
      ),
      _latKey: FormControl<double>(value: addressModel?.latitude, validators: [
        CustomValidator.requiredMin,
      ]),
      _lngKey: FormControl<double>(
        value: addressModel?.longitude,
      ),
      _accuracyKey: FormControl<double>(
        value: addressModel?.locationAccuracy,
      ),
    });
  }
}
