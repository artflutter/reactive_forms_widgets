// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

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
class ReactiveDateTimePicker extends ReactiveFormField<dynamic> {
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
    Key key,
    String formControlName,
    FormControl formControl,
    TextStyle style,
    ControlValueAccessor valueAccessor,
    ValidationMessagesFunction validationMessages,
    ReactiveDatePickerFieldType type = ReactiveDatePickerFieldType.date,
    InputDecoration decoration,
    bool showClearIcon = true,
    Widget clearIcon = const Icon(Icons.clear),

    // common params
    TransitionBuilder builder,
    bool useRootNavigator = true,
    String cancelText,
    String confirmText,
    String helpText,

    // date picker params
    DateTime firstDate,
    DateTime lastDate,
    DatePickerEntryMode datePickerEntryMode = DatePickerEntryMode.calendar,
    SelectableDayPredicate selectableDayPredicate,
    Locale locale,
    TextDirection textDirection,
    DatePickerMode initialDatePickerMode = DatePickerMode.day,
    String errorFormatText,
    String errorInvalidText,
    String fieldHintText,
    String fieldLabelText,
    RouteSettings datePickerRouteSettings,

    // time picker params
    TimePickerEntryMode timePickerEntryMode = TimePickerEntryMode.dial,
    RouteSettings timePickerRouteSettings,
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          validationMessages: validationMessages,
          builder: (ReactiveFormFieldState<dynamic> field) {
            Widget suffixIcon = decoration?.suffixIcon;
            final isEmptyValue =
                field.value == null || field.value.toString().isEmpty;

            if (showClearIcon && !isEmptyValue) {
              suffixIcon = InkWell(
                borderRadius: BorderRadius.circular(25),
                child: clearIcon,
                onTap: () => field.control.value = null,
              );
            }

            final InputDecoration effectiveDecoration =
                (decoration ?? const InputDecoration())
                    .applyDefaults(Theme.of(field.context).inputDecorationTheme)
                    .copyWith(suffixIcon: suffixIcon);

            DateTimeValueAccessor effectiveValueAccessor = valueAccessor;

            if (effectiveValueAccessor == null) {
              switch (type) {
                case ReactiveDatePickerFieldType.date:
                  effectiveValueAccessor = DateTimeValueAccessor(
                    dateTimeFormat: DateFormat('yyyy/MM/dd'),
                  );
                  break;
                case ReactiveDatePickerFieldType.time:
                  effectiveValueAccessor = DateTimeValueAccessor(
                    dateTimeFormat: DateFormat('HH:mm'),
                  );
                  break;
                case ReactiveDatePickerFieldType.dateTime:
                  effectiveValueAccessor = DateTimeValueAccessor(
                    dateTimeFormat: DateFormat('yyyy/MM/dd HH:mm'),
                  );
                  break;
              }
            }

            final effectiveLastDate = lastDate ?? DateTime(2100);

            return GestureDetector(
              onTap: () async {
                DateTime date;
                TimeOfDay time;

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

                  // ... and new value is not the same as was before...
                  if (field.value == null ||
                      dateTime.compareTo(field.value as DateTime) != 0) {
                    // ... this means that cancel was not pressed at any moment
                    // so we can update the field
                    field.didChange(_combine(date, time));
                  }
                }
              },
              child: InputDecorator(
                decoration: effectiveDecoration,
                isEmpty: isEmptyValue && effectiveDecoration.hintText == null,
                child: Text(
                  effectiveValueAccessor
                      .modelToViewValue(field.value as DateTime)
                      .toString(),
                  style:
                      Theme.of(field.context).textTheme.subtitle1.merge(style),
                ),
              ),
            );
          },
        );

  static DateTime _combine(DateTime date, TimeOfDay time) {
    DateTime dateTime = DateTime(0);

    if (date != null) {
      dateTime = dateTime.add(date.difference(dateTime));
    }

    if (time != null) {
      dateTime = dateTime.add(Duration(hours: time.hour, minutes: time.minute));
    }

    return dateTime;
  }

  static DateTime _getInitialDate(dynamic fieldValue, DateTime lastDate) {
    if (fieldValue != null) {
      return fieldValue as DateTime;
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
