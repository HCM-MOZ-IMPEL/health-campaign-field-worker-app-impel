import 'package:auto_route/auto_route.dart';
import 'package:digit_components/digit_components.dart';
import 'package:digit_components/widgets/atoms/details_card.dart';
import 'package:digit_data_model/blocs/product_variant/product_variant.dart';
import 'package:digit_data_model/models/entities/beneficiary_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_campaign_field_worker_app/utils/constants.dart';
import 'package:recase/recase.dart';
import 'package:registration_delivery/blocs/delivery_intervention/deliver_intervention.dart';
import 'package:registration_delivery/blocs/household_overview/household_overview.dart';
import 'package:registration_delivery/blocs/search_households/search_households.dart';
import 'package:registration_delivery/models/entities/additional_fields_type.dart';
import 'package:registration_delivery/models/entities/status.dart';
import 'package:registration_delivery/router/registration_delivery_router.gm.dart';
import 'package:registration_delivery/utils/utils.dart';
import 'package:registration_delivery/widgets/back_navigation_help_header.dart';
import 'package:registration_delivery/widgets/component_wrapper/product_variant_bloc_wrapper.dart';
import 'package:registration_delivery/widgets/showcase/showcase_button.dart';

import 'package:registration_delivery/widgets/localized.dart';
import 'package:registration_delivery/utils/i18_key_constants.dart' as i18;
import '../../utils/i18_key_constants.dart' as i18Local;
import 'package:collection/collection.dart';

import '../router/app_router.dart';

@RoutePage()
class IneligibleSummaryPage extends LocalizedStatefulWidget {
  final bool isEligible;
  final HouseholdMemberWrapper? previousWrapper;

  const IneligibleSummaryPage({
    super.key,
    super.appLocalizations,
    required this.isEligible,
    this.previousWrapper,
  });

  @override
  State<IneligibleSummaryPage> createState() => IneligibleSummaryPageState();
}

class IneligibleSummaryPageState extends LocalizedState<IneligibleSummaryPage> {
  final clickedStatus = ValueNotifier<bool>(false);

  String getLocalizedMessage(String code) {
    return localizations.translate(code);
  }

