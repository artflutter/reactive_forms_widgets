// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.
//
// Ported from reactive_forms 18.2.2 (https://github.com/joanpablo/reactive_forms)
// to be built on top of package:material_ui instead of package:flutter/material.dart.

import 'package:material_ui/material_ui.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// This is a convenience widget that wraps a [RadioListTile] widget in a
/// [ReactiveMaterialRadioListTile].
///
/// The inner [RadioListTile] is wrapped in its own [RadioGroup] whose
/// [RadioGroup.groupValue] is the control value, so every
/// [ReactiveMaterialRadioListTile] bound to the same control behaves as one group
/// without having to add a [RadioGroup] yourself.
///
/// The [formControlName] is required to bind this [ReactiveMaterialRadioListTile]
/// to a [FormControl].
///
/// For documentation about the various parameters, see the [RadioListTile]
/// class and [RadioListTile], the constructor.
class ReactiveMaterialRadioListTile<T>
    extends ReactiveFocusableFormField<T, T> {
  /// Create an instance of a [ReactiveMaterialRadioListTile].
  ///
  /// Can optionally provide a [formControl] to bind this widget to a control.
  ///
  /// Can optionally provide a [formControlName] to bind this ReactiveFormField
  /// to a [FormControl].
  ///
  /// Must provide one of the arguments [formControl] or a [formControlName],
  /// but not both at the same time.
  ///
  /// See also [RadioListTile]
  ReactiveMaterialRadioListTile({
    super.key,
    super.formControlName,
    super.formControl,
    required T value,
    Color? activeColor,
    Color? selectedTileColor,
    Color? tileColor,
    Widget? title,
    Widget? subtitle,
    bool isThreeLine = false,
    bool? dense,
    Widget? secondary,
    ListTileControlAffinity controlAffinity = ListTileControlAffinity.platform,
    EdgeInsetsGeometry? contentPadding,
    bool toggleable = false,
    ShapeBorder? shape,
    bool autofocus = false,
    bool selected = false,
    VisualDensity? visualDensity,
    super.focusNode,
    bool? enableFeedback,
    ReactiveFormFieldCallback<T>? onChanged,
    MouseCursor? mouseCursor,
    WidgetStateProperty<Color?>? fillColor,
    Color? hoverColor,
    WidgetStateProperty<Color?>? overlayColor,
    double? splashRadius,
    MaterialTapTargetSize? materialTapTargetSize,
    double radioScaleFactor = 1.0,
    ValueChanged<bool>? onFocusChange,
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
             child: RadioListTile<T>(
               value: value,
               enabled: field.control.enabled,
               mouseCursor: mouseCursor,
               activeColor: activeColor,
               hoverColor: hoverColor,
               overlayColor: overlayColor,
               materialTapTargetSize: materialTapTargetSize,
               fillColor: fillColor,
               splashRadius: splashRadius,
               onFocusChange: onFocusChange,
               selectedTileColor: selectedTileColor,
               tileColor: tileColor,
               title: title,
               subtitle: subtitle,
               isThreeLine: isThreeLine,
               dense: dense,
               secondary: secondary,
               controlAffinity: controlAffinity,
               contentPadding: contentPadding,
               toggleable: toggleable,
               shape: shape,
               selected: selected,
               autofocus: autofocus,
               visualDensity: visualDensity,
               focusNode: field.focusNode,
               enableFeedback: enableFeedback,
               radioScaleFactor: radioScaleFactor,
             ),
           );
         },
       );
}
