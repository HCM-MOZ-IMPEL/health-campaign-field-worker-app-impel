import 'package:digit_components/digit_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/local_store/no_sql/schema/app_configuration.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:digit_data_model/data_model.dart';

import '../../../blocs/app_initialization/app_initialization.dart';
import '../../../utils/utils_smc/i18_key_constants.dart' as i18_local;

import '../../localized.dart';
import '../../widgets_bednet/custom_digit_integer_form_picker.dart';
import '../custom_digit_reactive_dropdown_smc.dart';

class CustomResourceBeneficiaryCardOncho extends LocalizedStatefulWidget {
  final int cardIndex;
  final FormGroup form;
  final int totalItems;
  final bool isAdministered;
  final void Function(bool) checkDoseAdministration;

  const CustomResourceBeneficiaryCardOncho(
      {super.key,
      super.appLocalizations,
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

  int _parseNonNegativeInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value < 0 ? 0 : value;
    if (value is double)
      return value.isNaN ? 0 : value.round().clamp(0, 1 << 30);
    if (value is String) {
      final trimmed = value.trim();
      if (trimmed.isEmpty) return 0;
      return (int.tryParse(trimmed) ?? double.tryParse(trimmed)?.round() ?? 0)
          .clamp(0, 1 << 30);
    }
    return 0;
  }

  String _normalize(String input) {
    // Keep it dependency-free; handle common differences like casing/spaces.
    // (If you need true accent removal later, we can add a small utility pkg.)
    return input.trim().toUpperCase().replaceAll(RegExp(r'[^A-Z0-9]+'), '');
  }

  /// Candidate identifiers (sku/variation/id) for filtering comment options.
  List<String> _resourceKeys(ProductVariantModel? resource) {
    if (resource == null) return const [];

    final keys = <String>{
      if ((resource.sku ?? '').trim().isNotEmpty) resource.sku!.trim(),
      if ((resource.variation ?? '').trim().isNotEmpty)
        resource.variation!.trim(),
      if ((resource.id).trim().isNotEmpty) resource.id.trim(),
    }.map(_normalize).where((e) => e.isNotEmpty).toList();

    // Extra tolerance for common "ALBENDAZOL" vs "ALBENDAZOLE" mismatch.
    final expanded = <String>{...keys};
    for (final k in keys) {
      if (k.endsWith('E')) expanded.add(k.substring(0, k.length - 1));
      expanded.add('${k}E');
    }

    return expanded.toList();
  }

  /// Filters delivery comment options to those linked to the selected resource.
  /// Matches when option.code or option.name contains the resource key
  /// (e.g. "ALBENDAZOLE" so options with code "ALBENDAZOLE_WASTED" are shown).
  List<DeliveryCommentOptions> _filterCommentOptionsByResource(
    List<DeliveryCommentOptions> options,
    List<String> resourceKeys,
  ) {
    if (resourceKeys.isEmpty) return options;

    return options.where((o) {
      final haystack = _normalize('${o.code} ${o.name}');
      return resourceKeys.any(haystack.contains);
    }).toList();
  }

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
                      i18_local.deliverIntervention.resourceDeliveredLabelONCHO,
                    )}*',
                    readOnly: true,
                    menuItems: productVariants,
                    formControlName: 'resourceDelivered.${widget.cardIndex}',
                    valueMapper: (value) {
                      return localizations.translate(
                        value.variation ?? value.sku ?? value.id,
                      );
                    },
                  );
                },
              );
            },
          ),
          CustomDigitIntegerFormPicker(
            incrementer: true,
            formControlName: 'quantityDistributed.${widget.cardIndex}',
            form: widget.form,
            label: localizations.translate(
              i18_local.deliverIntervention.quantityDistributedLabelONCHO,
            ),
            minimum: 0,
            maximum: 3,
            readOnly: true,
          ),
          DigitTextFormField(
              formControlName: 'quantityWasted.${widget.cardIndex}',
              label: localizations.translate(
                i18_local.deliverIntervention.quantityWastedLabelONCHO,
              ),
              isRequired: false,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(
                  "[0-9]",
                )),
              ]),
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
                        state.appConfiguration.deliveryCommentOptionsOncho ??
                            <DeliveryCommentOptions>[];

                    final resourceControl = widget.form
                        .control('resourceDelivered.${widget.cardIndex}');
                    final wastedControl = widget.form
                        .control('quantityWasted.${widget.cardIndex}');
                    final commentControl = widget.form
                        .control('deliveryComment.${widget.cardIndex}');

                    return StreamBuilder<dynamic>(
                      stream: resourceControl.valueChanges,
                      initialData: resourceControl.value,
                      builder: (context, resourceSnap) {
                        return StreamBuilder<dynamic>(
                          stream: wastedControl.valueChanges,
                          initialData: wastedControl.value,
                          builder: (context, wastedSnap) {
                            final selectedResource =
                                resourceSnap.data is ProductVariantModel
                                    ? resourceSnap.data as ProductVariantModel
                                    : null;
                            final resourceKeys =
                                _resourceKeys(selectedResource);

                            final wastedQty =
                                _parseNonNegativeInt(wastedSnap.data);
                            final isCommentRequired = wastedQty > 0;

                            // Keep validators in sync with UI requirement.
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              final control = commentControl;
                              final hasRequired = control.validators
                                  .contains(Validators.required);
                              if (isCommentRequired && !hasRequired) {
                                control.setValidators([Validators.required]);
                                control.updateValueAndValidity();
                              } else if (!isCommentRequired && hasRequired) {
                                control.setValidators([]);
                                control.updateValueAndValidity();
                              }
                            });

                            final filteredOptions =
                                _filterCommentOptionsByResource(
                              deliveryCommentOptionsOncho,
                              resourceKeys,
                            );
                            final effectiveOptions = filteredOptions.isNotEmpty
                                ? filteredOptions
                                : deliveryCommentOptionsOncho;

                            final filteredNames =
                                effectiveOptions.map((e) => e.name).toList();

                            // Clear comment if current value is not in filtered list
                            final currentComment =
                                commentControl.value as String?;
                            if (currentComment != null &&
                                currentComment.isNotEmpty &&
                                !filteredNames.contains(currentComment)) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                if (commentControl.value == currentComment) {
                                  commentControl.value = null;
                                }
                              });
                            }

                            return DigitReactiveDropdown<String>(
                              label: localizations.translate(
                                i18_local.deliverIntervention
                                    .deliveryCommentLabelWastedONCHO,
                              ),
                              menuItems: filteredNames,
                              formControlName:
                                  'deliveryComment.${widget.cardIndex}',
                              isRequired: isCommentRequired,
                              valueMapper: (value) =>
                                  localizations.translate(value),
                            );
                          },
                        );
                      },
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
