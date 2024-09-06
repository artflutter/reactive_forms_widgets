import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:reactive_forms/reactive_forms.dart';

abstract class DropDownValueAccessor<T, V> {
  // <DateTime, String>
  DropDownValueAccessor();

  V? modelToViewValue(List<DropdownItem<V>> items, T? modelValue);

  T? viewToModelValue(List<DropdownItem<V>> items, V? modelValue);
}

class _DropDownValueAccessor<T, V> extends ControlValueAccessor<T, V> {
  final List<DropdownItem<V>> items;

  final DropDownValueAccessor<T, V> dropDownValueAccessor;

  _DropDownValueAccessor({
    this.items = const [],
    required this.dropDownValueAccessor,
  });

  @override
  V? modelToViewValue(T? modelValue) {
    return dropDownValueAccessor.modelToViewValue(items, modelValue);
  }

  @override
  T? viewToModelValue(V? viewValue) {
    return dropDownValueAccessor.viewToModelValue(items, viewValue);
  }
}

/// A [ReactiveDropdownButton2] that contains a [DropdownButton2].
///
/// This is a convenience widget that wraps a [DropdownButton2] widget in a
/// [ReactiveDropdownButton2].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveDropdownButton2<T, V> extends ReactiveFocusableFormField<T, V> {
  /// Creates a [ReactiveDropdownButton2] that contains a [DropdownButton2].
  ///
  /// Can optionally provide a [formControl] to bind this widget to a control.
  ///
  /// Can optionally provide a [formControlName] to bind this ReactiveFormField
  /// to a [FormControl].
  ///
  /// Must provide one of the arguments [formControl] or a [formControlName],
  /// but not both at the same time.
  ///
  /// Can optionally provide a [validationMessages] argument to customize a
  /// message for different kinds of validation errors.
  ///
  /// Can optionally provide a [valueAccessor] to set a custom value accessors.
  /// See [ControlValueAccessor].
  ///
  /// Can optionally provide a [showErrors] function to customize when to show
  /// validation messages. Reactive Widgets make validation messages visible
  /// when the control is INVALID and TOUCHED, this behavior can be customized
  /// in the [showErrors] function.
  ///
  /// ### Example:
  /// Binds a text field.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveDropdownButton2(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveDropdownButton2(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveDropdownButton2(
  ///   formControlName: 'email',
  ///   validationMessages: {
  ///     ValidationMessage.required: 'The email must not be empty',
  ///     ValidationMessage.email: 'The email must be a valid email',
  ///   }
  /// ),
  /// ```
  ///
  /// Customize when to show up validation messages.
  /// ```dart
  /// ReactiveDropdownButton2(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [DropdownButton2] class
  /// and [DropdownButton2], the constructor.
  ReactiveDropdownButton2({
    super.key,
    Key? widgetKey,
    super.formControlName,
    super.formControl,
    super.validationMessages,
    DropDownValueAccessor<T, V>? valueAccessor,
    super.showErrors,
    super.focusNode,

    //////////////////////////////////////////////////////////////////////////
    InputDecoration inputDecoration = const InputDecoration(
      border: InputBorder.none,
      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      isDense: true,
      isCollapsed: true,
    ),
    List<DropdownItem<V>>? items,
    DropdownButtonBuilder? selectedItemBuilder,
    T? value,
    Widget? hint,
    Widget? disabledHint,
    OnMenuStateChangeFn? onMenuStateChange,
    TextStyle? style,
    Widget? underline,
    bool isDense = false,
    bool isExpanded = false,
    bool autofocus = false,
    bool? enableFeedback,
    AlignmentGeometry alignment = AlignmentDirectional.centerStart,
    ButtonStyleData? errorButtonStyleData,
    ButtonStyleData? buttonStyleData,
    ButtonStyleData? disabledButtonStyleData,
    IconStyleData iconStyleData = const IconStyleData(),
    IconStyleData errorIconStyleData = const IconStyleData(),
    IconStyleData disabledIconStyleData = const IconStyleData(),
    DropdownStyleData dropdownStyleData = const DropdownStyleData(),
    MenuItemStyleData menuItemStyleData = const MenuItemStyleData(),
    Widget Function(BuildContext context, String error)? errorBuilder,
    DropdownSearchData<V>? dropdownSearchData,
    Widget? customButton,
    bool openWithLongPress = false,
    bool barrierDismissible = true,
    Color? barrierColor,
    String? barrierLabel,
    DropdownSeparator<V>? dropdownSeparator,
    bool barrierCoversButton = true,
    EdgeInsets padding = EdgeInsets.zero,
  }) : super(
          valueAccessor: valueAccessor != null
              ? _DropDownValueAccessor(
                  items: items ?? [],
                  dropDownValueAccessor: valueAccessor,
                )
              : null,
          builder: (field) {
            final effectiveDecoration = inputDecoration
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);

            final errorText = field.errorText;

            return InputDecorator(
              decoration: effectiveDecoration.copyWith(
                errorText: errorBuilder == null ? field.errorText : null,
                enabled: field.control.enabled,
                error: errorBuilder != null && errorText != null
                    ? DefaultTextStyle(
                        style: Theme.of(field.context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color:
                                      Theme.of(field.context).colorScheme.error,
                                ) ??
                            const TextStyle(),
                        child: errorBuilder.call(field.context, errorText),
                      )
                    : null,
              ),
              child: Padding(
                padding: padding,
                child: DropdownButton2<V>(
                  key: widgetKey,
                  items: items ?? [],
                  selectedItemBuilder: selectedItemBuilder,
                  value: field.value,
                  hint: hint,
                  disabledHint: disabledHint,
                  onChanged: field.control.disabled ? null : field.didChange,
                  onMenuStateChange: onMenuStateChange,
                  style: style,
                  underline: underline,
                  isDense: isDense,
                  isExpanded: isExpanded,
                  focusNode: field.focusNode,
                  autofocus: autofocus,
                  enableFeedback: enableFeedback,
                  alignment: alignment,
                  buttonStyleData: field.control.disabled
                      ? disabledButtonStyleData
                      : field.errorText != null
                          ? errorButtonStyleData ?? buttonStyleData
                          : buttonStyleData,
                  iconStyleData: field.control.disabled
                      ? disabledIconStyleData : field.errorText != null
                      ? errorIconStyleData
                      : iconStyleData,
                  dropdownStyleData: dropdownStyleData,
                  menuItemStyleData: menuItemStyleData,
                  dropdownSearchData: dropdownSearchData,
                  customButton: customButton,
                  openWithLongPress: openWithLongPress,
                  barrierDismissible: barrierDismissible,
                  barrierColor: barrierColor,
                  barrierLabel: barrierLabel,
                  dropdownSeparator: dropdownSeparator,
                  barrierCoversButton: barrierCoversButton,
                ),
              ),
            );
          },
        );
}
