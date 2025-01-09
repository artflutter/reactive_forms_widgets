// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';

typedef ColorPickerBuilder<T> = Widget Function(
  void Function() pickColor,
  Color? color,
);

typedef ColorPickerDialogBuilder = Widget Function(
  ColorPicker colorPicker,
);

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
    super.key,
    super.formControlName,
    super.formControl,
    super.validationMessages,
    ControlValueAccessor<T, double>? valueAccessor,
    ShowErrorsFunction<T>? showErrors,

    ////////////////////////////////////////////////////////////////////////////
    Color? contrastIconColorLight,
    Color contrastIconColorDark = Colors.white,
    InputDecoration? decoration,
    PaletteType paletteType = PaletteType.hsv,
    bool enableAlpha = true,
    @Deprecated('Use empty list in [labelTypes] to disable label.')
    bool showLabel = true,
    @Deprecated(
        'Use Theme.of(context).textTheme.bodyText1 & 2 to alter text style.')
    TextStyle? labelTextStyle,
    bool displayThumbColor = false,
    bool portraitOnly = false,
    bool hexInputBar = false,
    double colorPickerWidth = 300.0,
    double pickerAreaHeightPercent = 1.0,
    BorderRadius pickerAreaBorderRadius = const BorderRadius.all(Radius.zero),
    double disabledOpacity = 0.5,
    HSVColor? pickerHsvColor,
    List<ColorLabelType> labelTypes = const [
      ColorLabelType.rgb,
      ColorLabelType.hsv,
      ColorLabelType.hsl
    ],
    TextEditingController? hexInputController,
    List<Color>? colorHistory,
    ValueChanged<List<Color>>? onHistoryChanged,
    ColorPickerBuilder<Color>? colorPickerBuilder,
    ColorPickerDialogBuilder? colorPickerDialogBuilder,
  }) : super(
          builder: (field) {
            void pickColor() {
              final _colorPicker = ColorPicker(
                pickerColor: field.value ?? Colors.transparent,
                onColorChanged: field.didChange,
                paletteType: paletteType,
                enableAlpha: enableAlpha,
                pickerHsvColor: pickerHsvColor,
                labelTypes: labelTypes,
                displayThumbColor: displayThumbColor,
                portraitOnly: portraitOnly,
                colorPickerWidth: colorPickerWidth,
                pickerAreaHeightPercent: pickerAreaHeightPercent,
                pickerAreaBorderRadius: pickerAreaBorderRadius,
                hexInputBar: hexInputBar,
                hexInputController: hexInputController,
                colorHistory: colorHistory,
                onHistoryChanged: onHistoryChanged,
              );

              showDialog<Color>(
                context: field.context,
                builder: (BuildContext context) {
                  return colorPickerDialogBuilder?.call(
                        _colorPicker,
                      ) ??
                      AlertDialog(
                        titlePadding: const EdgeInsets.all(0.0),
                        contentPadding: const EdgeInsets.all(0.0),
                        content: SingleChildScrollView(
                          child: _colorPicker,
                        ),
                      );
                },
              );
            }

            final value = field.value;

            final InputDecoration effectiveDecoration = (decoration ??
                    const InputDecoration())
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);

            final iconColor = (field.value?.computeLuminance() ?? 0) > 0.5
                ? contrastIconColorDark
                : contrastIconColorLight;

            return InputDecorator(
              decoration: effectiveDecoration.copyWith(
                errorText: field.errorText,
                enabled: field.control.enabled,
              ),
              child: IgnorePointer(
                ignoring: !field.control.enabled,
                child: Opacity(
                  opacity: field.control.enabled ? 1 : 0.5,
                  child: colorPickerBuilder?.call(
                        () => pickColor(),
                        value,
                      ) ??
                      ListTile(
                        tileColor: value,
                        trailing: Wrap(
                          children: [
                            IconButton(
                              color: iconColor,
                              icon: const Icon(Icons.edit),
                              onPressed: () => pickColor(),
                              splashRadius: 0.01,
                            ),
                            if (field.value != null)
                              IconButton(
                                color: iconColor,
                                icon: const Icon(Icons.clear),
                                onPressed: () => field.didChange(null),
                                splashRadius: 0.01,
                              ),
                          ],
                        ),
                        onTap: pickColor,
                      ),
                ),
              ),
            );
          },
        );
}
