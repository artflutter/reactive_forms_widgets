// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.
//
// Ported from reactive_forms 18.2.2 (https://github.com/joanpablo/reactive_forms)
// to be built on top of package:material_ui instead of package:flutter/material.dart.

import 'package:material_ui/material_ui.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// This is a convenience widget that wraps a [Radio] widget in a
/// [ReactiveMaterialRadio].
///
/// The inner [Radio] is wrapped in its own [RadioGroup] whose
/// [RadioGroup.groupValue] is the control value, so every
/// [ReactiveMaterialRadio] bound to the same control behaves as one group
/// without having to add a [RadioGroup] yourself.
///
/// The [formControlName] is required to bind this [ReactiveMaterialRadio]
/// to a [FormControl].
///
/// For documentation about the various parameters, see the [Radio] class
/// and [Radio], the constructor.
class ReactiveMaterialRadio<T> extends ReactiveFocusableFormField<T, T> {
  /// Creates a [ReactiveMaterialRadio] that contains a [Radio].
  ///
  /// Can optionally provide a [formControl] to bind this widget to a control.
  ///
  /// Can optionally provide a [formControlName] to bind this ReactiveFormField
  /// to a [FormControl].
  ///
  /// Must provide one of the arguments [formControl] or a [formControlName],
  /// but not both at the same time.
  ///
  /// The [value] arguments is required. See [Radio] constructor.
  ///
  /// For documentation about the various parameters, see the [Radio] class
  /// and [Radio], the constructor.
  ReactiveMaterialRadio({
    super.key,
    super.formControlName,
    super.formControl,
    required T value,
    Color? activeColor,
    Color? focusColor,
    Color? hoverColor,
    WidgetStateProperty<Color?>? fillColor,
    WidgetStateProperty<Color?>? overlayColor,
    MouseCursor? mouseCursor,
    MaterialTapTargetSize? materialTapTargetSize,
    VisualDensity? visualDensity,
    double? splashRadius,
    bool autofocus = false,
    bool toggleable = false,
    super.focusNode,
    ReactiveFormFieldCallback<T>? onChanged,
  }) : super(
         builder: (field) {
           return RadioGroup<T>(
             groupValue: field.value,
             onChanged: (value) {
               if (field.control.disabled) {
                 return;
               }
               field.didChange(value);
               onChanged?.call(field.control);
             },
             child: Radio<T>(
               value: value,
               enabled: field.control.enabled,
               activeColor: activeColor,
               focusColor: focusColor,
               hoverColor: hoverColor,
               fillColor: fillColor,
               overlayColor: overlayColor,
               mouseCursor: mouseCursor,
               splashRadius: splashRadius,
               materialTapTargetSize: materialTapTargetSize,
               visualDensity: visualDensity,
               autofocus: autofocus,
               toggleable: toggleable,
               focusNode: field.focusNode,
             ),
           );
         },
       );
}
