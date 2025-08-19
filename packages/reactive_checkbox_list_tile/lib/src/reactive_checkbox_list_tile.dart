import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// A [ReactiveCheckboxListTile] that contains a [CheckboxListTile].
///
/// This is a convenience widget that wraps a [CheckboxListTile] widget in a
/// [ReactiveCheckboxListTile].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveCheckboxListTile<T> extends ReactiveFocusableFormField<T, bool> {
  /// Create an instance of a [ReactiveCheckbox].
  ///
  /// Can optionally provide a [formControl] to bind this widget to a control.
  ///
  /// Can optionally provide a [formControlName] to bind this ReactiveFormField
  /// to a [FormControl].
  ///
  /// Must provide one of the arguments [formControl] or a [formControlName],
  /// but not both at the same time.
  ///
  /// For documentation about the various parameters, see the [CheckboxListTile]
  /// class and the [CheckboxListTile] constructor.
  ReactiveCheckboxListTile({
    super.key,
    super.formControlName,
    super.formControl,
    super.valueAccessor,
    super.showErrors,
    super.focusNode,

    ////////////////////////////////////////////////////////////////////////////
    Color? activeColor,
    Color? checkColor,
    Widget? title,
    Widget? subtitle,
    bool isThreeLine = false,
    bool selected = false,
    bool? dense,
    Widget? secondary,
    ListTileControlAffinity controlAffinity = ListTileControlAffinity.platform,
    bool autofocus = false,
    EdgeInsetsGeometry? contentPadding,
    bool tristate = false,
    Color? selectedTileColor,
    Color? tileColor,
    ShapeBorder? shape,
    VisualDensity? visualDensity,
    bool? enableFeedback,
    OutlinedBorder? checkboxShape,
    BorderSide? side,
    MouseCursor? mouseCursor,
    WidgetStateProperty<Color?>? fillColor,
    Color? hoverColor,
    WidgetStateProperty<Color?>? overlayColor,
    double? splashRadius,
    MaterialTapTargetSize? materialTapTargetSize,
    ValueChanged<bool>? onFocusChange,
    String? checkboxSemanticLabel,
  }) : super(
          builder: (field) {
            return CheckboxListTile(
              value: tristate ? field.value : field.value ?? false,
              mouseCursor: mouseCursor,
              fillColor: fillColor,
              hoverColor: hoverColor,
              overlayColor: overlayColor,
              materialTapTargetSize: materialTapTargetSize,
              splashRadius: splashRadius,
              activeColor: activeColor,
              checkColor: checkColor,
              onFocusChange: onFocusChange,
              isError: field.errorText != null,
              title: title,
              subtitle: subtitle,
              isThreeLine: isThreeLine,
              dense: dense,
              secondary: secondary,
              controlAffinity: controlAffinity,
              autofocus: autofocus,
              contentPadding: contentPadding,
              tristate: tristate,
              selectedTileColor: selectedTileColor,
              tileColor: tileColor,
              shape: shape,
              selected: selected,
              visualDensity: visualDensity,
              focusNode: field.focusNode,
              enableFeedback: enableFeedback,
              checkboxShape: checkboxShape,
              side: side,
              enabled: field.control.enabled,
              onChanged: field.control.enabled
                  ? (value) {
                      field.didChange(value);
                      field.control.markAsTouched();
                    }
                  : null,
              checkboxSemanticLabel: checkboxSemanticLabel,
            );
          },
        );
}
