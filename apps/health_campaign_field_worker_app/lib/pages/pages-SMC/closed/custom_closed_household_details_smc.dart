import 'package:auto_route/auto_route.dart';
import 'package:closed_household/closed_household.dart';
import 'package:closed_household/utils/extensions/extensions.dart';
import 'package:collection/collection.dart';
import 'package:digit_components/digit_components.dart';
import 'package:digit_components/widgets/atoms/selection_card.dart';
import 'package:digit_components/widgets/digit_sync_dialog.dart';
import 'package:digit_components/widgets/atoms/text_block.dart';
import 'package:digit_data_model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:registration_delivery/models/entities/household.dart';
import 'package:registration_delivery/models/entities/household_member.dart';

import 'package:closed_household/utils/i18_key_constants.dart' as i18;
import 'package:registration_delivery/registration_delivery.dart';
import '../../../router/app_router.dart';
import '../../../utils/utils_smc/i18_key_constants.dart' as i18Local;
import '../../../blocs/blocs-smc/closed/closed_household.dart' as custombloc;

import 'package:closed_household/router/closed_household_router.gm.dart';
import 'package:closed_household/utils/utils.dart';
import 'package:closed_household/widgets/back_navigation_help_header.dart';
import 'package:closed_household/widgets/localized.dart';

import '../../../widgets/widgets_smc/custom_digit_text_form_field.dart';

@RoutePage()
class CustomClosedHouseholdDetailsSMCPage extends LocalizedStatefulWidget {
  const CustomClosedHouseholdDetailsSMCPage({
    super.key,
    super.appLocalizations,
  });

  @override
  State<CustomClosedHouseholdDetailsSMCPage> createState() =>
      CustomClosedHouseholdDetailsPageState();
}

