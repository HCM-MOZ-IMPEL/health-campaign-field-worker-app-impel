import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:digit_components/widgets/atoms/selection_card.dart';
import 'package:digit_components/widgets/digit_dialog.dart' as dialog;
// import 'package:digit_components/digit_components.dart';
import 'package:digit_data_model/data_model.dart';
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
      body: ScrollableContent(
        header: const Column(
          children: [
            BackNavigationHelpHeaderWidget(
              showHelp: false,
            ),
          ],
        ),
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
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
                        padding: EdgeInsets.fromLTRB(kPadding, 0, kPadding, 0),
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
                            // setState(() {
                            //   if (value.isNotEmpty) {
                            //     form.control(_genderKey).value = value.first;
                            //   } else if (isEligible) {
                            //     form.control(_genderKey).value = null;
                            //     setState(() {
                            //       form.control(_genderKey).setErrors({'': true});
                            //     });
                            //   }
                            // });
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
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: 50,
        child: Card(
          margin: const EdgeInsets.all(0),
          child: Container(
            padding: const EdgeInsets.fromLTRB(kPadding, 0, kPadding, 0),
            child: Column(
              children: [
                DigitButton(
                  label: localizations.translate(
                      i18_local.vehicleTracking.bookTripButtonActionLabel),
                  onPressed: () {},
                  type: DigitButtonType.secondary,
                  size: DigitButtonSize.large,
                  mainAxisSize: MainAxisSize.max,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  FormGroup buildForm() {
    return fb.group(<String, Object>{
      _tripBookReasonKey: FormControl<String>(),
    });
  }
}
