import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// A [ReactiveMacosRadioButton] that contains a [MacosRadioButton].
///
/// This is a convenience widget that wraps a [MacosRadioButton] widget in a
/// [ReactiveMacosRadioButton].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveMacosRadioButton<T, V> extends ReactiveFormField<T, V> {
  /// Creates a [ReactiveMacosRadioButton] that contains a [MacosRadioButton].
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
  /// ReactiveMacosRadioButton(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveMacosRadioButton(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveMacosRadioButton(
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
  /// ReactiveMacosRadioButton(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [MacosRadioButton] class
  /// and [new MacosRadioButton], the constructor.
  ReactiveMacosRadioButton({
    Key? key,
    String? formControlName,
    FormControl<T>? formControl,
    ValidationMessagesFunction<T>? validationMessages,
    ControlValueAccessor<T, V>? valueAccessor,
    ShowErrorsFunction? showErrors,

    ////////////////////////////////////////////////////////////////////////////
    InputDecoration decoration = const InputDecoration(
      border: InputBorder.none,
      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      isDense: true,
      isCollapsed: true,
    ),
    required V value,
    Color? innerColor,
    Color? onColor,
    double size = 16.0,
    Color offColor = CupertinoColors.tertiaryLabel,
    String? semanticLabel,
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          valueAccessor: valueAccessor,
          validationMessages: validationMessages,
          showErrors: showErrors,
          builder: (field) {
            // final InputDecoration effectiveDecoration = decoration
            //     .applyDefaults(Theme.of(field.context).inputDecorationTheme);

            return Listener(
                onPointerDown: (_) {
                  if (field.control.enabled) {
                    field.control.markAsTouched();
                  }
                },
                child: MacosRadioButton<V>(
                  groupValue: field.value,
                  value: value,
                  onChanged: field.control.enabled ? field.didChange : null,
                  size: size = 16.0,
                  onColor: onColor,
                  offColor: offColor = CupertinoColors.tertiaryLabel,
                  innerColor: innerColor,
                  semanticLabel: semanticLabel,
                )

                // InputDecorator(
                //   decoration: effectiveDecoration.copyWith(
                //     errorText: field.errorText,
                //     enabled: field.control.enabled,
                //   ),
                //   child: ,
                // ),
                );
          },
        );
}
