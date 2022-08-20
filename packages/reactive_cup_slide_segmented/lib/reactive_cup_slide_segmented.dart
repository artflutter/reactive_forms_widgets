library reactive_cup_slide_segmented;

// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// A [ReactiveCupertinoSlidingSegmentedControl] that contains a [CupertinoSlidingSegmentedControl].
///
/// This is a convenience widget that wraps a [CupertinoSlidingSegmentedControl] widget in a
/// [ReactiveCupertinoSlidingSegmentedControl].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveCupertinoSlidingSegmentedControl<T extends Object,
    V extends Object> extends ReactiveFormField<T, V> {
  /// Creates a [ReactiveCupertinoSlidingSegmentedControl] that contains a [CupertinoSlidingSegmentedControl].
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
  /// ReactiveCupertinoSlidingSegmentedControl(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveCupertinoSlidingSegmentedControl(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveCupertinoSlidingSegmentedControl(
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
  /// ReactiveCupertinoSlidingSegmentedControl(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [CupertinoSlidingSegmentedControl] class
  /// and [CupertinoSlidingSegmentedControl], the constructor.
  ReactiveCupertinoSlidingSegmentedControl({
    Key? key,
    String? formControlName,
    FormControl<T>? formControl,
    Map<String, ValidationMessageFunction>? validationMessages,
    ControlValueAccessor<T, V>? valueAccessor,
    ShowErrorsFunction? showErrors,

    ////////////////////////////////////////////////////////////////////////////
    InputDecoration? decoration,
    required Map<V, Widget> children,
    Color thumbColor = const CupertinoDynamicColor.withBrightness(
      color: Color(0xFFFFFFFF),
      darkColor: Color(0xFF636366),
    ),
    EdgeInsets padding = const EdgeInsets.symmetric(vertical: 2, horizontal: 3),
    Color backgroundColor = CupertinoColors.tertiarySystemFill,
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

            return IgnorePointer(
              ignoring: !field.control.enabled,
              child: Listener(
                onPointerDown: (_) => field.control.markAsTouched(),
                child: InputDecorator(
                  decoration: effectiveDecoration.copyWith(
                    errorText: field.errorText,
                    enabled: field.control.enabled,
                  ),
                  child: CupertinoSlidingSegmentedControl<V>(
                    children: children,
                    onValueChanged: field.didChange,
                    groupValue: field.value,
                    thumbColor: thumbColor,
                    padding: padding,
                    backgroundColor: backgroundColor,
                  ),
                ),
              ),
            );
          },
        );
}
