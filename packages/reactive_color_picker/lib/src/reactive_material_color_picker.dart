import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';

/// A builder that builds a widget responsible to decide when to show
/// the picker dialog.
///
/// It has a property to access the [FormControl]
/// that is bound to [ReactiveMaterialColorPicker].
///
/// The [formControlName] is required to bind this [ReactiveMaterialColorPicker]
/// to a [FormControl].
///
/// ## Example:
///
/// ```dart
/// ReactiveBlocColorPicker(
///   formControlName: 'birthday',
/// )
/// ```
class ReactiveMaterialColorPicker<T> extends ReactiveFormField<T, Color> {
  /// Creates a [ReactiveMaterialColorPicker] that wraps the function [showDatePicker].
  ///
  /// Can optionally provide a [formControl] to bind this widget to a control.
  ///
  /// Can optionally provide a [formControlName] to bind this ReactiveFormField
  /// to a [FormControl].
  ///
  /// Must provide one of the arguments [formControl] or a [formControlName],
  /// but not both at the same time.
  ReactiveMaterialColorPicker({
    Key? key,
    String? formControlName,
    FormControl<T>? formControl,
    Map<String, ValidationMessageFunction>? validationMessages,
    ControlValueAccessor<T, double>? valueAccessor,
    ShowErrorsFunction? showErrors,

    ////////////////////////////////////////////////////////////////////////////
    InputDecoration? decoration,
    Color? pickerColor,
    Color? contrastIconColorLight,
    Color contrastIconColorDark = Colors.white,
    PickerLayoutBuilder? layoutBuilder,
    // PickerItemBuilder itemBuilder = BlockPicker.defaultItemBuilder,
    double disabledOpacity = 0.5,
    bool portraitOnly = false,
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
                      child: MaterialPicker(
                        pickerColor: pickerColor,
                        onColorChanged: onColorChanged,
                        portraitOnly: portraitOnly,
                        enableLabel: enableLabel,
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
                ? contrastIconColorLight
                : contrastIconColorDark;

            return IgnorePointer(
              ignoring: !field.control.enabled,
              child: Opacity(
                opacity: field.control.enabled ? 1 : disabledOpacity,
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
                    isEmpty:
                        isEmptyValue && effectiveDecoration.hintText == null,
                    child: Container(
                      color: field.value,
                    ),
                  ),
                ),
              ),
            );
          },
        );
}
