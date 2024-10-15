import 'package:collection/collection.dart';
import 'package:digit_components/digit_components.dart';
import 'package:digit_components/models/digit_table_model.dart';
import 'package:digit_data_model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:health_campaign_field_worker_app/utils/utils.dart'
    as utilsLocal;
import 'package:registration_delivery/blocs/app_localization.dart';
import 'package:registration_delivery/registration_delivery.dart';

import 'package:registration_delivery/blocs/delivery_intervention/deliver_intervention.dart';
import 'package:registration_delivery/utils/i18_key_constants.dart' as i18;
import 'package:registration_delivery/utils/utils.dart';

// This function builds a table with the given data and headers
Widget buildTableContent(
  DeliverInterventionState deliverInterventionState,
  BuildContext context,
  List<ProductVariantModel>? variant,
  IndividualModel? individualModel,
  HouseholdModel? householdModel,
) {
  // Calculate the current cycle. If deliverInterventionState.cycle is negative, set it to 0.
  final currentCycle =
      deliverInterventionState.cycle >= 0 ? deliverInterventionState.cycle : 0;

  // Calculate the current dose. If deliverInterventionState.dose is negative, set it to 0.
  final currentDose =
      deliverInterventionState.dose >= 0 ? deliverInterventionState.dose : 0;
  final localizations = RegistrationDeliveryLocalization.of(context);

  // Defining a list of table headers for resource popup
  final headerListResource = [
    TableHeader(
      localizations.translate(i18.beneficiaryDetails.beneficiaryDose),
      cellKey: 'dose',
    ),
    TableHeader(
      localizations.translate(i18.beneficiaryDetails.beneficiaryResources),
      cellKey: 'resources',
    ),
  ];

  // Calculate the height of the container based on the number of items in the table

  final ProjectTypeModel projectType =
      RegistrationDeliverySingleton().projectType!;
  final item =
      projectType.cycles?[currentCycle - 1].deliveries?[currentDose - 1];
  final productVariants =
      fetchProductVariant(item, individualModel, householdModel)
          ?.productVariants;
  final numRows = productVariants?.length ?? 0;
  const rowHeight = 84;
  const paddingHeight = (kPadding * 2);
  final containerHeight = (numRows + 1) * rowHeight + (paddingHeight * 2);
  const columnWidth = 150.0;
  const cellHeight = 59.5;

  return Container(
    padding: const EdgeInsets.only(
      left: kPadding,
      bottom: 0,
      right: kPadding,
      top: 0,
    ),
    height: containerHeight,
    width: MediaQuery.of(context).size.width / 1.25,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisSize: MainAxisSize.min,
      children: [
        DigitTableCard(
          topPadding: const EdgeInsets.only(top: 0.0),
          padding: const EdgeInsets.only(bottom: kPadding / 2),
          fraction: 2.5,
          element: {
            localizations.translate(
              i18.beneficiaryDetails.beneficiaryAge,
            ): fetchProductVariant(item, individualModel, householdModel)
                        ?.condition !=
                    null
                ? localizations.translate(
                    '${utilsLocal.getAgeConditionString('${fetchProductVariant(item, individualModel, householdModel)?.condition}')}',
                  )
                : null,
          },
        ),
        const Divider(
          thickness: 1.0,
        ),
        // Build the DigitTable with the data
        fetchProductVariant(item, individualModel, householdModel)
                    ?.productVariants !=
                null
            ? DigitTable(
                headerList: headerListResource,
                tableData: [
                  ...fetchProductVariant(item, individualModel, householdModel)!
                      .productVariants!
                      .map(
                    (e) {
                      // Retrieve the SKU value for the product variant.
                      final value = variant
                          ?.firstWhereOrNull(
                            (element) => element.id == e.productVariantId,
                          )
                          ?.sku;
                      final quantity = e.quantity;

                      return TableDataRow([
                        // Display the dose information in the first column if it's the first row,
                        // otherwise, display an empty cell.

                        fetchProductVariant(
                                        item, individualModel, householdModel)
                                    ?.productVariants
                                    ?.indexOf(e) ==
                                0
                            ? TableData(
                                '${localizations.translate(i18.deliverIntervention.dose)} ${deliverInterventionState.dose}',
                                cellKey: 'dose',
                              )
                            : TableData(''),
                        // Display the SKU value in the second column.
                        TableData(
                          '$quantity - ${localizations.translate(value.toString())}',
                          cellKey: 'resources',
                        ),
                      ]);
                    },
                  ),
                ],
                columnWidth: columnWidth,
                height:
                    ((fetchProductVariant(item, individualModel, householdModel)
                                        ?.productVariants ??
                                    [])
                                .length +
                            1) *
                        cellHeight,
              )
            : Text(localizations.translate(i18.common.noProjectSelected))
      ],
    ),
  );
}
