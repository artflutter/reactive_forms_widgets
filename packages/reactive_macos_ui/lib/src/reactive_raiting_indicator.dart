import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// A [ReactiveRatingIndicator] that contains a [TouchSpin].
///
/// This is a convenience widget that wraps a [TouchSpin] widget in a
/// [ReactiveRatingIndicator].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveRatingIndicator<T> extends ReactiveFormField<T, double> {
  /// Creates a [ReactiveRatingIndicator] that contains a [TouchSpin].
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
  /// ReactiveRatingIndicator(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveRatingIndicator(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveRatingIndicator(
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
  /// ReactiveRatingIndicator(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [TouchSpin] class
  /// and [TouchSpin], the constructor.
  ReactiveRatingIndicator(
      {Key? key,
      String? formControlName,
      FormControl<T>? formControl,
      Map<String, ValidationMessageFunction>? validationMessages,
      ControlValueAccessor<T, double>? valueAccessor,
      ShowErrorsFunction<T>? showErrors,

      //////////////////////////////////////////////////////////////////////////
      InputDecoration decoration = const InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        isDense: true,
        isCollapsed: true,
      ),
      IconData ratedIcon = CupertinoIcons.star_fill,
      IconData unratedIcon = CupertinoIcons.star,
      Color? iconColor,
      double iconSize = 16,
      int amount = 5,
      String? semanticLabel})
      : super(
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
                child: RatingIndicator(
                  value: field.value ?? 0,
                  onChanged: field.didChange,
                  amount: amount,
                  ratedIcon: ratedIcon,
                  unratedIcon: unratedIcon,
                  iconColor: iconColor,
                  iconSize: iconSize,
                  semanticLabel: semanticLabel,
                ),
              ),
            );
          },
        );
}