class CustomClosedHouseholdDetailsPageState
    extends LocalizedState<CustomClosedHouseholdDetailsSMCPage> {
  static const _administrationAreaKey = 'administrationArea';
  static const _householdHeadNameKey = 'householdHeadName';
  static const _latKey = 'lat';
  static const _lngKey = 'lng';
  static const _accuracyKey = 'accuracy';
  static const _reasonKey = 'reason';
  static const maxLength = 64;

  @override
  void initState() {
    context.read<LocationBloc>().add(const LoadLocationEvent());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Show the dialog after the first frame is built
      DigitComponentsUtils().showLocationCapturingDialog(
        context,
        localizations.translate(i18.common.locationCapturing),
        DigitSyncDialogType.inProgress,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bloc = context.read<ClosedHouseholdBloc>();
    final reasonOptions = ["closed", "refusal", "funeral", "others"];
    //#TODO : Move To MDMS

    return Scaffold(
      body: ReactiveFormBuilder(
        form: () => buildForm(bloc.state),
        builder: (_, form, __) => BlocListener<LocationBloc, LocationState>(
          listener: (context, locationState) {
            if (locationState.accuracy != null) {
              //Hide the dialog after 1 seconds
              Future.delayed(const Duration(seconds: 1), () {
                DigitComponentsUtils().hideDialog(context);
              });
            }
            final lat = locationState.latitude;
            final lng = locationState.longitude;
            final accuracy = locationState.accuracy;
            form.control(_latKey).value ??= lat;
            form.control(_lngKey).value ??= lng;
            form.control(_accuracyKey).value ??= accuracy;
          },
          listenWhen: (previous, current) {
            final lat = form.control(_latKey).value;
            final lng = form.control(_lngKey).value;
            final accuracy = form.control(_accuracyKey).value;

            return lat != null || lng != null || accuracy != null
                ? false
                : true;
          },
          child: BlocBuilder<ClosedHouseholdBloc, ClosedHouseholdState>(
              builder: (context, state) {
            return ScrollableContent(
              enableFixedButton: true,
              header: const Column(
                children: [
                  BackNavigationHelpHeaderWidget(
                    showHelp: false,
                    showcaseButton: null,
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
                        final String? householdHeadName = form
                            .control(_householdHeadNameKey)
                            .value as String?;

                        context.read<custombloc.ClosedHouseholdBloc>().add(
                              custombloc.ClosedHouseholdEvent.handleSummary(
                                latitude: locationState.latitude!,
                                longitude: locationState.longitude!,
                                locationAccuracy: locationState.accuracy!,
                                householdHeadName: householdHeadName != null &&
                                        householdHeadName.trim().isNotEmpty
                                    ? householdHeadName
                                    : null,
                              ),
                            );

                        final reason =
                            form.control(_reasonKey).value as String?;
                        if (reason == null || reason.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                localizations
                                    .translate(i18.common.corecommonRequired),
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }
                        context.router.push(
                            CustomClosedHouseholdSummarySMCRoute(
                                reason: reason));
                      },
                      child: Center(
                        child: Text(
                          localizations.translate(
                            i18.common.coreCommonNext,
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
                          heading: localizations.translate(
                            i18.closeHousehold.closeHouseHoldDetailLabel,
                          ),
                          headingStyle: theme.textTheme.displayMedium,
                          body: localizations.translate(
                            i18.closeHousehold.closeHouseHoldDetailDescLabel,
                          ),
                        ),
                        Column(children: [
                          DigitTextFormField(
                            formControlName: _administrationAreaKey,
                            label: localizations.translate(
                              i18.closeHousehold.villageName,
                            ),
                            readOnly: true,
                          ),
                          CustomDigitTextFormField(
                            suffixString: localizations.translate(
                              i18Local.common.metersLabel,
                            ),
                            readOnly: true,
                            formControlName: _accuracyKey,
                            colorCondition: (value) =>
                                value != null && value > 5,
                            label: localizations.translate(
                              i18.closeHousehold.accuracyLabel,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                kPadding, 0, kPadding, 0),
                            child: SelectionBox<String>(
                              isRequired: true,
                              title: localizations.translate(
                                  i18Local.householdDetails.reasonLabelText),
                              allowMultipleSelection: false,
                              width: 148,
                              initialSelection:
                                  form.control(_reasonKey).value != null
                                      ? [form.control(_reasonKey).value]
                                      : [],
                              options: reasonOptions
                                  .map((e) => e.toUpperCase())
                                  .toList(),
                              onSelectionChanged: (value) {
                                setState(() {
                                  if (value.isNotEmpty) {
                                    form.control(_reasonKey).value =
                                        value.first;
                                  } // todo verify this
                                  else if (true) {
                                    form.control(_reasonKey).value = null;
                                    setState(() {
                                      form
                                          .control(_reasonKey)
                                          .setErrors({'': true});
                                    });
                                  }
                                });
                              },
                              valueMapper: (value) {
                                return localizations.translate(value);
                              },
                              errorMessage: form.control(_reasonKey).hasErrors
                                  ? localizations
                                      .translate(i18.common.corecommonRequired)
                                  : null,
                            ),
                          ),
                          DigitTextFormField(
                            formControlName: _householdHeadNameKey,
                            label: localizations.translate(
                              i18.closeHousehold.headNameLabel,
                            ),
                            validationMessages: {
                              'maxLength': (object) => localizations
                                  .translate(i18.common.maxCharsRequired)
                                  .replaceAll('{}', maxLength.toString()),
                            },
                          ),
                        ]),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  FormGroup buildForm(ClosedHouseholdState state) {
    return fb.group(<String, Object>{
      _administrationAreaKey: FormControl<String>(
        value: localizations
            .translate(ClosedHouseholdSingleton().boundary!.name.toString()),
        validators: [Validators.required],
      ),
      _householdHeadNameKey: FormControl<String>(
        value: null,
        validators: [
          CustomValidator.requiredMin,
          Validators.maxLength(200),
        ],
      ),
      _reasonKey: FormControl<String>(validators: []),
      _latKey: FormControl<double>(validators: []),
      _lngKey: FormControl<double>(),
      _accuracyKey: FormControl<double>(),
    });
  }
}
