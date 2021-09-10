library reactive_cupertino_slider;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

// typedef ReactiveRangeSliderLabelBuilder = RangeLabels Function(RangeValues);

/// This is a convenience widget that wraps a [CupertinoSlider] widget in a
/// [ReactiveCupertinoSlider].
///
/// The [formControlName] is required to bind this [ReactiveCupertinoSlider]
/// to a [FormControl].
///
/// For documentation about the various parameters, see the [CupertinoSlider] class
/// and [new CupertinoSlider], the constructor.
class ReactiveCupertinoSlider<T> extends ReactiveFormField<T, double> {
  /// Creates an instance os a [ReactiveCupertinoSlider].
  ///
  /// Can optionally provide a [formControl] to bind this widget to a control.
  ///
  /// Can optionally provide a [formControlName] to bind this ReactiveFormField
  /// to a [FormControl].
  ///
  /// Must provide one of the arguments [formControl] or a [formControlName],
  /// but not both at the same time.
  ReactiveCupertinoSlider({
    Key? key,
    String? formControlName,
    FormControl<T>? formControl,
    ValidationMessagesFunction<T>? validationMessages,
    ControlValueAccessor<T, double>? valueAccessor,
    ShowErrorsFunction? showErrors,
    //////////////////////////////////////////////////////////////////
    InputDecoration decoration = const InputDecoration(
      isCollapsed: true,
      contentPadding: EdgeInsets.zero,
      border: InputBorder.none,
    ),
    ValueChanged<double>? onChangeStart,
    ValueChanged<double>? onChangeEnd,
    double min = 0.0,
    double max = 1.0,
    int? divisions,
    Color? activeColor,
    Color thumbColor = CupertinoColors.white,
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          validationMessages: validationMessages,
          valueAccessor: valueAccessor,
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
                child: CupertinoSlider(
                  value: field.value ?? 0.0,
                  onChanged: field.didChange,
                  onChangeStart: onChangeStart,
                  onChangeEnd: onChangeEnd,
                  min: min = 0.0,
                  max: max = 1.0,
                  divisions: divisions,
                  activeColor: activeColor,
                  thumbColor: thumbColor,
                ),
              ),
            );
          },
        );
}
