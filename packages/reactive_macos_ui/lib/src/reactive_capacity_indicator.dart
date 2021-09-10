import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// A [ReactiveCapacityIndicator] that contains a [CapacityIndicator].
///
/// This is a convenience widget that wraps a [CapacityIndicator] widget in a
/// [ReactiveCapacityIndicator].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveCapacityIndicator<T> extends ReactiveFormField<T, double> {
  /// Creates a [ReactiveCapacityIndicator] that contains a [CapacityIndicator].
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
  /// ReactiveCapacityIndicator(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveCapacityIndicator(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveCapacityIndicator(
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
  /// ReactiveCapacityIndicator(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [CapacityIndicator] class
  /// and [new CapacityIndicator], the constructor.
  ReactiveCapacityIndicator({
    Key? key,
    String? formControlName,
    InputDecoration decoration = const InputDecoration(
      border: InputBorder.none,
      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      isDense: true,
      isCollapsed: true,
    ),
    FormControl<T>? formControl,
    ValidationMessagesFunction<T>? validationMessages,
    ControlValueAccessor<T, double>? valueAccessor,
    ShowErrorsFunction? showErrors,
    //////
    bool discrete = false,
    int splits = 10,
    Color color = CupertinoColors.systemGreen,
    Color borderColor = CupertinoColors.tertiaryLabel,
    Color backgroundColor = CupertinoColors.tertiarySystemGroupedBackground,
    String? semanticLabel,
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          valueAccessor: valueAccessor,
          validationMessages: validationMessages,
          showErrors: showErrors,
          builder: (field) {
            final InputDecoration effectiveDecoration = decoration
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
                child: CapacityIndicator(
                  value: field.value ?? 0,
                  onChanged: field.didChange,
                  discrete: discrete,
                  splits: splits,
                  color: color,
                  borderColor: borderColor,
                  backgroundColor: backgroundColor,
                  semanticLabel: semanticLabel,
                ),
              ),
            );
          },
        );
}
