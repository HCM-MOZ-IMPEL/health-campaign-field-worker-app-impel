import 'package:auto_route/auto_route.dart';
import 'package:digit_components/digit_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:registration_delivery/registration_delivery.dart';

import 'package:registration_delivery/router/registration_delivery_router.gm.dart';
import 'package:registration_delivery/utils/i18_key_constants.dart' as i18;
import 'package:registration_delivery/widgets/localized.dart';

import '../../router/app_router.dart';

@RoutePage()
class CustomHouseholdAcknowledgementPage extends LocalizedStatefulWidget {
  final bool? enableViewHousehold;

  const CustomHouseholdAcknowledgementPage({
    super.key,
    super.appLocalizations,
    this.enableViewHousehold,
  });

  @override
  State<CustomHouseholdAcknowledgementPage> createState() =>
      CustomHouseholdAcknowledgementPageState();
}

class CustomHouseholdAcknowledgementPageState
    extends LocalizedState<CustomHouseholdAcknowledgementPage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: BlocBuilder<HouseholdOverviewBloc, HouseholdOverviewState>(
          builder: (context, householdState) {
            return DigitAcknowledgement.success(
              action: () {
                final parent = context.router.parent() as StackRouter;
                // Pop twice to navigate back to the previous screen
                parent.popUntilRoot();
              },
              secondaryAction: () {
                final wrapper = context
                    .read<HouseholdOverviewBloc>()
                    .state
                    .householdMemberWrapper;

                final parent = context.router.parent() as StackRouter;

                context.router.popAndPush(
                  CustomHouseholdWrapperRoute(wrapper: wrapper),
                );
                // Pop twice to navigate back to the previous screen
                parent.popUntilRouteWithName(CustomSearchBeneficiaryRoute.name);
              },
              enableViewHousehold: widget.enableViewHousehold ?? false,
              secondaryLabel: localizations.translate(
                i18.householdDetails.viewHouseHoldDetailsAction,
              ),
              actionLabel: localizations
                  .translate(i18.acknowledgementSuccess.actionLabelText),
              description: localizations.translate(
                i18.acknowledgementSuccess.acknowledgementDescriptionText,
              ),
              label: localizations.translate(
                i18.acknowledgementSuccess.acknowledgementLabelText,
              ),
            );
          },
        ),
      ),
    );
  }
}
