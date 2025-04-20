library;

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

typedef ReactiveRangeSliderLabelBuilder = RangeLabels Function(RangeValues);

/// This is a convenience widget that wraps a [Slider] widget in a
/// [ReactiveRangeSlider].
///
/// The [formControlName] is required to bind this [ReactiveRangeSlider]
/// to a [FormControl].
///
/// For documentation about the various parameters, see the [Slider] class
/// and [Slider], the constructor.
class ReactiveRangeSlider<T> extends ReactiveFormField<T, RangeValues> {
  /// Creates an instance os a [ReactiveRangeSlider].
  ///
  /// Can optionally provide a [formControl] to bind this widget to a control.
  ///
  /// Can optionally provide a [formControlName] to bind this ReactiveFormField
  /// to a [FormControl].
  ///
  /// Must provide one of the arguments [formControl] or a [formControlName],
  /// but not both at the same time.
  ReactiveRangeSlider({
    super.key,
    super.formControlName,
    super.formControl,
    super.validationMessages,
    super.valueAccessor,
    super.showErrors,

    ////////////////////////////////////////////////////////////////////////////
    InputDecoration? decoration,
    ReactiveRangeSliderLabelBuilder? labelBuilder,
    ValueChanged<RangeValues>? onChanged,
    ValueChanged<RangeValues>? onChangeStart,
    ValueChanged<RangeValues>? onChangeEnd,
    double min = 0.0,
    double max = 1.0,
    int? divisions,
    RangeLabels? labels,
    Color? activeColor,
    Color? inactiveColor,
    SemanticFormatterCallback? semanticFormatterCallback,
    WidgetStateProperty<MouseCursor?>? mouseCursor,
    WidgetStateProperty<Color?>? overlayColor,
  }) : super(
          builder: (field) {
            final InputDecoration effectiveDecoration = (decoration ??
                    const InputDecoration())
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);

            var values = field.value;
            if (values == null) {
              values = RangeValues(min, max);
            } else if (values.start < min && values.end > max) {
              values = RangeValues(min, max);
            } else if (values.start < min) {
              values = RangeValues(min, values.end);
            } else if (values.end > max) {
              values = RangeValues(values.start, max);
            }

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
                child: RangeSlider(
                  values: values,
                  onChanged: field.control.enabled ? field.didChange : null,
                  min: min,
                  max: max,
                  divisions: divisions,
                  labels: labelBuilder != null ? labelBuilder(values) : labels,
                  activeColor: activeColor,
                  inactiveColor: inactiveColor,
                  semanticFormatterCallback: semanticFormatterCallback,
                  onChangeEnd: onChangeEnd,
                  onChangeStart: onChangeStart,
                  overlayColor: overlayColor,
                  mouseCursor: mouseCursor,
                ),
              ),
            );
          },
        );
}
