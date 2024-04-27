import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';

const List<Color> _defaultColors = [
  Colors.red,
  Colors.pink,
  Colors.purple,
  Colors.deepPurple,
  Colors.indigo,
  Colors.blue,
  Colors.lightBlue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.lightGreen,
  Colors.lime,
  Colors.yellow,
  Colors.amber,
  Colors.orange,
  Colors.deepOrange,
  Colors.brown,
  Colors.grey,
  Colors.blueGrey,
  Colors.black,
];

// Provide a shape for [BlockPicker].
Widget _defaultItemBuilder(
    Color color, bool isCurrentColor, void Function() changeColor) {
  return Container(
    margin: const EdgeInsets.all(7),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: color,
      boxShadow: [
        BoxShadow(
            color: color.withOpacity(0.8),
            offset: const Offset(1, 2),
            blurRadius: 5)
      ],
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: changeColor,
        borderRadius: BorderRadius.circular(50),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 210),
          opacity: isCurrentColor ? 1 : 0,
          child: Icon(Icons.done,
              color: useWhiteForeground(color) ? Colors.white : Colors.black),
        ),
      ),
    ),
  );
}

/// A builder that builds a widget responsible to decide when to show
/// the picker dialog.
///
/// It has a property to access the [FormControl]
/// that is bound to [ReactiveBlockColorPicker].
///
/// The [formControlName] is required to bind this [ReactiveBlockColorPicker]
/// to a [FormControl].
///
/// ## Example:
///
/// ```dart
/// ReactiveBlocColorPicker(
///   formControlName: 'birthday',
/// )
/// ```
class ReactiveBlockColorPicker<T> extends ReactiveFormField<T, Color> {
  /// Creates a [ReactiveBlockColorPicker] that wraps the function [showDatePicker].
  ///
  /// Can optionally provide a [formControl] to bind this widget to a control.
  ///
  /// Can optionally provide a [formControlName] to bind this ReactiveFormField
  /// to a [FormControl].
  ///
  /// Must provide one of the arguments [formControl] or a [formControlName],
  /// but not both at the same time.
  ReactiveBlockColorPicker({
    super.key,
    super.formControlName,
    super.formControl,
    super.validationMessages,
    ControlValueAccessor<T, double>? valueAccessor,
    ShowErrorsFunction<T>? showErrors,

    ////////////////////////////////////////////////////////////////////////////
    InputDecoration? decoration,
    Color? pickerColor,
    List<Color> availableColors = _defaultColors,
    PickerLayoutBuilder? layoutBuilder,
    bool useInShowDialog = true,
    PickerItemBuilder itemBuilder = _defaultItemBuilder,
    double disabledOpacity = 0.5,
  }) : super(
          builder: (field) {
            final isEmptyValue =
                field.value == null || field.value.toString().isEmpty;

            final InputDecoration effectiveDecoration = (decoration ??
                    const InputDecoration())
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);

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
                    ),
                    isEmpty:
                        isEmptyValue && effectiveDecoration.hintText == null,
                    child: BlockPicker(
                      pickerColor: field.value ?? Colors.transparent,
                      availableColors: availableColors,
                      useInShowDialog: useInShowDialog,
                      onColorChanged: field.didChange,
                      layoutBuilder: layoutBuilder ??
                          (BuildContext context, List<Color> colors,
                              PickerItem child) {
                            return Wrap(
                              children: colors
                                  .map((Color color) => child(color))
                                  .toList(),
                            );
                          },
                      itemBuilder: itemBuilder,
                    ),
                  ),
                ),
              ),
            );
          },
        );
}
