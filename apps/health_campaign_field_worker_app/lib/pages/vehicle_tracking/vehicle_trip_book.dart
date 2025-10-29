import 'package:auto_route/auto_route.dart';
import 'package:digit_components/widgets/atoms/digit_text_form_field.dart';
import 'package:digit_components/widgets/atoms/selection_card.dart';
import 'package:digit_components/widgets/digit_dialog.dart' as dialog;
import 'package:digit_components/widgets/digit_text_field.dart';
// import 'package:digit_components/digit_components.dart';
import 'package:digit_data_model/data_model.dart';
import 'package:digit_data_model/models/entities/user_action.dart';
import 'package:digit_ui_components/digit_components.dart';
import 'package:digit_ui_components/services/location_bloc.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/utils/component_utils.dart';
import 'package:digit_ui_components/widgets/atoms/input_wrapper.dart';
import 'package:digit_ui_components/widgets/molecules/digit_card.dart';
import 'package:digit_ui_components/widgets/molecules/show_pop_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:registration_delivery/registration_delivery.dart';
import 'package:registration_delivery/utils/utils.dart';
import 'package:registration_delivery/utils/i18_key_constants.dart' as i18;
import 'package:registration_delivery/widgets/back_navigation_help_header.dart';
import 'package:registration_delivery/widgets/localized.dart';

import '../../../router/app_router.dart';

import '../../../utils/i18_key_constants.dart' as i18_local;
import '../../../models/entities/additional_fields_type.dart'
    as additional_fields_local;
import '../../blocs/app_initialization/app_initialization.dart';
import '../../blocs/vehicle_tracking/vehicle_trip_action.dart';
import '../../models/app_config/app_config_model.dart';
import '../../models/entities/vehicle_tracking/trip_actions.dart';
import '../../utils/utils.dart';
import '../../widgets/showcase/showcase_wrappers.dart';

@RoutePage()
class VehicleTripBookPage extends LocalizedStatefulWidget {
  final String vehicleNo;
  const VehicleTripBookPage({
    super.key,
    super.appLocalizations,
    required this.vehicleNo,
  });

  @override
  State<VehicleTripBookPage> createState() => VehicleTripBookPageState();
}

class VehicleTripBookPageState extends LocalizedState<VehicleTripBookPage> {
  final clickedStatus = ValueNotifier<bool>(false);
  bool? shouldSubmit = false;

  static const _tripBookReasonKey = "tripBookReason";
  static const _otherFieldReasonKey = "otherFieldReason";
  static const _startMileageKey = 'startMileage';
  static const _originKey = 'origin';

  // Variable to track dose administration status
  bool doseAdministered = false;
  // for others reason
  bool otherSelected = false;

// Initialize the currentStep variable to keep track of the current step in a process.
  int currentStep = 0;

