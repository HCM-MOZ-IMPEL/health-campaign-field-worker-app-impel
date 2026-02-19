import 'package:digit_components/digit_components.dart';
import 'package:digit_components/widgets/atoms/digit_checkbox.dart';
import 'package:digit_components/widgets/atoms/selection_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:digit_data_model/data_model.dart';

import 'package:registration_delivery/utils/i18_key_constants.dart' as i18;
import '../../../blocs/app_initialization/app_initialization.dart';
import '../../../models/app_config/app_config_model.dart';
import '../../../utils/utils_smc/i18_key_constants.dart' as i18_local;

import '../../localized.dart';
import '../custom_digit_reactive_dropdown_smc.dart';

class CustomResourceBeneficiaryCardOncho extends LocalizedStatefulWidget {
  final void Function(int) onDelete;
  final int cardIndex;
  final FormGroup form;
  final int totalItems;
  final bool isAdministered;
  final void Function(bool) checkDoseAdministration;

  const CustomResourceBeneficiaryCardOncho(
      {super.key,
      super.appLocalizations,
      required this.onDelete,
      required this.cardIndex,
      required this.form,
      required this.totalItems,
      this.isAdministered = false,
      required this.checkDoseAdministration});

  @override
  State<CustomResourceBeneficiaryCardOncho> createState() =>
      CustomResourceBeneficiaryCardOncoState();
}

class CustomResourceBeneficiaryCardOncoState
    extends LocalizedState<CustomResourceBeneficiaryCardOncho> {
  bool doseAdministered = false;
  static const _deliveryCommentKey = 'deliveryComment';

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
                  return CustomDigitReactiveDropdownSMC(
                    label: '${localizations.translate(
                      i18_local.deliverIntervention.resourceDeliveredLabelSMC,
                    )}*',
                    readOnly: true,
                    menuItems: productVariants,
                    formControlName: 'resourceDelivered.${widget.cardIndex}',
                    valueMapper: (value) {
                      return localizations.translate(
                        value.sku ?? value.id,
                      );
                    },
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
          DigitTextFormField(
            formControlName: 'quantityWasted.${widget.cardIndex}',
            label: localizations.translate(
              i18_local.deliverIntervention.quantityWastedLabel,
            ),
            isRequired: false,
          ),
          DigitCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocBuilder<AppInitializationBloc, AppInitializationState>(
                  builder: (context, state) {
                    if (state is! AppInitialized) {
                      return const Offstage();
                    }

                    final deliveryCommentOptionsOncho =
                        state.appConfiguration.deliveryCommentOptionsSmc ??
                            <DeliveryCommentOptions>[];

                    return DigitReactiveDropdown<String>(
                      label: localizations.translate(
                        i18_local.deliverIntervention.deliveryCommentLabelSMC,
                      ),
                      menuItems: deliveryCommentOptionsOncho.map((e) {
                        return e.toString();
                      }).toList(),
                      formControlName: 'deliveryComment.${widget.cardIndex}',
                      isRequired: doseAdministered,
                      valueMapper: (value) => localizations.translate(
                        value,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
