import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_input_decorator/reactive_input_decorator.dart';

/// A [ReactiveInputDecorator] that contains a [InputDecorator].
///
/// This is a convenience widget that wraps a [InputDecorator] widget in a
/// [ReactiveInputDecorator].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveInputDecoratorStack extends ReactiveFormField<dynamic, dynamic> {
  /// Creates a [ReactiveInputDecoratorStack] that contains a [InputDecorator].
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
  /// ReactiveInputDecoratorStack(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveInputDecoratorStack(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveInputDecoratorStack(
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
  /// ReactiveInputDecoratorStack(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [InputDecorator] class
  /// and [InputDecorator], the constructor.
  ReactiveInputDecoratorStack({
    super.key,
    super.formControlName,
    super.formControl,
    super.validationMessages,
    super.valueAccessor,
    super.showErrors,

    //////////////////////////////////////////////////////////////////////////
    required List<Widget> children,
    required Widget? child,
    InputDecoration? decoration,
    bool expands = false,
    TextStyle? baseStyle,
    TextAlign? textAlign,
    TextAlignVertical? textAlignVertical,
    Widget Function(BuildContext context, String error)? errorBuilder,
    MarkAsTouched markAsTouched = MarkAsTouched.pointerDown,
  }) : super(
          builder: (field) {
            final effectiveDecoration = (decoration ?? const InputDecoration())
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);

            final errorText = field.errorText;

            return IgnorePointer(
              ignoring: !field.control.enabled,
              child: Listener(
                onPointerDown: markAsTouched == MarkAsTouched.pointerDown ? (_) => field.control.markAsTouched() : null,
                onPointerUp: markAsTouched == MarkAsTouched.pointerUp ? (_) => field.control.markAsTouched() : null,
                child: Stack(
                  children: [
                    InputDecorator(
                      decoration: effectiveDecoration.copyWith(
                          errorText: errorBuilder == null ? field.errorText : null,
                          enabled: field.control.enabled,
                          error: errorBuilder != null && errorText != null
                              ? DefaultTextStyle(
                            style: Theme.of(field.context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                              color:
                              Theme.of(field.context).colorScheme.error,
                            ) ??
                                const TextStyle(),
                            child: errorBuilder.call(field.context, errorText),
                          )
                              : null
                      ),
                      expands: expands,
                      baseStyle: baseStyle,
                      textAlign: textAlign,
                      textAlignVertical: textAlignVertical,
                      child: child,
                    ),
                    ...children
                  ],
                ),
              ),
            );
          },
        );
}
