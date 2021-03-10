// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:reactive_forms/reactive_forms.dart';

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
class ReactiveBlockColorPicker extends ReactiveFormField<Color> {
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
    Key key,
    String formControlName,
    FormControl formControl,
    TextStyle style,
    ControlValueAccessor valueAccessor,
    ValidationMessagesFunction validationMessages,
    InputDecoration decoration,
    bool showClearIcon = true,
    Widget clearIcon = const Icon(Icons.clear),

    // bloc picker params
    Color pickerColor,
    List<Color> availableColors = _defaultColors,
    PickerLayoutBuilder layoutBuilder,
    PickerItemBuilder itemBuilder = BlockPicker.defaultItemBuilder,
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          validationMessages: validationMessages,
          builder: (field) {
            final isEmptyValue =
                field.value == null || field.value.toString().isEmpty;

            final InputDecoration effectiveDecoration = (decoration ??
                    const InputDecoration())
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);

            return IgnorePointer(
              ignoring: !field.control.enabled,
              child: Listener(
                onPointerDown: (_) => field.control.markAsTouched(),
                child: InputDecorator(
                  decoration: effectiveDecoration.copyWith(
                    errorText: field.errorText,
                    enabled: field.control.enabled,
                  ),
                  isEmpty: isEmptyValue && effectiveDecoration.hintText == null,
                  child: BlockPicker(
                    pickerColor: field.value ?? Colors.transparent,
                    availableColors: availableColors,
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
            );
          },
        );
}
