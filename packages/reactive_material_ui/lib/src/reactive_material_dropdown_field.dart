// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.
//
// Ported from reactive_forms 18.2.2 (https://github.com/joanpablo/reactive_forms)
// to be built on top of package:material_ui instead of package:flutter/material.dart.

import 'package:material_ui/material_ui.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// A reactive widget that wraps a [DropdownButtonFormField].
///
/// The control value is passed as [DropdownButtonFormField.initialValue].
/// [DropdownButtonFormField] updates its selected item whenever
/// `initialValue` changes, so programmatic changes of the control are shown.
/// If a selection made by the user is changed by the control (e.g. reverted
/// in [onChanged]), the field is synchronized back to the control value.
class ReactiveMaterialDropdownField<T>
    extends ReactiveFocusableFormField<T, T> {
  /// Creates a [DropdownButton] widget wrapped in an [InputDecorator].
  ///
  /// Can optionally provide a [formControl] to bind this widget to a control.
  ///
  /// Can optionally provide a [formControlName] to bind this ReactiveFormField
  /// to a [FormControl].
  ///
  /// Must provide one of the arguments [formControl] or a [formControlName],
  /// but not both at the same time.
  ///
  /// If [readOnly] is true, the button will be disabled, the down arrow will
  /// be grayed out, and the disabledHint will be shown (if provided).
  ///
  /// The [items] parameter must not be null.
  ///
  /// For more information about all various parameters,
  /// see [DropdownButtonFormField] constructor.
  ReactiveMaterialDropdownField({
    super.key,
    super.formControlName,
    super.formControl,
    super.focusNode,
    required List<DropdownMenuItem<T>> items,
    super.validationMessages,
    super.showErrors,
    DropdownButtonBuilder? selectedItemBuilder,
    Widget? hint,
    InputDecoration decoration = const InputDecoration(),
    Widget? disabledHint,
    int elevation = 8,
    TextStyle? style,
    Widget? icon,
    Color? iconDisabledColor,
    Color? iconEnabledColor,
    double iconSize = 24.0,
    bool isDense = true,
    bool isExpanded = false,
    bool readOnly = false,
    double? itemHeight,
    Color? dropdownColor,
    Color? focusColor,
    bool autofocus = false,
    double? menuMaxHeight,
    bool? enableFeedback,
    AlignmentGeometry alignment = AlignmentDirectional.centerStart,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry? padding,
    ReactiveFormFieldCallback<T>? onTap,
    ReactiveFormFieldCallback<T>? onChanged,
  }) : assert(itemHeight == null || itemHeight > 0),
       super(
         builder: (ReactiveFormFieldState<T, T> field) {
           final state = field as _ReactiveMaterialDropdownFieldState<T>;
           final effectiveDecoration = decoration.applyDefaults(
             Theme.of(field.context).inputDecorationTheme,
           );

           final effectiveValue = _effectiveValue(field.value, items);

           final isDisabled = readOnly || field.control.disabled;
           var effectiveDisabledHint = disabledHint;
           if (isDisabled && disabledHint == null) {
             final selectedItemIndex = items.indexWhere(
               (item) => item.value == effectiveValue,
             );
             if (selectedItemIndex > -1) {
               effectiveDisabledHint = selectedItemBuilder != null
                   ? selectedItemBuilder(field.context)
                         .elementAt(selectedItemIndex)
                   : items.elementAt(selectedItemIndex).child;
             }
           }

           return DropdownButtonFormField<T>(
             key: state._fieldKey,
             initialValue: effectiveValue,
             decoration: effectiveDecoration.copyWith(
               errorText: field.errorText,
               enabled: !isDisabled,
             ),
             items: items,
             selectedItemBuilder: selectedItemBuilder,
             hint: hint,
             disabledHint: effectiveDisabledHint,
             elevation: elevation,
             style: style,
             icon: icon,
             iconDisabledColor: iconDisabledColor,
             iconEnabledColor: iconEnabledColor,
             iconSize: iconSize,
             isDense: isDense,
             isExpanded: isExpanded,
             itemHeight: itemHeight,
             focusNode: field.focusNode,
             dropdownColor: dropdownColor,
             focusColor: focusColor,
             autofocus: autofocus,
             menuMaxHeight: menuMaxHeight,
             enableFeedback: enableFeedback,
             alignment: alignment,
             borderRadius: borderRadius,
             padding: padding,
             onTap: onTap != null ? () => onTap(field.control) : null,
             onChanged: isDisabled
                 ? null
                 : (value) {
                     if (state._isSynchronizing) {
                       return;
                     }
                     field.didChange(value);
                     onChanged?.call(field.control);
                     state._synchronize(_effectiveValue(field.value, items));
                   },
           );
         },
       );

  /// Returns [value] if one of the [items] has it, otherwise null.
  static T? _effectiveValue<T>(T? value, List<DropdownMenuItem<T>> items) {
    if (value != null && !items.any((item) => item.value == value)) {
      return null;
    }
    return value;
  }

  @override
  ReactiveFormFieldState<T, T> createState() =>
      _ReactiveMaterialDropdownFieldState<T>();
}

class _ReactiveMaterialDropdownFieldState<T>
    extends ReactiveFocusableFormFieldState<T, T> {
  final _fieldKey = GlobalKey<FormFieldState<T>>();
  bool _isSynchronizing = false;

  /// Shows [value] in the [DropdownButtonFormField] if it is showing another
  /// one.
  ///
  /// [DropdownButtonFormField] only follows `initialValue` when it changes
  /// between builds, so a user selection that the control did not keep would
  /// stay visible without this.
  void _synchronize(T? value) {
    final fieldState = _fieldKey.currentState;
    if (fieldState == null || fieldState.value == value) {
      return;
    }

    _isSynchronizing = true;
    try {
      fieldState.didChange(value);
    } finally {
      _isSynchronizing = false;
    }
  }
}
