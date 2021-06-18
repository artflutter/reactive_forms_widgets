library reactive_sleek_circular_slider;

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

export 'package:sleek_circular_slider/sleek_circular_slider.dart';

/// A [ReactiveSleekCircularSlider] that contains a [TouchSpin].
///
/// This is a convenience widget that wraps a [TouchSpin] widget in a
/// [ReactiveSleekCircularSlider].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveSleekCircularSlider extends ReactiveFormField<double, double> {
  /// Creates a [ReactiveSleekCircularSlider] that contains a [TouchSpin].
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
  /// ReactiveSleekCircularSlider(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveSleekCircularSlider(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveSleekCircularSlider(
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
  /// ReactiveSleekCircularSlider(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [TouchSpin] class
  /// and [new TouchSpin], the constructor.
  ReactiveSleekCircularSlider({
    Key? key,
    String? formControlName,
    InputDecoration? decoration,
    FormControl<double>? formControl,
    ValidationMessagesFunction? validationMessages,
    ControlValueAccessor<double, double>? valueAccessor,
    ShowErrorsFunction? showErrors,
    double min = 0,
    double max = 100,
    CircularSliderAppearance appearance = SleekCircularSlider.defaultAppearance,
    OnChange? onChangeStart,
    OnChange? onChangeEnd,
    InnerWidget? innerWidget,
    Alignment alignment = Alignment.topCenter,
    double widthFactor = 1,
    double heightFactor = 1,
    Clip clipBehavior = Clip.hardEdge,
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
                child: ClipRect(
                  clipBehavior: clipBehavior,
                  child: Align(
                    alignment: alignment,
                    heightFactor: heightFactor,
                    widthFactor: widthFactor,
                    child: Padding(
                      // ClipRect for some reason clips shadow on top and bottom
                      padding: EdgeInsets.symmetric(
                        vertical: (appearance.customWidths?.shadowWidth ??
                                appearance.progressBarWidth) *
                            0.18,
                      ),
                      child: SleekCircularSlider(
                        initialValue: field.value ?? 0,
                        min: min,
                        max: max,
                        appearance: appearance,
                        // onChange: field.didChange,
                        onChangeStart: onChangeStart,
                        onChangeEnd: field.didChange,
                        innerWidget: innerWidget,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
}
