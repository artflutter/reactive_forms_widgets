import 'package:fluent_ui/fluent_ui.dart';

import 'package:reactive_forms/reactive_forms.dart';

/// A [ReactiveFluentToggleSwitch] that contains a [FluentUi].
///
/// This is a convenience widget that wraps a [FluentUi] widget in a
/// [ReactiveFluentToggleSwitch].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveFluentToggleSwitch<T> extends ReactiveFormField<T, bool> {
  /// Creates a [ReactiveFluentToggleSwitch] that contains a [FluentUi].
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
  /// ReactiveFluentToggleSwitch(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveFluentToggleSwitch(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveFluentToggleSwitch(
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
  /// ReactiveFluentToggleSwitch(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [FluentUi] class
  /// and [FluentUi], the constructor.
  ReactiveFluentToggleSwitch({
    Key? key,
    Key? widgetKey,
    String? formControlName,
    FormControl<T>? formControl,
    Map<String, ValidationMessageFunction>? validationMessages,
    ControlValueAccessor<T, bool>? valueAccessor,
    ShowErrorsFunction? showErrors,

    //////////////////////////////////////////////////////////////////////////
    FocusNode? focusNode,
    ToggleSwitchThemeData? style,
    Widget? content,
    String? semanticLabel,
    bool autofocus = false,
    bool leadingContent = false,
    Widget? thumb,
    ToggleSwitchThumbBuilder? thumbBuilder,
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          valueAccessor: valueAccessor,
          validationMessages: validationMessages,
          showErrors: showErrors,
          focusNode: focusNode,
          builder: (field) {
            final state = field as _ReactiveFluentToggleSwitchState<T>;

            return ToggleSwitch(
              key: widgetKey,
              checked: field.value ?? false,
              onChanged: field.didChange,
              style: style,
              content: content,
              semanticLabel: semanticLabel,
              focusNode: state.focusNode,
              autofocus: autofocus,
              leadingContent: leadingContent,
              thumb: thumb,
              thumbBuilder: thumbBuilder,
            );
          },
        );

  @override
  ReactiveFormFieldState<T, bool> createState() =>
      _ReactiveFluentToggleSwitchState<T>();
}

class _ReactiveFluentToggleSwitchState<T>
    extends ReactiveFocusableFormFieldState<T, bool> {}
