import 'package:digit_components/digit_components.dart';
import 'package:digit_components/widgets/atoms/selection_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:digit_data_model/data_model.dart';

import 'package:registration_delivery/utils/i18_key_constants.dart' as i18;

import '../../localized.dart';

class CustomResourceBeneficiaryCard extends LocalizedStatefulWidget {
  final void Function(int) onDelete;
  final int cardIndex;
  final FormGroup form;
  final int totalItems;

  const CustomResourceBeneficiaryCard({
    super.key,
    super.appLocalizations,
    required this.onDelete,
    required this.cardIndex,
    required this.form,
    required this.totalItems,
  });

  @override
  State<CustomResourceBeneficiaryCard> createState() =>
      CustomResourceBeneficiaryCardState();
}

class CustomResourceBeneficiaryCardState
    extends LocalizedState<CustomResourceBeneficiaryCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: DigitTheme.instance.colorScheme.surface,
        border: Border.all(
          color: DigitTheme.instance.colorScheme.outline,
          width: 1,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(4.0),
        ),
      ),
      margin: const EdgeInsets.only(
        top: kPadding,
        bottom: kPadding,
      ),
      padding: const EdgeInsets.all(kPadding),
      child: Column(
        children: [
          BlocBuilder<ProductVariantBloc, ProductVariantState>(
            builder: (context, productState) {
              return productState.maybeWhen(
                orElse: () => const Offstage(),
                fetched: (productVariants) {
                  return SelectionBox<ProductVariantModel>(
                    width: 116,
                    options: productVariants,
                    onSelectionChanged: (selectedOptions) {
                      if (selectedOptions.isNotEmpty) {
                        var selectedOption = selectedOptions.first;
                        widget.form
                            .control('resourceDelivered.${widget.cardIndex}')
                            .value = selectedOption;
                      } else {
                        widget.form
                            .control('resourceDelivered.${widget.cardIndex}')
                            .value = null;
                      }
                    },
                    initialSelection: widget.form
                                .control(
                                    'resourceDelivered.${widget.cardIndex}')
                                .value !=
                            null
                        ? [
                            widget.form
                                .control(
                                    'resourceDelivered.${widget.cardIndex}')
                                .value
                          ]
                        : [],
                    valueMapper: (value) {
                      return localizations.translate(
                        value.sku ?? value.id,
                      );
                    },
                    allowMultipleSelection: false,
                  );
                },
              );
            },
          ),
          DigitIntegerFormPicker(
            incrementer: true,
            formControlName: 'quantityDistributed.${widget.cardIndex}',
            form: widget.form,
            label: localizations.translate(
              i18.deliverIntervention.quantityDistributedLabel,
            ),
            minimum: 0,
            maximum: 3,
          ),
          SizedBox(
            child: Align(
              alignment: Alignment.centerLeft,
              child: (widget.cardIndex == widget.totalItems - 1 &&
                      widget.totalItems > 1)
                  ? DigitIconButton(
                      onPressed: () async {
                        final submit = await DigitDialog.show<bool>(
                          context,
                          options: DigitDialogOptions(
                            titleText: localizations.translate(
                              i18.deliverIntervention
                                  .resourceDeleteBeneficiaryDialogTitle,
                            ),
                            primaryAction: DigitDialogActions(
                              label: localizations.translate(
                                i18.deliverIntervention
                                    .resourceDeleteBeneficiaryPrimaryActionLabel,
                              ),
                              action: (context) {
                                Navigator.of(
                                  context,
                                  rootNavigator: true,
                                ).pop(true);
                              },
                            ),
                            secondaryAction: DigitDialogActions(
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
                        if (submit == true) {
                          widget.onDelete(widget.cardIndex);
                        }
                      },
                      iconText: localizations.translate(
                        i18.deliverIntervention.resourceDeleteBeneficiary,
                      ),
                      icon: Icons.delete,
                    )
                  : const Offstage(),
            ),
          ),
        ],
      ),
    );
  }
}
