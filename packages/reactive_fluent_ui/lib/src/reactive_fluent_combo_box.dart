import 'package:fluent_ui/fluent_ui.dart';

import 'package:reactive_forms/reactive_forms.dart';

/// A [ReactiveFluentComboBox] that contains a [FluentUi].
///
/// This is a convenience widget that wraps a [FluentUi] widget in a
/// [ReactiveFluentComboBox].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveFluentComboBox<T, V> extends ReactiveFocusableFormField<T, V> {
  /// Creates a [ReactiveFluentComboBox] that contains a [FluentUi].
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
  /// ReactiveFluentComboBox(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveFluentComboBox(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveFluentComboBox(
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
  /// ReactiveFluentComboBox(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [FluentUi] class
  /// and [FluentUi], the constructor.
  ReactiveFluentComboBox({
    super.key,
    Key? comboBoxKey,
    super.formControlName,
    super.formControl,
    super.validationMessages,
    super.valueAccessor,
    super.showErrors,
    super.focusNode,

    //////////////////////////////////////////////////////////////////////////
    required List<ComboBoxItem<V>> items,
    int elevation = 8,
    Widget icon = const Icon(FluentIcons.chevron_down),
    double iconSize = 8.0,
    bool isExpanded = false,
    Color? focusColor,
    Widget? placeholder,
    ComboBoxBuilder? selectedItemBuilder,
    Widget? disabledPlaceholder,
    VoidCallback? onTap,
    TextStyle? style,
    Color? iconDisabledColor,
    Color? iconEnabledColor,
    Color? popupColor,
    bool autofocus = false,
    BorderRadius? borderRadius,
    double? menuMaxHeight,
    bool? enableFeedback,
    AlignmentGeometry alignment = AlignmentDirectional.centerStart,
  }) : super(
          builder: (field) {
            return ComboboxFormField<V>(
              key: comboBoxKey,
              items: items,
              focusNode: field.focusNode,
              value: field.value,
              selectedItemBuilder: selectedItemBuilder,
              placeholder: placeholder,
              disabledPlaceholder: disabledPlaceholder,
              onChanged: field.didChange,
              onTap: onTap,
              elevation: elevation,
              style: style,
              icon: icon,
              iconDisabledColor: iconDisabledColor,
              iconEnabledColor: iconEnabledColor,
              iconSize: iconSize,
              isExpanded: isExpanded,
              focusColor: focusColor,
              autofocus: autofocus,
              popupColor: popupColor,
              validator: (_) => field.errorText,
              autovalidateMode: AutovalidateMode.always,
              menuMaxHeight: menuMaxHeight,
              enableFeedback: enableFeedback,
              alignment: alignment,
              borderRadius: borderRadius,
            );
          },
        );
}
