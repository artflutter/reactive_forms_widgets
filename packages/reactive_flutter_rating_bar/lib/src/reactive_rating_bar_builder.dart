library;

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'typedef.dart';

export 'package:flutter_rating_bar/flutter_rating_bar.dart';

/// A [ReactiveRatingBarBuilder] that contains a [TouchSpin].
///
/// This is a convenience widget that wraps a [TouchSpin] widget in a
/// [ReactiveRatingBarBuilder].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveRatingBarBuilder<T> extends ReactiveFormField<T, double> {
  /// Creates a [ReactiveRatingBarBuilder] that contains a [TouchSpin].
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
  /// ReactiveRatingBarBuilder(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveRatingBarBuilder(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveRatingBarBuilder(
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
  /// ReactiveRatingBarBuilder(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [TouchSpin] class
  /// and [TouchSpin], the constructor.
  ReactiveRatingBarBuilder({
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
    required IndexedWidgetBuilder itemBuilder,
    RatingBarBuilder? ratingBarBuilder,
    Color? glowColor,
    double? maxRating,
    TextDirection? textDirection,
    Color? unratedColor,
    bool allowHalfRating = false,
    Axis direction = Axis.horizontal,
    bool glow = true,
    double glowRadius = 2,
    bool ignoreGestures = false,
    int itemCount = 5,
    EdgeInsets itemPadding = EdgeInsets.zero,
    double itemSize = 40.0,
    double minRating = 0,
    bool tapOnlyMode = false,
    bool updateOnDrag = false,
    WrapAlignment wrapAlignment = WrapAlignment.start,
  }) : super(
          builder: (field) {
            final InputDecoration effectiveDecoration = decoration
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);

            final child = RatingBar.builder(
              itemBuilder: itemBuilder,
              onRatingUpdate: field.didChange,
              glowColor: glowColor,
              maxRating: maxRating,
              textDirection: textDirection,
              unratedColor: unratedColor,
              allowHalfRating: allowHalfRating,
              direction: direction,
              glow: glow,
              glowRadius: glowRadius,
              ignoreGestures: ignoreGestures,
              initialRating: field.value ?? 0,
              itemCount: itemCount,
              itemPadding: itemPadding,
              itemSize: itemSize,
              minRating: minRating,
              tapOnlyMode: tapOnlyMode,
              updateOnDrag: updateOnDrag,
              wrapAlignment: wrapAlignment,
            );

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
                child: ratingBarBuilder?.call(field.context, child) ?? child,
              ),
            );
          },
        );
}