  @override
  void initState() {
    context.read<LocationBloc>().add(const LoadLocationEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);
    final vehicleNo = widget.vehicleNo;

    return Scaffold(
      body: BlocBuilder<VehicleTripActionBloc, VehicleTripActionState>(
          builder: (context, vehicleTripActionState) {
        return ReactiveFormBuilder(
            form: () => buildForm(),
            builder: (context, form, child) {
              return ScrollableContent(
                header: const Column(
                  children: [
                    BackNavigationHelpHeaderWidget(
                      showHelp: false,
                    ),
                  ],
                ),
                footer: DigitCard(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, kPadding),
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    children: [
                      ValueListenableBuilder(
                        valueListenable: clickedStatus,
                        builder: (context, bool isClicked, _) {
                          return BlocBuilder<LocationBloc, LocationState>(
                              builder: (context, locationState) {
                            return DigitButton(
                              label: localizations.translate(
                                i18_local.vehicleTracking.startTripButtonLabel,
                              ),
                              isDisabled: false,
                              type: DigitButtonType.secondary,
                              size: DigitButtonSize.large,
                              mainAxisSize: MainAxisSize.max,
                              onPressed: isClicked
                                  ? () {}
                                  : () async {
                                      form.markAllAsTouched();
                                      if (!form.valid) {
                                        Toast.showToast(
                                          context,
                                          type: ToastType.error,
                                          message: localizations.translate(
                                            i18_local.vehicleTracking
                                                .commentRequired,
                                          ),
                                        );
                                        return;
                                      }

                                      final shouldSubmit =
                                          await dialog.DigitDialog.show<bool>(
                                        context,
                                        options: dialog.DigitDialogOptions(
                                          titleText: localizations.translate(
                                            i18.deliverIntervention.dialogTitle,
                                          ),
                                          contentText: localizations.translate(
                                            i18.deliverIntervention
                                                .dialogContent,
                                          ),
                                          primaryAction:
                                              dialog.DigitDialogActions(
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
                                          secondaryAction:
                                              dialog.DigitDialogActions(
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
                                      if ((shouldSubmit ?? false) &&
                                          context.mounted) {
                                        context
                                            .read<LocationBloc>()
                                            .add(const LoadLocationEvent());
                                        handleLocationState(
                                          locationState,
                                          context,
                                          vehicleTripActionState,
                                          form,
                                          vehicleNo,
                                        );
                                      }
                                    },
                            );
                          });
                        },
                      ),
                    ]),
                slivers: [
                  SliverToBoxAdapter(
                    child: DigitCard(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: kPadding),
                          child: Text(
                            localizations.translate(
                              i18_local.vehicleTracking.tripBookLabel,
                            ),
                            style: theme.textTheme.displayMedium,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    kPadding, 0, kPadding, 0),
                                child: BlocBuilder<AppInitializationBloc,
                                        AppInitializationState>(
                                    builder: (context, state) {
                                  if (state is! AppInitialized) {
                                    return const Offstage();
                                  }

                                  final vehicleTrackingTripReasons = state
                                      .appConfiguration
                                      .vehicleTrackingTripReasons;

                                  return SelectionBox<String>(
                                    isRequired: true,
                                    title: localizations.translate(
                                      i18_local
                                          .vehicleTracking.tripBookReasonLabel,
                                    ),
                                    allowMultipleSelection: false,
                                    width: 148,
                                    equalWidthOptions: true,
                                    options: vehicleTrackingTripReasons
                                            ?.map((reason) => reason.code)
                                            .toList() ??
                                        [],
                                    onSelectionChanged: (value) {
                                      form
                                          .control(_tripBookReasonKey)
                                          .markAsTouched();
                                      setState(() {
                                        if (value.isNotEmpty) {
                                          if (value.first == "OTHERS") {
                                            setState(() {
                                              otherSelected = true;
                                              form
                                                  .control(_otherFieldReasonKey)
                                                  .setValidators(
                                                [Validators.required],
                                                autoValidate: true,
                                              );
                                            });
                                          } else {
                                            setState(() {
                                              otherSelected = false;
                                              form
                                                  .control(_otherFieldReasonKey)
                                                  .setValidators(
                                                [],
                                                autoValidate: true,
                                              );
                                            });
                                          }
                                          form
                                              .control(_tripBookReasonKey)
                                              .value = value.first;
                                        } else {
                                          form
                                              .control(_tripBookReasonKey)
                                              .value = null;
                                        }
                                      });
                                    },
                                    valueMapper: (value) {
                                      return localizations.translate(value);
                                    },
                                    errorMessage: null,
                                  );
                                })),
                            Offstage(
                                offstage: !otherSelected,
                                child: Padding(
                                  padding: const EdgeInsets.all(kPadding),
                                  child: ReactiveWrapperField(
                                      formControlName: _otherFieldReasonKey,
                                      builder: (field) {
                                        return InputField(
                                          label: localizations.translate(
                                            i18_local.vehicleTracking
                                                .othersReasonTextLabel,
                                          ),
                                          isRequired: otherSelected,
                                          onChange: (value) {
                                            field.control.markAsTouched();
                                            field.control.value = value;
                                          },
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp(
                                              "[a-zA-Z0-9]",
                                            )),
                                          ],
                                          type: InputType.text,
                                        );
                                      }),
                                )),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  kPadding - 4, 0, kPadding - 4, 0),
                              child: DigitTextFormField(
                                keyboardType: TextInputType.number,
                                formControlName: _startMileageKey,
                                maxLength: 9,
                                label: localizations.translate(
                                  i18_local.vehicleTracking.mileageLabel,
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  kPadding - 4, 0, kPadding - 4, 0),
                              child: DigitTextFormField(
                                formControlName: _originKey,
                                label: localizations.translate(
                                  i18_local.vehicleTracking.originLabel,
                                ),
                                isRequired: true,
                                validationMessages: {
                                  'maxLength': (object) => localizations
                                      .translate(i18.common.maxCharsRequired)
                                      .replaceAll('{}', 100.toString()),
                                },
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            });
      }),
    );
  }

  void handleLocationState(
    LocationState locationState,
    BuildContext context,
    VehicleTripActionState vehicleTripActionState,
    FormGroup form,
    String? vehicleNo,
  ) {
    if (context.mounted) {
      DigitComponentsUtils.showDialog(
        context,
        localizations.translate(i18.common.locationCapturing),
        DialogType.inProgress,
      );

      Future.delayed(const Duration(seconds: 1), () {
        // After delay, hide the initial dialog
        DigitComponentsUtils.hideDialog(context);
        handleCapturedLocationState(
          locationState,
          context,
          vehicleTripActionState,
          form,
          vehicleNo,
        );
      });
    }
  }

  Future<void> handleCapturedLocationState(
    LocationState locationState,
    BuildContext context,
    VehicleTripActionState vehicleTripActionState,
    FormGroup form,
    String? vehicleNo,
  ) async {
    final lat = locationState.latitude;
    final long = locationState.longitude;
    final accuracy = locationState.accuracy;

    UserActionModel? tripBookActionModel = _getTripActionModel(
        lat, long, accuracy, vehicleTripActionState, vehicleNo, form);

    if (tripBookActionModel == null) {
      return;
    }

    context.read<VehicleTripActionBloc>().add(
          VehicleTripActionStartTripEvent(
            isEditing: false,
            boundaryModel: RegistrationDeliverySingleton().boundary!,
            tripBookAction: tripBookActionModel,
            navigateToSummary: true,
          ),
        );
    context.router
        .popUntil((route) => route.settings.name == VehicleSearchRoute.name);
    context.router.push(
      VehicleOverviewRoute(vehicleNo: vehicleNo!),
    );

    // await handleSubmit(context, taskModel, deliverInterventionState);
  }

  UserActionModel? _getTripActionModel(
    double? latitude,
    double? longitude,
    double? locationAccuracy,
    VehicleTripActionState vehicleTripActionState,
    String? vehicleNo,
    FormGroup form,
  ) {
    UserActionModel tripBookAction;
    var clientReferenceId = IdGen.i.identifier;
    var startTime = DateTime.now().millisecondsSinceEpoch;
    final tripBookReason = form.control(_tripBookReasonKey).value as String?;
    final otherFieldReason =
        form.control(_otherFieldReasonKey).value as String?;

    final origin = form.control(_originKey).value as String?;
    final startMileage = form.control(_startMileageKey).value as String?;

    if (latitude == null ||
        longitude == null ||
        locationAccuracy == null ||
        vehicleNo == null) {
      return null;
    }
    tripBookAction = UserActionModel(
        latitude: latitude,
        longitude: longitude,
        locationAccuracy: locationAccuracy,
        clientReferenceId: clientReferenceId,
        isSync: false,
        timestamp: startTime,
        projectId: RegistrationDeliverySingleton().projectId!,
        boundaryCode: RegistrationDeliverySingleton().boundary?.code! ?? "",
        action: TripActions.start.toValue(),
        beneficiaryTag: vehicleNo,
        additionalFields: UserActionAdditionalFields(version: 1, fields: [
          AdditionalField("vehicleNo", vehicleNo),
          if (tripBookReason != null)
            AdditionalField(_tripBookReasonKey, tripBookReason),
          if (otherFieldReason != null)
            AdditionalField(_otherFieldReasonKey, otherFieldReason),
          if (origin != null && origin.isNotEmpty && origin.length > 1)
            AdditionalField(_originKey, origin),
          if (startMileage != null &&
              startMileage.isNotEmpty &&
              startMileage.length > 1)
            AdditionalField(_startMileageKey, startMileage),
          if (otherFieldReason != null)
            AdditionalField(_otherFieldReasonKey, otherFieldReason),
          AdditionalField("tripStartTime", startTime)
        ]));

    return tripBookAction;
  }

  FormGroup buildForm() {
    return fb.group(<String, Object>{
      _tripBookReasonKey:
          FormControl<String>(validators: [Validators.required]),
      _otherFieldReasonKey: FormControl<String>(
        validators: [],
      ),
      _startMileageKey: FormControl<String>(),
      _originKey: FormControl<String>(validators: [Validators.maxLength(100)]),
    });
  }
}
