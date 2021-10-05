library reactive_date_time_picker;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:reactive_forms/reactive_forms.dart';

enum ReactiveDatePickerFieldType {
  date,
  time,
  dateTime,
}

/// A builder that builds a widget responsible to decide when to show
/// the picker dialog.
///
/// It has a property to access the [FormControl]
/// that is bound to [ReactiveDatePickerField].

/// This is a convenience widget that wraps the function
/// [showDatePicker] and [showTimePicker] in a [ReactiveDatePickerField].
///
/// The [formControlName] is required to bind this [ReactiveDatePickerField]
/// to a [FormControl].
///
/// For documentation about the various parameters, see the [showDatePicker]
/// and [showTimePicker] function parameters.
///
/// ## Example:
///
/// ```dart
/// ReactiveDatePickerField(
///   formControlName: 'birthday',
/// )
/// ```
class ReactiveDateTimePicker extends ReactiveFormField<DateTime, String> {
  /// Creates a [ReactiveDatePickerField] that wraps the function [showDatePicker].
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
  ReactiveDateTimePicker({
    Key? key,
    String? formControlName,
    FormControl<DateTime>? formControl,
    ControlValueAccessor<DateTime, String>? valueAccessor,
    ValidationMessagesFunction<DateTime>? validationMessages,
    ShowErrorsFunction? showErrors,

    ////////////////////////////////////////////////////////////////////////////
    TextStyle? style,
    ReactiveDatePickerFieldType type = ReactiveDatePickerFieldType.date,
    InputDecoration? decoration,
    bool showClearIcon = true,
    Widget clearIcon = const Icon(Icons.clear),

    // common params
    TransitionBuilder? builder,
    bool useRootNavigator = true,
    String? cancelText,
    String? confirmText,
    String? helpText,

    // date picker params
    DateTime? firstDate,
    DateTime? lastDate,
    DatePickerEntryMode datePickerEntryMode = DatePickerEntryMode.calendar,
    SelectableDayPredicate? selectableDayPredicate,
    Locale? locale,
    TextDirection? textDirection,
    DatePickerMode initialDatePickerMode = DatePickerMode.day,
    String? errorFormatText,
    String? errorInvalidText,
    String? fieldHintText,
    String? fieldLabelText,
    RouteSettings? datePickerRouteSettings,

    // time picker params
    TimePickerEntryMode timePickerEntryMode = TimePickerEntryMode.dial,
    RouteSettings? timePickerRouteSettings,
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          validationMessages: validationMessages,
          valueAccessor: valueAccessor ?? _effectiveValueAccessor(type),
          showErrors: showErrors,
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

            final effectiveValueAccessor =
                valueAccessor ?? _effectiveValueAccessor(type);

            final effectiveLastDate = lastDate ?? DateTime(2100);

            return IgnorePointer(
              ignoring: !field.control.enabled,
              child: GestureDetector(
                onTap: () async {
                  DateTime? date;
                  TimeOfDay? time;

                  if (type == ReactiveDatePickerFieldType.date ||
                      type == ReactiveDatePickerFieldType.dateTime) {
                    date = await showDatePicker(
                      context: field.context,
                      initialDate: _getInitialDate(
                        field.control.value,
                        effectiveLastDate,
                      ),
                      firstDate: firstDate ?? DateTime(1900),
                      lastDate: effectiveLastDate,
                      initialEntryMode: datePickerEntryMode,
                      selectableDayPredicate: selectableDayPredicate,
                      helpText: helpText,
                      cancelText: cancelText,
                      confirmText: confirmText,
                      locale: locale,
                      useRootNavigator: useRootNavigator,
                      routeSettings: datePickerRouteSettings,
                      textDirection: textDirection,
                      builder: builder,
                      initialDatePickerMode: initialDatePickerMode,
                      errorFormatText: errorFormatText,
                      errorInvalidText: errorInvalidText,
                      fieldHintText: fieldHintText,
                      fieldLabelText: fieldLabelText,
                    );
                  }

                  if (type == ReactiveDatePickerFieldType.time ||
                      (type == ReactiveDatePickerFieldType.dateTime &&
                          // there is no need to show timepicker if cancel was pressed on datepicker
                          date != null)) {
                    time = await showTimePicker(
                      context: field.context,
                      initialTime: _getInitialTime(field.control.value),
                      builder: builder,
                      useRootNavigator: useRootNavigator,
                      initialEntryMode: timePickerEntryMode,
                      cancelText: cancelText,
                      confirmText: confirmText,
                      helpText: helpText,
                      routeSettings: timePickerRouteSettings,
                    );
                  }

                  if (
                      // if `date` and `time` in `dateTime` mode is not empty...
                      (type == ReactiveDatePickerFieldType.dateTime &&
                              (date != null && time != null)) ||
                          // ... or if `date` in `date` mode is not empty ...
                          (type == ReactiveDatePickerFieldType.date &&
                              date != null) ||
                          // ... or if `time` in `time` mode is not empty ...
                          (type == ReactiveDatePickerFieldType.time &&
                              time != null)) {
                    final dateTime = _combine(date, time);

                    final value = field.control.value;
                    // ... and new value is not the same as was before...
                    if (value == null || dateTime.compareTo(value) != 0) {
                      // ... this means that cancel was not pressed at any moment
                      // so we can update the field
                      field.didChange(
                        effectiveValueAccessor.modelToViewValue(
                          _combine(date, time),
                        ),
                      );
                    }
                  }
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
                        .subtitle1
                        ?.merge(style),
                  ),
                ),
              ),
            );
          },
        );

  static DateTimeValueAccessor _effectiveValueAccessor(
      ReactiveDatePickerFieldType fieldType) {
    switch (fieldType) {
      case ReactiveDatePickerFieldType.date:
        return DateTimeValueAccessor(
          dateTimeFormat: DateFormat('yyyy/MM/dd'),
        );
      case ReactiveDatePickerFieldType.time:
        return DateTimeValueAccessor(
          dateTimeFormat: DateFormat('HH:mm'),
        );
      case ReactiveDatePickerFieldType.dateTime:
        return DateTimeValueAccessor(
          dateTimeFormat: DateFormat('yyyy/MM/dd HH:mm'),
        );
    }
  }

  static DateTime _combine(DateTime? date, TimeOfDay? time) {
    DateTime dateTime = DateTime(0);

    if (date != null) {
      dateTime = dateTime.add(date.difference(dateTime));
    }

    if (time != null) {
      dateTime = dateTime.add(Duration(hours: time.hour, minutes: time.minute));
    }

    return dateTime;
  }

  static DateTime _getInitialDate(DateTime? fieldValue, DateTime lastDate) {
    if (fieldValue != null) {
      return fieldValue;
    }

    final now = DateTime.now();
    return now.compareTo(lastDate) > 0 ? lastDate : now;
  }

  static TimeOfDay _getInitialTime(dynamic fieldValue) {
    if (fieldValue != null && fieldValue is DateTime) {
      return TimeOfDay(hour: fieldValue.hour, minute: fieldValue.minute);
    }

    return TimeOfDay.now();
  }
}
