import 'package:auto_route/auto_route.dart';
import 'package:digit_components/digit_components.dart';
import 'package:digit_components/widgets/atoms/details_card.dart';
import 'package:digit_data_model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recase/recase.dart';
import 'package:registration_delivery/blocs/delivery_intervention/deliver_intervention.dart';
import 'package:registration_delivery/blocs/household_overview/household_overview.dart';
import 'package:registration_delivery/models/entities/additional_fields_type.dart';
import 'package:registration_delivery/models/entities/status.dart';
import 'package:registration_delivery/models/entities/task.dart';
import 'package:registration_delivery/router/registration_delivery_router.gm.dart';
import 'package:registration_delivery/utils/constants.dart';
import 'package:registration_delivery/utils/utils.dart';
import 'package:registration_delivery/widgets/back_navigation_help_header.dart';
import 'package:registration_delivery/widgets/component_wrapper/product_variant_bloc_wrapper.dart';
import 'package:registration_delivery/widgets/showcase/showcase_button.dart';

import '../../../router/app_router.dart';
import '../../../widgets/localized.dart';
import 'package:registration_delivery/utils/i18_key_constants.dart' as i18;
import '../../../utils/utils_smc/i18_key_constants.dart' as i18_local;

@RoutePage()
class CustomDeliverySummarySMCPage extends LocalizedStatefulWidget {
  const CustomDeliverySummarySMCPage({
    super.key,
    super.appLocalizations,
  });

  @override
  State<CustomDeliverySummarySMCPage> createState() =>
      DeliverySummaryPageState();
}

class DeliverySummaryPageState
    extends LocalizedState<CustomDeliverySummarySMCPage> {
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
                const BackNavigationHelpHeaderWidget(
                  showHelp: false,
                  showcaseButton: ShowcaseButton(),
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
                                          isEditing: (deliverState.tasks ?? [])
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
                                    // context.router.push(
                                    //   HouseholdAcknowledgementRoute(
                                    //     enableViewHousehold: true,
                                    //   ),
                                    // );
                                    context.router.push(
                                        DoseAdministeredVerificationRoute());
                                  } else {
                                    final reloadState =
                                        context.read<HouseholdOverviewBloc>();

                                    reloadState.add(
                                      HouseholdOverviewReloadEvent(
                                        projectId:
                                            RegistrationDeliverySingleton()
                                                .projectId!,
                                        projectBeneficiaryType:
                                            RegistrationDeliverySingleton()
                                                .beneficiaryType!,
                                      ),
                                    );
                                    context.router.popAndPush(
                                      HouseholdAcknowledgementRoute(
                                        enableViewHousehold: true,
                                      ),
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
                                          ?.members?.length
                                          .toString() ??
                                      deliverState.householdMemberWrapper
                                          ?.household?.memberCount
                                          .toString() ??
                                      '0',
                                  isInline: true),
                              LabelValuePair(
                                  label: localizations.translate(i18_local
                                      .individualDetails
                                      .firstNameHeadLabelText),
                                  value:
                                      ("${deliverState.householdMemberWrapper?.headOfHousehold?.name?.givenName} ${deliverState.householdMemberWrapper?.headOfHousehold?.name?.familyName}")
                                              .toString() ??
                                          localizations.translate(
                                              i18.common.coreCommonNA),
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

                        const deliveryCommentKey = 'deliveryComment';
                        var deliveryComment = getDeliveryComment(
                            deliverState.oldTask, deliveryCommentKey);
                        var wastedQuantity =
                            getWastedQuantity(deliverState.oldTask);

                        return DigitCard(
                          child: LabelValueList(
                              heading: localizations.translate(
                                  '${RegistrationDeliverySingleton().selectedProject?.name.toUpperCase()}_${i18.deliverIntervention.deliveryDetailsLabel}_${deliverState.oldTask?.status}'),
                              withDivider: true,
                              items: [
                                LabelValuePair(
                                  label: localizations.translate(deliverState
                                                  .oldTask?.status ==
                                              Status.administeredFailed
                                                  .toValue() ||
                                          deliverState.oldTask?.status ==
                                              Status.beneficiaryRefused
                                                  .toValue()
                                      ? i18.deliverIntervention
                                          .reasonForRefusalLabel
                                      : '${RegistrationDeliverySingleton().selectedProject?.name.toUpperCase()}_${i18.deliverIntervention.typeOfResourceUsed}'),
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
                                LabelValuePair(
                                    label: localizations.translate(i18_local
                                        .beneficiaryDetails
                                        .commentSummaryLabel),
                                    value: deliverState.oldTask?.status ==
                                            Status.administeredSuccess.toValue()
                                        ? localizations.translate(
                                            deliveryComment.toString())
                                        : localizations
                                            .translate(i18.common.coreCommonNA),
                                    isInline: true),
                                LabelValuePair(
                                    label: localizations.translate(i18_local
                                        .beneficiaryDetails
                                        .wastedQuantityLabel),
                                    value: deliverState.oldTask?.status ==
                                            Status.administeredSuccess.toValue()
                                        ? wastedQuantity.toString()
                                        : "0",
                                    isInline: true),
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

String? getDeliveryComment(
  TaskModel? task,
  String deliveryCommentKey,
) {
  if (task == null) {
    return "";
  }

  final comment = task.additionalFields?.fields
      .where((element) => element.key == deliveryCommentKey)
      .firstOrNull;

  return comment == null ? i18.common.coreCommonNA : comment.value;
}

String? getWastedQuantity(
  TaskModel? task,
) {
  const quantityWastedKey = 'quantityWasted';

  if (task == null) {
    return "";
  }

  final wastedQuantity = task.resources?.first.additionalFields?.fields
      .where((element) => element.key == quantityWastedKey)
      .firstOrNull;

  return wastedQuantity == null ? "0" : wastedQuantity.value.toString();
}
