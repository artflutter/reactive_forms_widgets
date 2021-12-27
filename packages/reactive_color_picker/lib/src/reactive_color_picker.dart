import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';

/// A builder that builds a widget responsible to decide when to show
/// the picker dialog.
///
/// It has a property to access the [FormControl]
/// that is bound to [ReactiveColorPicker].
///
/// The [formControlName] is required to bind this [ReactiveColorPicker]
/// to a [FormControl].
///
/// ## Example:
///
/// ```dart
/// ReactiveBlocColorPicker(
///   formControlName: 'birthday',
/// )
/// ```
class ReactiveColorPicker<T> extends ReactiveFormField<T, Color> {
  /// Creates a [ReactiveColorPicker] that wraps the function [showDatePicker].
  ///
  /// Can optionally provide a [formControl] to bind this widget to a control.
  ///
  /// Can optionally provide a [formControlName] to bind this ReactiveFormField
  /// to a [FormControl].
  ///
  /// Must provide one of the arguments [formControl] or a [formControlName],
  /// but not both at the same time.
  ReactiveColorPicker({
    Key? key,
    String? formControlName,
    FormControl<T>? formControl,
    ValidationMessagesFunction<T>? validationMessages,
    ControlValueAccessor<T, double>? valueAccessor,
    ShowErrorsFunction? showErrors,

    ////////////////////////////////////////////////////////////////////////////
    Color? contrastIconColorLight,
    Color contrastIconColorDark = Colors.white,
    InputDecoration? decoration,
    PaletteType paletteType = PaletteType.hsv,
    bool enableAlpha = true,
    bool showLabel = true,
    TextStyle? labelTextStyle,
    bool displayThumbColor = false,
    bool portraitOnly = false,
    double colorPickerWidth = 300.0,
    double pickerAreaHeightPercent = 1.0,
    BorderRadius pickerAreaBorderRadius = const BorderRadius.all(Radius.zero),
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          validationMessages: validationMessages,
          builder: (field) {
            void _showDialog(
              BuildContext context, {
              required Color pickerColor,
              required ValueChanged<Color> onColorChanged,
              bool enableLabel = false,
            }) {
              showDialog<Color>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    titlePadding: const EdgeInsets.all(0.0),
                    contentPadding: const EdgeInsets.all(0.0),
                    content: SingleChildScrollView(
                      child: ColorPicker(
                        pickerColor: pickerColor,
                        onColorChanged: onColorChanged,
                        paletteType: paletteType,
                        enableAlpha: enableAlpha,
                        showLabel: showLabel,
                        labelTextStyle: labelTextStyle,
                        displayThumbColor: displayThumbColor,
                        portraitOnly: portraitOnly,
                        colorPickerWidth: colorPickerWidth,
                        pickerAreaHeightPercent: pickerAreaHeightPercent,
                        pickerAreaBorderRadius: pickerAreaBorderRadius,
                      ),
                    ),
                  );
                },
              );
            }

            final isEmptyValue =
                field.value == null || field.value.toString().isEmpty;

            final InputDecoration effectiveDecoration = (decoration ??
                    const InputDecoration())
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);

            final iconColor = (field.value?.computeLuminance() ?? 0) > 0.5
                ? contrastIconColorDark
                : contrastIconColorLight;

            return IgnorePointer(
              ignoring: !field.control.enabled,
              child: Listener(
                onPointerDown: (_) => field.control.markAsTouched(),
                child: InputDecorator(
                  decoration: effectiveDecoration.copyWith(
                    errorText: field.errorText,
                    enabled: field.control.enabled,
                    fillColor: field.value,
                    filled: field.value != null,
                    suffixIcon: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          color: iconColor,
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            _showDialog(
                              field.context,
                              pickerColor: field.value ?? Colors.transparent,
                              onColorChanged: field.didChange,
                            );
                          },
                          splashRadius: 0.01,
                        ),
                        if (field.value != null)
                          IconButton(
                            color: iconColor,
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              field.didChange(null);
                            },
                            splashRadius: 0.01,
                          ),
                      ],
                    ),
                  ),
                  isEmpty: isEmptyValue && effectiveDecoration.hintText == null,
                  child: Container(
                    color: field.value,
                  ),
                ),
              ),
            );
          },
        );
}
