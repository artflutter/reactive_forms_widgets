import 'package:fluent_ui/fluent_ui.dart';

import 'package:reactive_forms/reactive_forms.dart';

/// A [ReactiveFluentCheckBox] that contains a [FluentUi].
///
/// This is a convenience widget that wraps a [FluentUi] widget in a
/// [ReactiveFluentCheckBox].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveFluentCheckBox<T> extends ReactiveFocusableFormField<T, bool> {
  /// Creates a [ReactiveFluentCheckBox] that contains a [FluentUi].
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
  /// ReactiveFluentCheckBox(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveFluentCheckBox(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveFluentCheckBox(
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
  /// ReactiveFluentCheckBox(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [FluentUi] class
  /// and [FluentUi], the constructor.
  ReactiveFluentCheckBox({
    super.key,
    Key? widgetKey,
    super.formControlName,
    super.formControl,
    super.validationMessages,
    super.valueAccessor,
    super.showErrors,
    super.focusNode,

    //////////////////////////////////////////////////////////////////////////
    CheckboxThemeData? style,
    Widget? content,
    String? semanticLabel,
    bool autofocus = false,
  }) : super(
          builder: (field) {
            return Checkbox(
              key: widgetKey,
              checked: field.value,
              onChanged: field.didChange,
              style: style,
              content: content,
              semanticLabel: semanticLabel,
              focusNode: field.focusNode,
              autofocus: autofocus,
            );
          },
        );
}
