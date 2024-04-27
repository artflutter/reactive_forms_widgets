// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:reactive_contact_picker/src/decoration.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// A [ReactiveEmailContactPicker] that contains a [ContactPicker].
///
/// This is a convenience widget that wraps a [ContactPicker] widget in a
/// [ReactiveEmailContactPicker].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveEmailContactPicker<T> extends ReactiveFormField<T, EmailContact> {
  /// Creates a [ReactiveEmailContactPicker] that contains a [ContactPicker].
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
  /// ReactiveEmailContactPicker(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveEmailContactPicker(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveEmailContactPicker(
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
  /// ReactiveEmailContactPicker(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [ContactPicker] class
  /// and [ContactPicker], the constructor.
  ReactiveEmailContactPicker({
    super.key,
    super.formControlName,
    super.formControl,
    super.validationMessages,
    super.valueAccessor,
    super.showErrors,

    ////////////////////////////////////////////////////////////////////////////
    InputDecoration decoration = decorationInvisible,
    required ContactBuilder<EmailContact> contactBuilder,
    GestureBuilder? gestureBuilder,
    double disabledOpacity = 0.5,
  }) : super(
          builder: (field) {
            final InputDecoration effectiveDecoration = decoration
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);

            void pickContact() async {
              field.didChange(await FlutterContactPicker.pickEmailContact());
            }

            final child = InkWell(
              onTap: pickContact,
              child: InputDecorator(
                decoration: effectiveDecoration.copyWith(
                  errorText: field.errorText,
                  enabled: field.control.enabled,
                ),
                child: contactBuilder.call(field.value),
              ),
            );

            return IgnorePointer(
              ignoring: !field.control.enabled,
              child: Listener(
                onPointerDown: (_) => field.control.markAsTouched(),
                child: Opacity(
                  opacity: field.control.enabled ? 1 : disabledOpacity,
                  child: gestureBuilder?.call(pickContact, child) ?? child,
                ),
              ),
            );
          },
        );
}
