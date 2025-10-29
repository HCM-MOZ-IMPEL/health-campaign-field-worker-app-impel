import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
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
import 'package:digit_ui_components/widgets/atoms/digit_stepper.dart';
import 'package:digit_ui_components/widgets/atoms/pop_up_card.dart';
import 'package:digit_ui_components/widgets/molecules/digit_card.dart';
import 'package:digit_ui_components/widgets/molecules/show_pop_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_campaign_field_worker_app/blocs/auth/auth.dart';
import 'package:health_campaign_field_worker_app/utils/constants.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:registration_delivery/models/entities/deliver_strategy_type.dart';
import 'package:registration_delivery/registration_delivery.dart';
import 'package:registration_delivery/router/registration_delivery_router.gm.dart';
import 'package:registration_delivery/utils/extensions/extensions.dart';
import 'package:registration_delivery/utils/utils.dart';

import 'package:registration_delivery/models/entities/additional_fields_type.dart';
import 'package:registration_delivery/models/entities/status.dart';
import 'package:registration_delivery/utils/i18_key_constants.dart' as i18;
import 'package:registration_delivery/widgets/back_navigation_help_header.dart';
import 'package:registration_delivery/widgets/beneficiary/resource_beneficiary_card.dart';
import 'package:registration_delivery/widgets/component_wrapper/product_variant_bloc_wrapper.dart';
import 'package:registration_delivery/widgets/localized.dart';

import '../../../router/app_router.dart';

import '../../../utils/i18_key_constants.dart' as i18_local;
import '../../../models/entities/additional_fields_type.dart'
    as additional_fields_local;
import '../../blocs/app_initialization/app_initialization.dart';
import '../../blocs/vehicle_tracking/vehicle_trip_action.dart';
import '../../models/entities/vehicle_tracking/trip_actions.dart';
import '../../widgets/showcase/showcase_wrappers.dart';

@RoutePage()
class VehicleTripFeedbackPage extends LocalizedStatefulWidget {
  final String vehicleNo;
  const VehicleTripFeedbackPage({
    super.key,
    super.appLocalizations,
    required this.vehicleNo,
  });

  @override
  State<VehicleTripFeedbackPage> createState() =>
      VehicleTripFeedbackPageState();
}

