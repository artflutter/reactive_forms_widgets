import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'abstract_form_field.dart';
import 'hover_builder.dart';

enum MarkAsTouched {
  none,
  pointerUp,
  pointerDown;
}

const decorationInvisible = InputDecoration(
  border: InputBorder.none,
  enabledBorder: InputBorder.none,
  errorBorder: InputBorder.none,
  focusedBorder: InputBorder.none,
  focusedErrorBorder: InputBorder.none,
  disabledBorder: InputBorder.none,
  contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
  isDense: true,
  isCollapsed: true,
);

/// A [ReactiveInputDecorator] that contains a [InputDecorator].
///
/// This is a convenience widget that wraps a [InputDecorator] widget in a
/// [ReactiveInputDecorator].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveInputDecorator
    extends ReactiveFormFieldAbstract<dynamic, dynamic> {
  /// Creates a [ReactiveInputDecorator] that contains a [InputDecorator].
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
  /// ReactiveInputDecorator(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveInputDecorator(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveInputDecorator(
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
  /// ReactiveInputDecorator(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [InputDecorator] class
  /// and [InputDecorator], the constructor.
  ReactiveInputDecorator({
    super.key,
    super.formControlName,
    super.formControl,
    super.validationMessages,
    super.showErrors,

    //////////////////////////////////////////////////////////////////////////
    required Widget child,
    InputDecoration? decoration,
    bool expands = false,
    TextStyle? baseStyle,
    TextAlign? textAlign,
    TextAlignVertical? textAlignVertical,
    Widget Function(BuildContext context, String error)? errorBuilder,
    MarkAsTouched markAsTouched = MarkAsTouched.pointerDown,
    MouseCursor cursor = SystemMouseCursors.click,
  }) : super(
          builder: (field) {
            final effectiveDecoration = (decoration ?? const InputDecoration())
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);

            final errorText = field.errorText;

            return IgnorePointer(
              ignoring: !field.control.enabled,
              child: Listener(
                onPointerDown: markAsTouched == MarkAsTouched.pointerDown
                    ? (_) => field.control.markAsTouched()
                    : null,
                onPointerUp: markAsTouched == MarkAsTouched.pointerUp
                    ? (_) => field.control.markAsTouched()
                    : null,
                child: HoverBuilder(builder: (context, isHovered) {
                  return MouseRegion(
                    cursor: cursor,
                    child: InputDecorator(
                      decoration: effectiveDecoration.copyWith(
                          errorText:
                              errorBuilder == null ? field.errorText : null,
                          enabled: field.control.enabled,
                          error: errorBuilder != null && errorText != null
                              ? DefaultTextStyle.merge(
                                  style: Theme.of(field.context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: Theme.of(field.context)
                                            .colorScheme
                                            .error,
                                      )
                                      .merge(effectiveDecoration.errorStyle),
                                  child: errorBuilder.call(
                                    field.context,
                                    errorText,
                                  ),
                                )
                              : null),
                      expands: expands,
                      baseStyle: baseStyle,
                      textAlign: textAlign,
                      textAlignVertical: textAlignVertical,
                      isFocused: field.focusNode?.hasFocus ?? false,
                      child: child,
                    ),
                  );
                }),
              ),
            );
          },
        );
}

class ReactiveArrayDecorator
    extends ReactiveFormFieldAbstract<dynamic, dynamic> {
  ReactiveArrayDecorator({
    super.key,
    super.formControlName,
    super.formControl,
    super.validationMessages,
    super.showErrors,

    //////////////////////////////////////////////////////////////////////////
    required Widget child,
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
                onPointerDown: markAsTouched == MarkAsTouched.pointerDown
                    ? (_) => field.control.markAsTouched()
                    : null,
                onPointerUp: markAsTouched == MarkAsTouched.pointerUp
                    ? (_) => field.control.markAsTouched()
                    : null,
                child: InputDecorator(
                  decoration: effectiveDecoration.copyWith(
                      errorText: errorBuilder == null ? field.errorText : null,
                      enabled: field.control.enabled,
                      error: errorBuilder != null && errorText != null
                          ? DefaultTextStyle.merge(
                              style: Theme.of(field.context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: Theme.of(field.context)
                                        .colorScheme
                                        .error,
                                  )
                                  .merge(effectiveDecoration.errorStyle),
                              child: errorBuilder.call(
                                field.context,
                                errorText,
                              ),
                            )
                          : null),
                  expands: expands,
                  baseStyle: baseStyle,
                  textAlign: textAlign,
                  textAlignVertical: textAlignVertical,
                  isFocused: field.focusNode?.hasFocus ?? false,
                  child: child,
                ),
              ),
            );
          },
        );
}
