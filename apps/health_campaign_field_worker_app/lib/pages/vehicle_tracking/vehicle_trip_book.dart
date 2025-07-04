import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:digit_components/widgets/atoms/selection_card.dart';
import 'package:digit_components/widgets/digit_dialog.dart' as dialog;
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
import '../../blocs/vehicle_tracking/vehicle_trip_action.dart';
import '../../models/entities/vehicle_tracking/trip_actions.dart';
import '../../widgets/showcase/showcase_wrappers.dart';

@RoutePage()
class VehicleTripBookPage extends LocalizedStatefulWidget {
  const VehicleTripBookPage({
    super.key,
    super.appLocalizations,
  });

  @override
  State<VehicleTripBookPage> createState() => VehicleTripBookPageState();
}

class VehicleTripBookPageState extends LocalizedState<VehicleTripBookPage> {
  final clickedStatus = ValueNotifier<bool>(false);
  bool? shouldSubmit = false;

  static const _tripBookReasonKey = "tripBookReason";

  List<String> reasons = ["Reason1", "Reason2", "Reason3", "Reason4"];

  // Variable to track dose administration status
  bool doseAdministered = false;

  // List of controllers for form elements
  final List _controllers = [];

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
                                          null,
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
                              child: SelectionBox<String>(
                                isRequired: true,
                                title: localizations.translate(
                                  i18_local.vehicleTracking.tripBookReasonLabel,
                                ),
                                allowMultipleSelection: false,
                                width: 148,
                                initialSelection: [],
                                options: reasons,
                                onSelectionChanged: (value) {
                                  setState(() {
                                    if (value.isNotEmpty) {
                                      form.control(_tripBookReasonKey).value =
                                          value.first;
                                    }
                                  });
                                },
                                valueMapper: (value) {
                                  return localizations.translate(value);
                                },
                                errorMessage: null,
                              ),
                            ),
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
    IndividualModel? selectedIndividual,
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
          form,
          selectedIndividual,
        );
      });
    }
  }

  Future<void> handleCapturedLocationState(
    LocationState locationState,
    BuildContext context,
    VehicleTripActionState vehicleTripActionState,
    FormGroup form,
    IndividualModel? selectedIndividual,
  ) async {
    final lat = locationState.latitude;
    final long = locationState.longitude;
    final accuracy = locationState.accuracy;

    final tripBookActionModel = _getTripActionModel(lat, long, accuracy,
        vehicleTripActionState, ProductVariantModel(id: ""));

    context.read<VehicleTripActionBloc>().add(
          VehicleTripActionStartTripEvent(
            isEditing: false,
            boundaryModel: RegistrationDeliverySingleton().boundary!,
            tripBookAction: tripBookActionModel,
            navigateToSummary: true,
          ),
        );

    // await handleSubmit(context, taskModel, deliverInterventionState);
  }

  UserActionModel _getTripActionModel(
    double? latitude,
    double? longitude,
    double? locationAccuracy,
    VehicleTripActionState vehicleTripActionState,
    ProductVariantModel selectedVehicle,
  ) {
    UserActionModel tripBookAction;
    var clientReferenceId = IdGen.i.identifier;

    var vehcileNo = selectedVehicle.variation;
    tripBookAction = UserActionModel(
        latitude: latitude!,
        longitude: longitude!,
        locationAccuracy: locationAccuracy!,
        clientReferenceId: clientReferenceId,
        isSync: true,
        timestamp: 0,
        projectId: RegistrationDeliverySingleton().projectId!,
        boundaryCode: RegistrationDeliverySingleton().boundary?.code! ?? "",
        action: TripActions.start.toString(),
        additionalFields: UserActionAdditionalFields(version: 1, fields: [
          if (vehcileNo != null) AdditionalField("vehcileNo", vehcileNo)
        ]));

    return tripBookAction;
  }

  FormGroup buildForm() {
    return fb.group(<String, Object>{
      _tripBookReasonKey: FormControl<String>(),
    });
  }
}
