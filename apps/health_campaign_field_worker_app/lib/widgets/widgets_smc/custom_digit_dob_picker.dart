import 'package:digit_components/digit_components.dart';
import 'package:digit_components/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CustomDigitDobPicker extends StatelessWidget {
  // Properties to hold the form control name, labels, and error messages for the components
  final String datePickerFormControl;
  final bool isVerified;
  final ControlValueAccessor? valueAccessor;
  final String datePickerLabel;
  final String ageFieldLabel;
  final String yearsHintLabel;
  final String separatorLabel;
  final String yearsAndMonthsErrMsg;
  final String cancelText;
  final String confirmText;
  final DateTime? initialDate;
  final void Function(FormControl<dynamic>)? onChangeOfFormControl;
  final bool isEligible;

  const CustomDigitDobPicker({
    super.key,
    required this.datePickerFormControl,
    this.isVerified = false,
    this.valueAccessor,
    required this.datePickerLabel,
    required this.ageFieldLabel,
    required this.yearsHintLabel,
    required this.separatorLabel,
    required this.yearsAndMonthsErrMsg,
    this.initialDate,
    this.confirmText = 'OK',
    this.cancelText = 'Cancel',
    this.onChangeOfFormControl,
    this.isEligible = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
      ),
      child: Container(
        padding: const EdgeInsets.only(
          left: 8,
          right: 8,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  // Text form field for entering the age in years
                  child: DigitTextFormField(
                      padding: EdgeInsets.zero,
                      isRequired: isEligible,
                      maxLength: 3,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      valueAccessor:
                          DobValueAccessorYearsString(DobValueAccessor()),
                      formControlName: datePickerFormControl,
                      label: ageFieldLabel,
                      keyboardType: TextInputType.number,
                      suffix: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          yearsHintLabel,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      readOnly: isVerified,
                      onChanged: onChangeOfFormControl),
                ),
              ],
            ),
            ReactiveFormConsumer(
              builder: (context, form, child) {
                final datePickerControl = form.control(datePickerFormControl);
                if (datePickerControl.hasErrors) {
                  return Text(
                    yearsAndMonthsErrMsg,
                    style:
                        TextStyle(color: DigitTheme.instance.colorScheme.error),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

// A custom ControlValueAccessor to convert the model value (DateTime) to the view value (DigitDOBAge) and vice versa.
class DobValueAccessor extends ControlValueAccessor<DateTime, DigitDOBAge> {
  @override
  DigitDOBAge? modelToViewValue(DateTime? modelValue) {
    if (modelValue == null) {
      return null;
    } else {
      return DigitDateUtils.calculateAge(modelValue);
    }
  }

  @override
  DateTime? viewToModelValue(DigitDOBAge? viewValue) {
    if (viewValue == null || (viewValue.years == 0 && viewValue.months == 0)) {
      return null;
    } else {
      final months = viewValue.months;
      final days = DigitDateUtils.yearsMonthsDaysToDays(
          viewValue.years, viewValue.months, viewValue.days);

      final calculatedDate = DateTime.now().subtract(Duration(days: days));

      return (viewValue.years == 0 && months == 0) || months > 11
          ? null
          : DateTime(
              calculatedDate.year,
              calculatedDate.month,
              1,
            );
    }
  }
}

// A custom ControlValueAccessor to handle the view value as a string for years.
class DobValueAccessorYearsString
    extends ControlValueAccessor<DateTime, String> {
  final DobValueAccessor accessor;

  DobValueAccessorYearsString(this.accessor);
  String existingMonth = '';
  String existingDays = '';

  @override
  String? modelToViewValue(DateTime? modelValue) {
    final dobAge = accessor.modelToViewValue(modelValue);
    if (dobAge == null || (dobAge.years == 0 && dobAge.months == 0)) {
      existingMonth = '';
      existingDays = '';
      return null;
    }

    existingMonth = dobAge.months.toString();
    existingDays = dobAge.days.toString();
    return dobAge.years.toString();
  }

  @override
  DateTime? viewToModelValue(String? viewValue) {
    final years = int.tryParse(viewValue ?? '');

    final dobAge = DigitDOBAge(
        years: years ?? 0, months: int.tryParse(existingMonth) ?? 0, days: 1);
    return accessor.viewToModelValue(dobAge);
  }
}

// A custom ControlValueAccessor to handle the view value as a string for months.
class DobValueAccessorMonthString
    extends ControlValueAccessor<DateTime, String> {
  final DobValueAccessor accessor;

  DobValueAccessorMonthString(this.accessor);
  String existingYear = '';
  String existingDays = '';

  @override
  String? modelToViewValue(DateTime? modelValue) {
    final dobAge = accessor.modelToViewValue(modelValue);

    if (dobAge == null || (dobAge.years == 0 && (dobAge.months == 0))) {
      existingYear = '';
      existingDays = '';
      return null;
    }

    existingYear = dobAge.years.toString();
    existingDays = dobAge.days.toString();
    int months = dobAge.months;
    return months.toString();
  }

  @override
  DateTime? viewToModelValue(String? viewValue) {
    final months = int.tryParse(viewValue ?? '');
    final dobAge = DigitDOBAge(
        years: int.tryParse(existingYear) ?? 0, months: months ?? 0, days: 1);
    return accessor.viewToModelValue(dobAge);
  }
}
