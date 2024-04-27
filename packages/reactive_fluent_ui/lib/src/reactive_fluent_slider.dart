import 'package:fluent_ui/fluent_ui.dart';

import 'package:reactive_forms/reactive_forms.dart';

/// A [ReactiveFluentSlider] that contains a [FluentUi].
///
/// This is a convenience widget that wraps a [FluentUi] widget in a
/// [ReactiveFluentSlider].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveFluentSlider<T> extends ReactiveFormField<T, double> {
  /// Creates a [ReactiveFluentSlider] that contains a [FluentUi].
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
  /// ReactiveFluentSlider(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveFluentSlider(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveFluentSlider(
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
  /// ReactiveFluentSlider(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [FluentUi] class
  /// and [FluentUi], the constructor.
  ReactiveFluentSlider({
    super.key,
    Key? widgetKey,
    super.formControlName,
    super.formControl,
    super.validationMessages,
    super.valueAccessor,
    super.showErrors,

    //////////////////////////////////////////////////////////////////////////
    super.focusNode,
    double min = 0.0,
    double max = 100.0,
    bool autofocus = false,
    bool vertical = false,
    MouseCursor mouseCursor = MouseCursor.defer,
    ValueChanged<double>? onChangeStart,
    ValueChanged<double>? onChangeEnd,
    int? divisions,
    SliderThemeData? style,
    String? label,
  }) : super(
          builder: (field) {
            final state = field as _ReactiveFluentSliderState<T>;

            return Slider(
              key: widgetKey,
              value: field.value ?? min,
              onChanged: field.didChange,
              focusNode: state.focusNode,
              autofocus: autofocus,
              onChangeStart: onChangeStart,
              onChangeEnd: onChangeEnd,
              divisions: divisions,
              style: style,
              label: label,
              vertical: vertical,
              mouseCursor: mouseCursor,
            );
          },
        );

  @override
  ReactiveFormFieldState<T, double> createState() =>
      _ReactiveFluentSliderState<T>();
}

class _ReactiveFluentSliderState<T>
    extends ReactiveFocusableFormFieldState<T, double> {}
