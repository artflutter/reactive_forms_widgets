library reactive_month_picker_dialog;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// A builder that builds a widget responsible to decide when to show
/// the picker dialog.
///
/// It has a property to access the [FormControl]
/// that is bound to [ReactiveMonthPickerDialog].

/// This is a convenience widget that wraps the function
/// [showDatePicker] and [showTimePicker] in a [ReactiveMonthPickerDialog].
///
/// The [formControlName] is required to bind this [ReactiveMonthPickerDialog]
/// to a [FormControl].
///
/// For documentation about the various parameters, see the [showDatePicker]
/// and [showTimePicker] function parameters.
///
/// ## Example:
///
/// ```dart
/// ReactiveMonthPickerDialog(
///   formControlName: 'birthday',
/// )
/// ```
class ReactiveMonthPickerDialog extends ReactiveFormField<DateTime, String> {
  /// Creates a [ReactiveMonthPickerDialog] that wraps the function [showDatePicker].
  ///
  /// Can optionally provide a [formControl] to bind this widget to a control.
  ///
  /// Can optionally provide a [formControlName] to bind this ReactiveFormField
  /// to a [FormControl].
  ///
  /// Must provide one of the arguments [formControl] or a [formControlName],
  /// but not both at the same time.
  ///
  /// The parameter [transitionBuilder] is the equivalent of [builder]
  /// parameter in the [showTimePicker].
  ///
  /// For documentation about the various parameters, see the [showTimePicker]
  /// function parameters.
  ReactiveMonthPickerDialog({
    Key? key,
    String? formControlName,
    FormControl<DateTime>? formControl,
    Map<String, ValidationMessageFunction>? validationMessages,
    ControlValueAccessor<DateTime, String>? valueAccessor,
    ShowErrorsFunction<DateTime>? showErrors,

    ////////////////////////////////////////////////////////////////////////////
    InputDecoration? decoration,
    bool showClearIcon = true,
    Widget clearIcon = const Icon(Icons.clear),
    TextStyle? style,
    DateTime? firstDate,
    DateTime? lastDate,
    Locale? locale,
    bool Function(DateTime)? selectableMonthPredicate,
    bool capitalizeFirstLetter = true,
    Color? headerColor,
    Color? headerTextColor,
    Color? selectedMonthBackgroundColor,
    Color? backgroundColor,
    Color? selectedMonthTextColor,
    Color? unselectedMonthTextColor,
    Widget? confirmText,
    Widget? cancelText,
    double? customHeight,
    double customWidth = 320,
    bool yearFirst = false,
    bool dismissible = false,
    double roundedCornersRadius = 0,
    bool forceSelectedDate = false,
    ButtonStyle? Function(DateTime)? monthStylePredicate,
    ButtonStyle? Function(int)? yearStylePredicate,
    ReactiveFormFieldCallback<DateTime>? onChanged,
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          validationMessages: validationMessages,
          showErrors: showErrors,
          valueAccessor: valueAccessor ??
              DateTimeValueAccessor(
                dateTimeFormat: DateFormat('yyyy/MM'),
              ),
          builder: (field) {
            Widget? suffixIcon = decoration?.suffixIcon;
            final isEmptyValue =
                field.value == null || field.value?.isEmpty == true;

            if (showClearIcon && !isEmptyValue) {
              suffixIcon = InkWell(
                borderRadius: BorderRadius.circular(25),
                child: clearIcon,
                onTap: () {
                  field.control.markAsTouched();
                  field.didChange(null);
                },
              );
            }

            final InputDecoration effectiveDecoration =
                (decoration ?? const InputDecoration())
                    .applyDefaults(Theme.of(field.context).inputDecorationTheme)
                    .copyWith(suffixIcon: suffixIcon);

            final effectiveLastDate = lastDate ?? DateTime(2100);

            return IgnorePointer(
              ignoring: !field.control.enabled,
              child: GestureDetector(
                onTap: () async {
                  final date = await showMonthPicker(
                    context: field.context,
                    initialDate: _getInitialDate(
                      field.control.value,
                      effectiveLastDate,
                    ),
                    firstDate: firstDate ?? DateTime(1900),
                    lastDate: effectiveLastDate,
                    locale: locale,
                    selectableMonthPredicate: selectableMonthPredicate,
                    capitalizeFirstLetter: capitalizeFirstLetter,
                    headerColor: headerColor,
                    headerTextColor: headerTextColor,
                    selectedMonthBackgroundColor: selectedMonthBackgroundColor,
                    selectedMonthTextColor: selectedMonthTextColor,
                    unselectedMonthTextColor: unselectedMonthTextColor,
                    confirmWidget: confirmText,
                    cancelWidget: cancelText,
                    customHeight: customHeight,
                    customWidth: customWidth,
                    yearFirst: yearFirst,
                    dismissible: dismissible,
                    roundedCornersRadius: roundedCornersRadius,
                    forceSelectedDate: forceSelectedDate,
                    backgroundColor: backgroundColor,
                    monthStylePredicate: monthStylePredicate,
                    yearStylePredicate: yearStylePredicate,
                  );

                  field.didChange(
                    date == null
                        ? field.value
                        : field.valueAccessor.modelToViewValue(date),
                  );
                  onChanged?.call(field.control);
                  field.control.markAsTouched();
                },
                child: InputDecorator(
                  decoration: effectiveDecoration.copyWith(
                    errorText: field.errorText,
                    enabled: field.control.enabled,
                  ),
                  isEmpty: isEmptyValue && effectiveDecoration.hintText == null,
                  child: Text(
                    field.value ?? '',
                    style: Theme.of(field.context)
                        .textTheme
                        .titleMedium
                        ?.merge(style),
                  ),
                ),
              ),
            );
          },
        );

  static DateTime _getInitialDate(DateTime? fieldValue, DateTime lastDate) {
    if (fieldValue != null) {
      return fieldValue;
    }

    final now = DateTime.now();
    return now.compareTo(lastDate) > 0 ? lastDate : now;
  }
}
