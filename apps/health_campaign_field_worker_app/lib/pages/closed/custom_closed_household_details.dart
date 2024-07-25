import 'package:auto_route/auto_route.dart';
import 'package:closed_household/closed_household.dart';
import 'package:digit_components/digit_components.dart';
import 'package:digit_components/widgets/digit_sync_dialog.dart';
import 'package:digit_components/widgets/atoms/text_block.dart';
import 'package:digit_data_model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'package:closed_household/utils/i18_key_constants.dart' as i18;
import 'package:closed_household/router/closed_household_router.gm.dart';
import 'package:closed_household/widgets/back_navigation_help_header.dart';
import 'package:closed_household/widgets/localized.dart';
import 'package:closed_household/utils/utils.dart';

import '../../router/app_router.dart';
import '../../widgets/custom_digit_text_form_field.dart';

@RoutePage()
class CustomClosedHouseholdDetailsPage extends LocalizedStatefulWidget {
  const CustomClosedHouseholdDetailsPage({
    super.key,
    super.appLocalizations,
  });

  @override
  State<CustomClosedHouseholdDetailsPage> createState() =>
      CustomClosedHouseholdDetailsPageState();
}

class CustomClosedHouseholdDetailsPageState
    extends LocalizedState<CustomClosedHouseholdDetailsPage> {
  static const _administrationAreaKey = 'administrationArea';
  static const _householdHeadNameKey = 'householdHeadName';
  static const _latKey = 'lat';
  static const _lngKey = 'lng';
  static const _accuracyKey = 'accuracy';
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
    final router = context.router;

    return Scaffold(
      body: ReactiveFormBuilder(
        form: () => buildForm(bloc.state),
        builder: (_, form, __) => BlocListener<LocationBloc, LocationState>(
          listener: (context, locationState) {
            if (locationState.accuracy != null) {
              //Hide the dialog after 1 seconds
              Future.delayed(const Duration(seconds: 1), () {
                DigitComponentsUtils().hideLocationDialog(context);
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
                    //showcaseButton: ShowcaseButton(), //TODO:
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
                        final summary = UserActionModel(
                          clientReferenceId: IdGen.i.identifier,
                          latitude: form.control(_latKey).value,
                          longitude: form.control(_lngKey).value,
                          locationAccuracy: form.control(_accuracyKey).value,
                          additionalFields: form
                                      .control(_householdHeadNameKey)
                                      .value !=
                                  null
                              ? UserActionAdditionalFields(
                                  version: 1,
                                  fields: [
                                    AdditionalField(
                                      'householdHead',
                                      form
                                              .control(_householdHeadNameKey)
                                              .value ??
                                          '',
                                    ),
                                  ],
                                )
                              : null,
                        );
                        context.read<ClosedHouseholdBloc>().add(
                              ClosedHouseholdEvent.handleSummary(summary),
                            );
                        context.router
                            .push(CustomClosedHouseholdSummaryRoute());
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
                            readOnly: true,
                            formControlName: _accuracyKey,
                            colorCondition: (value) =>
                                value != null && value > 5,
                            label: localizations.translate(
                              i18.closeHousehold.accuracyLabel,
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
        validators: [
          Validators.maxLength(200),
        ],
      ),
      _latKey: FormControl<double>(
          value: state.userActions?.first.latitude, validators: []),
      _lngKey: FormControl<double>(
        value: state.userActions?.first.longitude,
      ),
      _accuracyKey: FormControl<double>(
        value: state.userActions?.first.locationAccuracy,
      ),
    });
  }
}