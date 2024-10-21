import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:digit_components/digit_components.dart';
import 'package:digit_data_model/models/entities/beneficiary_type.dart';
import 'package:digit_data_model/models/entities/identifier_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:registration_delivery/blocs/household_overview/household_overview.dart';
import 'package:registration_delivery/blocs/search_households/search_households.dart';

import 'package:registration_delivery/utils/i18_key_constants.dart' as i18;
import '../../../utils/utils_smc/i18_key_constants.dart' as i18_local;
import 'package:registration_delivery/utils/utils.dart';
import 'package:registration_delivery/widgets/localized.dart';
import 'package:registration_delivery/blocs/search_households/search_bloc_common_wrapper.dart';
import 'package:registration_delivery/router/registration_delivery_router.gm.dart';

import '../../../router/app_router.dart';
import '../../../utils/environment_config.dart';

@RoutePage()
class CustomBeneficiaryAcknowledgementSMCPage extends LocalizedStatefulWidget {
  final bool? enableViewHousehold;

  const CustomBeneficiaryAcknowledgementSMCPage({
    super.key,
    super.appLocalizations,
    this.enableViewHousehold,
  });

  @override
  State<CustomBeneficiaryAcknowledgementSMCPage> createState() =>
      CustomBeneficiaryAcknowledgementSMCPageState();
}

class CustomBeneficiaryAcknowledgementSMCPageState
    extends LocalizedState<CustomBeneficiaryAcknowledgementSMCPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DigitAcknowledgement.success(
        action: () {
          final parent = context.router.parent() as StackRouter;
          parent.popUntilRouteWithName(CustomSearchBeneficiarySMCRoute.name);
        },
        secondaryAction: () {
          final parent = context.router.parent() as StackRouter;
          final searchBlocState = context.read<SearchBlocWrapper>().state;

          Future.delayed(
            const Duration(
              milliseconds: 0,
            ),
            () {
              HouseholdMemberWrapper? memberWrapper =
                  searchBlocState.householdMembers.isEmpty
                      ? null
                      : searchBlocState.householdMembers.first;
              memberWrapper = searchBlocState.householdMembers.firstOrNull;
            },
          ).then((value) {
            parent.popUntilRouteWithName(CustomSearchBeneficiarySMCRoute.name);
            parent.push(
              BeneficiaryWrapperRoute(
                wrapper: searchBlocState.householdMembers.firstOrNull!,
              ),
            );
          });
        },
        enableViewHousehold: widget.enableViewHousehold ?? false,
        secondaryLabel: localizations.translate(
          i18_local.householdDetails.viewHouseHoldDetailsActionSMC,
        ),
        subLabel: getSubText(),
        actionLabel:
            localizations.translate(i18.acknowledgementSuccess.actionLabelText),
        description: localizations.translate(
          i18.acknowledgementSuccess.acknowledgementDescriptionText,
        ),
        label: localizations
            .translate(i18.acknowledgementSuccess.acknowledgementLabelText),
      ),
    );
  }

  getSubText() {
    HouseholdMemberWrapper wrapper =
        context.read<SearchBlocWrapper>().state.householdMembers.last;

    return wrapper != null
        ? '${localizations.translate(i18.beneficiaryDetails.beneficiaryId)}\n'
            '${wrapper.members?.lastOrNull!.name!.givenName} - '
            '${wrapper.members?.lastOrNull!.identifiers!.lastWhereOrNull(
                  (e) =>
                      e.identifierType ==
                      IdentifierTypes.uniqueBeneficiaryID.toValue(),
                )!.identifierId ?? localizations.translate(i18.common.noResultsFound)}'
        : '';
  }
}
