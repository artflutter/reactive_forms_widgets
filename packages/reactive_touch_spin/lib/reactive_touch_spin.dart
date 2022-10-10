library reactive_touch_spin;

import 'package:flutter/material.dart';
import 'package:flutter_touch_spin/flutter_touch_spin.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// A [ReactiveTouchSpin] that contains a [TouchSpin].
///
/// This is a convenience widget that wraps a [TouchSpin] widget in a
/// [ReactiveTouchSpin].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveTouchSpin<T> extends ReactiveFormField<T, num> {
  /// Creates a [ReactiveTouchSpin] that contains a [TouchSpin].
  ///
  /// Can optionally provide a [formControl] to bind this widget to a control.
  ///
  /// Can optionally provide a [formControlName] to bind this ReactiveFormField
  /// to a [FormControl].
  ///
  /// Must provide one of the arguments [formControl] or a [formControlName],
  /// but not both at the same time.
  ///
  /// Can optionally provide a [validationMessages] argument to customize a
  /// message for different kinds of validation errors.
  ///
  /// Can optionally provide a [valueAccessor] to set a custom value accessors.
  /// See [ControlValueAccessor].
  ///
  /// Can optionally provide a [showErrors] function to customize when to show
  /// validation messages. Reactive Widgets make validation messages visible
  /// when the control is INVALID and TOUCHED, this behavior can be customized
  /// in the [showErrors] function.
  ///
  /// ### Example:
  /// Binds a text field.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveTouchSpin(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveTouchSpin(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveTouchSpin(
  ///   formControlName: 'email',
  ///   validationMessages: {
  ///     ValidationMessage.required: 'The email must not be empty',
  ///     ValidationMessage.email: 'The email must be a valid email',
  ///   }
  /// ),
  /// ```
  ///
  /// Customize when to show up validation messages.
  /// ```dart
  /// ReactiveTouchSpin(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [TouchSpin] class
  /// and [TouchSpin], the constructor.
  ReactiveTouchSpin({
    Key? key,
    String? formControlName,
    FormControl<T>? formControl,
    Map<String, ValidationMessageFunction>? validationMessages,
    ControlValueAccessor<T, num>? valueAccessor,
    ShowErrorsFunction? showErrors,

    ////////////////////////////////////////////////////////////////////////////
    InputDecoration? decoration,
    num min = 1.0,
    num max = 9999999.0,
    num step = 1.0,
    double iconSize = 24.0,
    NumberFormat? displayFormat,
    Icon subtractIcon = const Icon(Icons.remove),
    Icon addIcon = const Icon(Icons.add),
    EdgeInsets iconPadding = const EdgeInsets.all(4.0),
    TextStyle textStyle = const TextStyle(fontSize: 24),
    Color? iconActiveColor,
    Color? iconDisabledColor,
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          valueAccessor: valueAccessor,
          validationMessages: validationMessages,
          showErrors: showErrors,
          builder: (field) {
            final InputDecoration effectiveDecoration = (decoration ??
                    const InputDecoration())
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);

            return Listener(
              onPointerDown: (_) {
                if (field.control.enabled) {
                  field.control.markAsTouched();
                }
              },
              child: InputDecorator(
                decoration: effectiveDecoration.copyWith(
                  errorText: field.errorText,
                  enabled: field.control.enabled,
                ),
                child: TouchSpin(
                  value: field.value ?? min,
                  onChanged: (value) {
                    if (field.value != value) {
                      field.didChange(value);
                    }
                  },
                  min: min,
                  max: max,
                  step: step,
                  iconSize: iconSize,
                  displayFormat: displayFormat,
                  subtractIcon: subtractIcon,
                  addIcon: addIcon,
                  iconPadding: iconPadding,
                  textStyle: textStyle,
                  iconActiveColor: iconActiveColor,
                  iconDisabledColor: iconDisabledColor,
                  enabled: field.control.enabled,
                ),
              ),
            );
          },
        );
}