  @override
  Widget build(BuildContext context) {
    return ProductVariantBlocWrapper(
      child: Scaffold(
          body: BlocConsumer<DeliverInterventionBloc, DeliverInterventionState>(
        listener: (context, deliverState) {
          final router = context.router;
        },
        builder: (context, deliverState) {
          return ScrollableContent(
              enableFixedButton: true,
              header: Column(children: [
                BackNavigationHelpHeaderWidget(
                  showHelp: false,
                  handleBack: () {
                    if (deliverState.householdMemberWrapper?.household !=
                        null) {
                      context.read<SearchHouseholdsBloc>().add(
                            SearchHouseholdsEvent.searchByHousehold(
                              householdModel: deliverState
                                  .householdMemberWrapper!.household!,
                              projectId:
                                  RegistrationDeliverySingleton().projectId!,
                              isProximityEnabled: false,
                            ),
                          );
                    }
                    final parent = context.router.parent() as StackRouter;
                    parent.popUntilRouteWithName(
                        CustomSearchBeneficiaryRoute.name);
                  },
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: kPadding, left: kPadding),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      localizations.translate(
                        i18.common.coreCommonSummaryDetails,
                      ),
                      style: DigitTheme
                          .instance.mobileTheme.textTheme.displayMedium,
                    ),
                  ),
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
                              final submit = await DigitDialog.show<bool>(
                                context,
                                options: DigitDialogOptions(
                                  titleText: localizations.translate(
                                      i18.deliverIntervention.dialogTitle),
                                  contentText: localizations.translate(
                                      i18.deliverIntervention.dialogContent),
                                  primaryAction: DigitDialogActions(
                                    label: localizations
                                        .translate(i18.common.coreCommonSubmit),
                                    action: (ctx) {
                                      clickedStatus.value = true;
                                      Navigator.of(context, rootNavigator: true)
                                          .pop(true);
                                    },
                                  ),
                                  secondaryAction: DigitDialogActions(
                                    label: localizations
                                        .translate(i18.common.coreCommonCancel),
                                    action: (context) => Navigator.of(context,
                                            rootNavigator: true)
                                        .pop(false),
                                  ),
                                ),
                              );
                              if (submit ?? false) {
                                if (context.mounted) {
                                  context.read<DeliverInterventionBloc>().add(
                                        DeliverInterventionSubmitEvent(
                                          task: deliverState.oldTask!,
                                          isEditing: (deliverState
                                                              .householdMemberWrapper
                                                              ?.tasks ??
                                                          [])
                                                      .isNotEmpty &&
                                                  RegistrationDeliverySingleton()
                                                          .beneficiaryType ==
                                                      BeneficiaryType.household
                                              ? true
                                              : false,
                                          boundaryModel:
                                              RegistrationDeliverySingleton()
                                                  .boundary!,
                                        ),
                                      );

                                  if (deliverState.futureDeliveries != null &&
                                      deliverState
                                          .futureDeliveries!.isNotEmpty &&
                                      RegistrationDeliverySingleton()
                                              .projectType
                                              ?.cycles
                                              ?.isNotEmpty ==
                                          true) {
                                    context.router.popUntilRouteWithName(
                                      BeneficiaryWrapperRoute.name,
                                    );
                                    context.router.push(
                                      SplashAcknowledgementRoute(
                                        enableBackToSearch: false,
                                      ),
                                    );
                                  } else {
                                    Future.delayed(
                                      const Duration(
                                        milliseconds: 100,
                                      ),
                                      () {
                                        if (deliverState.householdMemberWrapper
                                                ?.household !=
                                            null) {
                                          context
                                              .read<SearchHouseholdsBloc>()
                                              .add(
                                                SearchHouseholdsEvent
                                                    .searchByHousehold(
                                                  householdModel: deliverState
                                                      .householdMemberWrapper!
                                                      .household!,
                                                  projectId:
                                                      RegistrationDeliverySingleton()
                                                          .projectId!,
                                                  isProximityEnabled: false,
                                                ),
                                              );
                                        }
                                      },
                                    ).then(
                                      (value) {
                                        context.router.push(
                                            CustomBeneficiaryAcknowledgementRoute(
                                          enableViewHousehold: true,
                                        ));
                                      },
                                    );
                                  }
                                }
                              }
                            },
                      child: Center(
                        child: Text(
                          localizations.translate(i18.common.coreCommonNext),
                        ),
                      ),
                    );
                  },
                ),
              ),
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      DigitCard(
                        child: LabelValueList(
                            heading: localizations.translate(i18
                                .householdLocation.householdLocationLabelText),
                            withDivider: true,
                            items: [
                              LabelValuePair(
                                  label: localizations.translate(
                                      i18.householdLocation.villageLabel),
                                  value: deliverState.householdMemberWrapper
                                          ?.household?.address?.locality?.code
                                          .split('_')
                                          .last
                                          .titleCase ??
                                      localizations
                                          .translate(i18.common.coreCommonNA),
                                  isInline: true),
                            ]),
                      ),
                      DigitCard(
                        child: LabelValueList(
                            heading: localizations.translate(
                                i18.householdDetails.householdDetailsLabel),
                            withDivider: true,
                            items: [
                              LabelValuePair(
                                  label: localizations.translate(
                                      i18.beneficiaryDetails.totalMembers),
                                  value: deliverState.householdMemberWrapper
                                          ?.household?.memberCount
                                          .toString() ??
                                      '0',
                                  isInline: true),
                              if (widget.isEligible)
                                LabelValuePair(
                                    label: localizations.translate(i18
                                        .householdDetails
                                        .noOfPregnantWomenCountLabel),
                                    value: deliverState
                                            .householdMemberWrapper
                                            ?.household
                                            ?.additionalFields
                                            ?.fields
                                            .where((h) =>
                                                h.key ==
                                                AdditionalFieldsType
                                                    .pregnantWomen
                                                    .toValue())
                                            .firstOrNull
                                            ?.value
                                            .toString() ??
                                        '0',
                                    isInline: true),
                              if (widget.isEligible)
                                LabelValuePair(
                                    label: localizations.translate(i18
                                        .householdDetails
                                        .noOfChildrenBelow5YearsLabel),
                                    value: deliverState
                                            .householdMemberWrapper
                                            ?.household
                                            ?.additionalFields
                                            ?.fields
                                            .where((h) =>
                                                h.key ==
                                                AdditionalFieldsType.children
                                                    .toValue())
                                            .firstOrNull
                                            ?.value
                                            .toString() ??
                                        '0',
                                    isInline: true),
                            ]),
                      ),
                      DigitCard(
                        child: LabelValueList(
                            heading: localizations.translate(
                                i18.householdDetails.houseDetailsLabel),
                            withDivider: true,
                            items: [
                              LabelValuePair(
                                  label: localizations.translate(
                                      i18.householdDetails.noOfRoomsLabel),
                                  value: deliverState.householdMemberWrapper
                                          ?.household?.additionalFields?.fields
                                          .where((h) =>
                                              h.key ==
                                              AdditionalFieldsType.noOfRooms
                                                  .toValue())
                                          .firstOrNull
                                          ?.value
                                          .toString() ??
                                      '0',
                                  isInline: true),
                              LabelValuePair(
                                  label: localizations.translate(
                                      i18.householdDetails.typeOfStructure),
                                  value: (deliverState
                                              .householdMemberWrapper
                                              ?.household
                                              ?.additionalFields
                                              ?.fields
                                              .where((h) =>
                                                  h.key ==
                                                  AdditionalFieldsType
                                                      .houseStructureTypes
                                                      .toValue())
                                              .firstOrNull
                                              ?.value ??
                                          [])
                                      .toString()
                                      .split('|')
                                      .map((item) => getLocalizedMessage(item))
                                      .toList()
                                      .join(', '),
                                  isInline: true),
                            ]),
                      ),
                      BlocBuilder<ProductVariantBloc, ProductVariantState>(
                          builder: (context, productState) {
                        final variants = productState.whenOrNull(
                          fetched: (productVariants) {
                            final resourcesDelivered = deliverState
                                .oldTask?.resources
                                ?.map((e) => TaskResourceInfo(
                                    productVariants
                                            .where((p) =>
                                                p.id == e.productVariantId)
                                            .firstOrNull
                                            ?.sku ??
                                        productVariants
                                            .where((p) =>
                                                p.id == e.productVariantId)
                                            .firstOrNull
                                            ?.variation ??
                                        i18.common.coreCommonNA,
                                    e.quantity ?? '0'))
                                .toList();
                            return resourcesDelivered;
                          },
                        );
                        return DigitCard(
                          child: LabelValueList(
                              heading: localizations.translate(
                                  '${RegistrationDeliverySingleton().selectedProject?.name.toUpperCase()}_${i18.deliverIntervention.deliveryDetailsLabel}_${deliverState.oldTask?.status}'),
                              withDivider: true,
                              items: [
                                LabelValuePair(
                                  label: localizations.translate(
                                      deliverState.oldTask?.status ==
                                                  Status.administeredFailed
                                                      .toValue() ||
                                              deliverState.oldTask?.status ==
                                                  Status.beneficiaryRefused
                                                      .toValue()
                                          ? i18.deliverIntervention
                                              .reasonForRefusalLabel
                                          : i18Local.beneficiaryDetails
                                              .typeOfInsecticideUsed),
                                  value: deliverState.oldTask?.status ==
                                              Status.administeredFailed
                                                  .toValue() ||
                                          deliverState.oldTask?.status ==
                                              Status.beneficiaryRefused
                                                  .toValue()
                                      ? getLocalizedMessage(deliverState
                                              .oldTask?.additionalFields?.fields
                                              .where(
                                                (d) =>
                                                    d.key ==
                                                    AdditionalFieldsType
                                                        .reasonOfRefusal
                                                        .toValue(),
                                              )
                                              .firstOrNull
                                              ?.value ??
                                          i18.common.coreCommonNA)
                                      : variants
                                              ?.map((e) =>
                                                  '${getLocalizedMessage(e.productName)} : ${e.quantityDelivered}')
                                              .toList()
                                              .join('\n') ??
                                          localizations.translate(
                                              i18.common.coreCommonNA),
                                ),
                              ]),
                        );
                      }),
                    ],
                  ),
                )
              ]);
        },
      )),
    );
  }
}
