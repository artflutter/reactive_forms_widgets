library reactive_cupertino_switch;

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// A [ReactiveCupertinoSwitch] that contains a [CupertinoSwitch].
///
/// This is a convenience widget that wraps a [CupertinoSwitch] widget in a
/// [ReactiveCupertinoSwitch].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveCupertinoSwitch<T> extends ReactiveFormField<T, bool> {
  /// Creates a [ReactiveCupertinoSwitch] that contains a [CupertinoSwitch].
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
  /// ReactiveCupertinoSwitch(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveCupertinoSwitch(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveCupertinoSwitch(
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
  /// ReactiveCupertinoSwitch(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [CupertinoSwitch] class
  /// and [CupertinoSwitch], the constructor.
  ReactiveCupertinoSwitch({
    Key? key,
    String? formControlName,
    FormControl<T>? formControl,
    Map<String, ValidationMessageFunction>? validationMessages,
    ControlValueAccessor<T, bool>? valueAccessor,
    ShowErrorsFunction? showErrors,

    ////////////////////////////////////////////////////////////////////////////
    // InputDecoration? decoration = const InputDecoration(),
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    Color? activeColor,
    Color? trackColor,
    double disabledOpacity = 0.5,
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          valueAccessor: valueAccessor,
          validationMessages: validationMessages,
          showErrors: showErrors,
          builder: (field) {
            return IgnorePointer(
              ignoring: !field.control.enabled,
              child: Opacity(
                opacity: field.control.enabled ? 1 : disabledOpacity,
                child: CupertinoSwitch(
                  value: field.value ?? false,
                  onChanged: field.didChange,
                  activeColor: activeColor,
                  trackColor: trackColor,
                  dragStartBehavior: dragStartBehavior,
                ),
              ),
            );
          },
        );
}
