import 'package:fluent_ui/fluent_ui.dart';

import 'package:reactive_forms/reactive_forms.dart';

/// A [ReactiveFluentDatePicker] that contains a [FluentUi].
///
/// This is a convenience widget that wraps a [FluentUi] widget in a
/// [ReactiveFluentDatePicker].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveFluentDatePicker<T> extends ReactiveFormField<T, DateTime> {
  /// Creates a [ReactiveFluentDatePicker] that contains a [FluentUi].
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
  /// ReactiveFluentDatePicker(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveFluentDatePicker(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveFluentDatePicker(
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
  /// ReactiveFluentDatePicker(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [FluentUi] class
  /// and [FluentUi], the constructor.
  ReactiveFluentDatePicker({
    Key? key,
    Key? comboBoxKey,
    String? formControlName,
    FormControl<T>? formControl,
    Map<String, ValidationMessageFunction>? validationMessages,
    ControlValueAccessor<T, DateTime>? valueAccessor,
    ShowErrorsFunction<T>? showErrors,

    //////////////////////////////////////////////////////////////////////////
    VoidCallback? onCancel,
    HourFormat hourFormat = HourFormat.h,
    bool autofocus = false,
    int minuteIncrement = 1,
    String? header,
    TextStyle? headerStyle,
    EdgeInsetsGeometry contentPadding = const EdgeInsetsDirectional.only(
      start: 8.0,
      top: 4.0,
      bottom: 4.0,
    ),
    double popupHeight = 400,
    bool showDay = true,
    bool showMonth = true,
    bool showYear = true,
    Locale? locale,
    List<DatePickerField>? fieldOrder,
    DateTime? startDate,
    DateTime? endDate,
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          valueAccessor: valueAccessor,
          validationMessages: validationMessages,
          showErrors: showErrors,
          builder: (field) {
            final state = field as _ReactiveFluentDatePickerState<T>;
            return DatePicker(
              key: comboBoxKey,
              focusNode: state.focusNode,
              selected: field.value,
              onChanged: field.didChange,
              onCancel: onCancel,
              header: header,
              headerStyle: headerStyle,
              contentPadding: contentPadding,
              popupHeight: popupHeight,
              autofocus: autofocus,
              showDay: showDay,
              showMonth: showMonth,
              showYear: showYear,
              startDate: startDate,
              endDate: endDate,
              locale: locale,
              fieldOrder: fieldOrder,
            );
          },
        );

  @override
  ReactiveFormFieldState<T, DateTime> createState() =>
      _ReactiveFluentDatePickerState<T>();
}

class _ReactiveFluentDatePickerState<T>
    extends ReactiveFocusableFormFieldState<T, DateTime> {}