class VehicleTripFeedbackPageState
    extends LocalizedState<VehicleTripFeedbackPage> {
  final clickedStatus = ValueNotifier<bool>(false);
  bool? shouldSubmit = false;

  static const _tripFeedbackEvaluationKey = "tripFeedbackEvaluation";
  static const _tripFeedbackCommentKey = "tripFeedbackComment";

  // for others reason
  final TextEditingController otherFieldReasonController =
      TextEditingController();
  bool otherSelected = false;

  @override
  void initState() {
    context.read<LocationBloc>().add(const LoadLocationEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final vehicleNo = widget.vehicleNo;

    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
          builder: (context, locationState) {
        return ReactiveFormBuilder(
            form: () => buildForm(),
            builder: (context, form, child) {
              final tripEvaluation =
                  form.control(_tripFeedbackEvaluationKey).value as String?;
              final tripComment =
                  form.control(_tripFeedbackCommentKey).value as String?;
              return BlocBuilder<VehicleTripActionBloc, VehicleTripActionState>(
                builder: (context, vehicleTripActionState) {
                  UserActionModel? tripAction = _getTripActionModel(
                      vehicleTripActionState, tripEvaluation, tripComment);
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
                              return DigitButton(
                                  label: localizations.translate(
                                    i18_local
                                        .vehicleTracking.endTripButtonLabel,
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
                                            return;
                                          }

                                          final shouldSubmit = await dialog
                                              .DigitDialog.show<bool>(
                                            context,
                                            options: dialog.DigitDialogOptions(
                                              titleText:
                                                  localizations.translate(
                                                i18.deliverIntervention
                                                    .dialogTitle,
                                              ),
                                              contentText:
                                                  localizations.translate(
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
                                                action: (context) =>
                                                    Navigator.of(
                                                  context,
                                                  rootNavigator: true,
                                                ).pop(false),
                                              ),
                                            ),
                                          );
                                          if ((shouldSubmit ?? false) &&
                                              context.mounted &&
                                              tripAction != null) {
                                            handleLocationState(
                                                locationState,
                                                context,
                                                vehicleTripActionState,
                                                widget.vehicleNo,
                                                form);
                                          }
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
                                  i18_local.vehicleTracking.feedbackLabel,
                                ),
                                style: theme.textTheme.displayMedium,
                              ),
                            ),
                            Column(
                              children: [
                                DigitTextFormField(
                                  label: localizations.translate(
                                    i18_local.vehicleTracking.tripComment,
                                  ),
                                  validationMessages: {
                                    "required": (control) {
                                      return localizations.translate(
                                        '${i18_local.vehicleTracking.tripComment}_IS_REQUIRED',
                                      );
                                    },
                                  },
                                  textCapitalization: TextCapitalization.none,
                                  formControlName: _tripFeedbackCommentKey,
                                  isRequired: false,
                                  keyboardType: TextInputType.text,
                                ),
                              ],
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

                                      final vehicleTrackingTripEvaluationReasons =
                                          state.appConfiguration
                                              .vehicleTrackingTripEvaluationReasons;

                                      return SelectionBox<String>(
                                        isRequired: true,
                                        title: localizations.translate(
                                          i18_local.vehicleTracking
                                              .tripBookReasonLabel,
                                        ),
                                        allowMultipleSelection: false,
                                        width: 148,
                                        equalWidthOptions: true,
                                        options:
                                            vehicleTrackingTripEvaluationReasons
                                                    ?.map(
                                                        (reason) => reason.code)
                                                    .toList() ??
                                                [
                                                  "Excellent – Very professional and safe",
                                                  "Good – Smooth and comfortable",
                                                  "Average – Could improve",
                                                  "Poor – Unpleasant or unsafe"
                                                ],
                                        onSelectionChanged: (value) {
                                          form
                                              .control(
                                                  _tripFeedbackEvaluationKey)
                                              .markAsTouched();
                                          setState(() {
                                            if (value.isNotEmpty) {
                                              if (value.first == "Others") {
                                                setState(() {
                                                  otherSelected = true;
                                                });
                                              } else {
                                                setState(() {
                                                  otherSelected = false;
                                                });
                                              }
                                              form
                                                  .control(
                                                      _tripFeedbackEvaluationKey)
                                                  .value = value.first;
                                            } else {
                                              form
                                                  .control(
                                                      _tripFeedbackEvaluationKey)
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
                                // Padding(
                                //   padding: const EdgeInsets.all(kPadding),
                                //   child: DigitTextField(
                                //       label: localizations.translate(
                                //         i18_local
                                //             .vehicleTracking.othersReasonTextLabel,
                                //       ),
                                //       isRequired: otherSelected,
                                //       controller: otherFieldReasonController,
                                //       inputFormatter: [
                                //         FilteringTextInputFormatter.allow(RegExp(
                                //           "[a-zA-Z0-9]",
                                //         )),
                                //       ]),
                                // )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            });
      }),
    );
  }

  void handleLocationState(
    LocationState locationState,
    BuildContext context,
    VehicleTripActionState vehicleTripActionState,
    String? vehicleNo,
    FormGroup form,
  ) {
    if (context.mounted) {
      DigitComponentsUtils.showDialog(
        context,
        localizations.translate(i18.common.locationCapturing),
        DialogType.inProgress,
      );

      Future.delayed(const Duration(seconds: 0), () {
        // After delay, hide the initial dialog
        DigitComponentsUtils.hideDialog(context);
        handleCapturedLocationState(
          locationState,
          context,
          vehicleTripActionState,
          vehicleNo,
          form,
        );
      });
    }
  }

  Future<void> handleCapturedLocationState(
    LocationState locationState,
    BuildContext context,
    VehicleTripActionState vehicleTripActionState,
    String? vehicleNo,
    FormGroup form,
  ) async {
    // if all null then put 0
    final lat = locationState.latitude ??
        vehicleTripActionState.tripAction?.latitude ??
        0;
    final long = locationState.longitude ??
        vehicleTripActionState.tripAction?.longitude ??
        0;
    final accuracy = locationState.accuracy ??
        vehicleTripActionState.tripAction?.locationAccuracy ??
        0;
    final tripEvaluation =
        form.control(_tripFeedbackEvaluationKey).value as String?;
    final tripComment = form.control(_tripFeedbackCommentKey).value as String?;

    final tripActionEndTrip = _getTripActionModel(
        vehicleTripActionState, tripEvaluation, tripComment);

    context.read<VehicleTripActionBloc>().add(
          VehicleTripActionEndTripEvent(
              isEditing: true,
              boundaryModel: RegistrationDeliverySingleton().boundary!,
              vehicleNo: vehicleNo ?? widget.vehicleNo,
              longitude: long,
              latitude: lat,
              locationAccurracy: accuracy,
              tripAction: tripActionEndTrip!),
        );
    context.router.push(
      VehicleAcknowledgementRoute(),
    );
  }

  UserActionModel? _getTripActionModel(
    VehicleTripActionState vehicleTripActionState,
    String? tripEvaluation,
    String? tripComment,
  ) {
    UserActionModel? tripBookAction = vehicleTripActionState.tripAction;

    if (tripBookAction == null) {
      return null;
    }

    Set keys = {
      _tripFeedbackCommentKey,
      _tripFeedbackEvaluationKey,
    };

    List<AdditionalField> additionalFields =
        tripBookAction.additionalFields?.fields ?? [];

    additionalFields =
        additionalFields.whereNot((e) => keys.contains(e)).toList();

    tripBookAction = tripBookAction.copyWith(
        additionalFields: UserActionAdditionalFields(version: 1, fields: [
      ...additionalFields,
      if (tripComment != null)
        AdditionalField(_tripFeedbackCommentKey, tripComment),
      if (tripEvaluation != null)
        AdditionalField(_tripFeedbackEvaluationKey, tripEvaluation),
    ]));

    return tripBookAction;
  }

  FormGroup buildForm() {
    return fb.group(<String, Object>{
      _tripFeedbackCommentKey: FormControl<String>(),
      _tripFeedbackEvaluationKey:
          FormControl<String>(validators: [Validators.required]),
    });
  }
}
