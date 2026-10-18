// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.
//
// Ported from reactive_forms 18.2.2 (https://github.com/joanpablo/reactive_forms)
// to be built on top of package:material_ui instead of package:flutter/material.dart.

import 'package:material_ui/material_ui.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// A builder that builds a widget responsible to decide when to show
/// the picker dialog.
///
/// The builder passes a delegate [picker] as argument that has a method
/// to show the dialog, it also has a property to access the [FormControl]
/// that is bound to [ReactiveMaterialTimePicker].
///
/// See also [ReactiveMaterialDatePickerDelegate].
typedef ReactiveMaterialDatePickerBuilder<T> = Widget Function(
  BuildContext context,
  ReactiveMaterialDatePickerDelegate<T> picker,
  Widget? child,
);

/// This is a convenience widget that wraps the function
/// [showDatePicker] in a [ReactiveMaterialDatePicker].
///
/// The [formControlName] is required to bind this [ReactiveMaterialDatePicker]
/// to a [FormControl].
///
/// For documentation about the various parameters, see the [showDatePicker]
/// function parameters.
///
/// ## Example:
///
/// ```dart
/// ReactiveMaterialDatePicker(
///   formControlName: 'birthday',
///   builder: (context, picker, child) {
///     return IconButton(
///       onPressed: picker.showPicker,
///       icon: Icon(Icons.date_range),
///     );
///   },
/// )
/// ```
class ReactiveMaterialDatePicker<T> extends ReactiveFormField<T, DateTime> {
  /// Creates a [ReactiveMaterialDatePicker] that wraps the function [showDatePicker].
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
  ReactiveMaterialDatePicker({
    super.key,
    super.formControlName,
    super.formControl,
    required ReactiveMaterialDatePickerBuilder<T> builder,
    required DateTime firstDate,
    required DateTime lastDate,
    DatePickerEntryMode initialEntryMode = DatePickerEntryMode.calendar,
    SelectableDayPredicate? selectableDayPredicate,
    String? helpText,
    String? cancelText,
    String? confirmText,
    Locale? locale,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
    TextDirection? textDirection,
    TransitionBuilder? transitionBuilder,
    DatePickerMode initialDatePickerMode = DatePickerMode.day,
    String? errorFormatText,
    String? errorInvalidText,
    String? fieldHintText,
    String? fieldLabelText,
    Widget? child,
    DateTime? currentDate,
    DateTime? initialDate,
    TextInputType? keyboardType,
    Offset? anchorPoint,
    Color? barrierColor,
    bool barrierDismissible = true,
    String? barrierLabel,
    Icon? switchToInputEntryModeIcon,
    Icon? switchToCalendarEntryModeIcon,
    ValueChanged<DatePickerEntryMode>? onDatePickerModeChange,
  }) : super(
         builder: (ReactiveFormFieldState<T, DateTime> field) {
           return builder(
             field.context,
             ReactiveMaterialDatePickerDelegate<T>._(
               field,
               (field) =>
                   showDatePicker(
                     context: field.context,
                     initialDate: _getInitialDate(
                       firstDate,
                       lastDate,
                       initialDate ?? field.value ?? DateTime.now(),
                     ),
                     firstDate: firstDate,
                     lastDate: lastDate,
                     initialEntryMode: initialEntryMode,
                     selectableDayPredicate: selectableDayPredicate,
                     helpText: helpText,
                     cancelText: cancelText,
                     confirmText: confirmText,
                     locale: locale,
                     useRootNavigator: useRootNavigator,
                     routeSettings: routeSettings,
                     textDirection: textDirection,
                     builder: transitionBuilder,
                     initialDatePickerMode: initialDatePickerMode,
                     errorFormatText: errorFormatText,
                     errorInvalidText: errorInvalidText,
                     fieldHintText: fieldHintText,
                     fieldLabelText: fieldLabelText,
                     currentDate: currentDate,
                     keyboardType: keyboardType,
                     anchorPoint: anchorPoint,
                     barrierColor: barrierColor,
                     barrierDismissible: barrierDismissible,
                     barrierLabel: barrierLabel,
                     switchToCalendarEntryModeIcon:
                         switchToCalendarEntryModeIcon,
                     switchToInputEntryModeIcon: switchToInputEntryModeIcon,
                     onDatePickerModeChange: onDatePickerModeChange,
                   ).then((value) {
                     if (value != null) {
                       field.didChange(value);
                     }
                   }),
             ),
             child,
           );
         },
       );

  static DateTime _getInitialDate(
    DateTime firstDate,
    DateTime lastDate,
    DateTime defaultInitDate,
  ) {
    var initialDate = defaultInitDate;

    if (initialDate.isBefore(firstDate)) {
      initialDate = firstDate;
    } else if (initialDate.isAfter(lastDate)) {
      initialDate = lastDate;
    }

    return initialDate;
  }

  @override
  ReactiveFormFieldState<T, DateTime> createState() =>
      _ReactiveDatePickerState<T>();
}

/// Definition of the function responsible for show the date picker.
typedef _ShowDatePickerCallback<T> = void Function(
  ReactiveFormFieldState<T?, DateTime> field,
);

/// This class is responsible of showing the picker dialog.
///
/// See also [ReactiveMaterialDatePicker].
class ReactiveMaterialDatePickerDelegate<T> {
  final ReactiveFormFieldState<T, DateTime> _field;
  final _ShowDatePickerCallback<T> _showPickerCallback;

  ReactiveMaterialDatePickerDelegate._(this._field, this._showPickerCallback);

  /// Gets the control bound to the [ReactiveMaterialTimePicker] widget
  FormControl<T> get control => _field.control;

  /// Gets the value selected in the date picker.
  DateTime? get value => _field.value;

  /// Shows the time picker dialog.
  void showPicker() {
    _showPickerCallback(_field);
  }
}

class _ReactiveDatePickerState<T> extends ReactiveFormFieldState<T, DateTime> {
  @override
  ControlValueAccessor<T, DateTime> selectValueAccessor() {
    if (control is FormControl<String>) {
      return Iso8601DateTimeValueAccessor()
          as ControlValueAccessor<T, DateTime>;
    } else if (control is FormControl<DateTime>) {
      return super.selectValueAccessor();
    }

    throw ValueAccessorException(
      'Invalid widget binding. ReactiveMaterialDatePicker '
      'widget must be bound to a control that inherited from '
      'AbstractControl<String> or AbstractControl<DateTime>. '
      'Control of type: ${control.runtimeType} is not valid.',
    );
  }
}
