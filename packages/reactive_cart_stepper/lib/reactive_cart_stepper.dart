library reactive_cart_stepper;

import 'package:cart_stepper/cart_stepper.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

export 'package:cart_stepper/cart_stepper.dart';

/// A [ReactiveCartStepper] that contains a [CartStepper].
///
/// This is a convenience widget that wraps a [CartStepper] widget in a
/// [ReactiveCartStepper].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveCartStepper<T, V extends num> extends ReactiveFormField<T, V> {
  /// Creates a [ReactiveCartStepper] that contains a [CartStepper].
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
  /// ReactiveCartStepper(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveCartStepper(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveCartStepper(
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
  /// ReactiveCartStepper(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [CartStepper] class
  /// and [CartStepper], the constructor.
  ReactiveCartStepper({
    Key? key,
    String? formControlName,
    InputDecoration? decoration,
    FormControl<T>? formControl,
    Map<String, ValidationMessageFunction>? validationMessages,
    ControlValueAccessor<T, V>? valueAccessor,
    ShowErrorsFunction<T>? showErrors,

    ////////////////////////////////////////////////////////////////////////////
    required V stepper,
    double size = 30,
    double numberSize = 2,
    Axis axis = Axis.horizontal,
    double elevation = 2,
    double disabledOpacity = 0.5,
    CartStepperStyle? style,
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          valueAccessor: valueAccessor,
          validationMessages: validationMessages,
          showErrors: showErrors,
          builder: (field) {
            return Listener(
              onPointerDown: (_) {
                if (field.control.enabled) {
                  field.control.markAsTouched();
                }
              },
              child: Opacity(
                opacity: field.control.enabled ? 1 : disabledOpacity,
                child: IgnorePointer(
                  ignoring: !field.control.enabled,
                  child: CartStepper<V>(
                    value: field.value,
                    stepper: stepper,
                    didChangeCount: field.didChange,
                    size: size,
                    axis: axis,
                    numberSize: numberSize,
                    elevation: elevation,
                    style: style,
                  ),
                ),
              ),
            );
          },
        );
}
