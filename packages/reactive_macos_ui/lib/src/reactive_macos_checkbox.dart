import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// A [ReactiveMacosCheckbox] that contains a [MacosCheckbox].
///
/// This is a convenience widget that wraps a [MacosCheckbox] widget in a
/// [ReactiveMacosCheckbox].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveMacosCheckbox<T> extends ReactiveFormField<T, bool> {
  /// Creates a [ReactiveMacosCheckbox] that contains a [MacosCheckbox].
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
  /// ReactiveMacosCheckbox(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveMacosCheckbox(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveMacosCheckbox(
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
  /// ReactiveMacosCheckbox(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [MacosCheckbox] class
  /// and [MacosCheckbox], the constructor.
  ReactiveMacosCheckbox({
    super.key,
    super.formControlName,
    super.formControl,
    super.validationMessages,
    super.valueAccessor,
    super.showErrors,

    ////////////////////////////////////////////////////////////////////////////
    InputDecoration decoration = const InputDecoration(
      border: InputBorder.none,
      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      isDense: true,
      isCollapsed: true,
    ),
    Color? activeColor,
    double size = 16.0,
    Color disabledColor = CupertinoColors.quaternaryLabel,
    Color offBorderColor = CupertinoColors.tertiaryLabel,
    String? semanticLabel,
  }) : super(
          builder: (field) {
            // final InputDecoration effectiveDecoration = decoration
            //     .applyDefaults(Theme.of(field.context).inputDecorationTheme);

            return Listener(
              onPointerDown: (_) {
                if (field.control.enabled) {
                  field.control.markAsTouched();
                }
              },
              child: MacosCheckbox(
                value: field.value,
                onChanged: field.control.enabled ? field.didChange : null,
                size: size = 16.0,
                activeColor: activeColor,
                disabledColor: disabledColor,
                offBorderColor: offBorderColor,
                semanticLabel: semanticLabel,
              ),
            );
          },
        );
}
