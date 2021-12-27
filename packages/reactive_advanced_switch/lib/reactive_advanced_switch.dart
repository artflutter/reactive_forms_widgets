library reactive_advanced_switch;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// A [ReactiveAdvancedSwitch] that contains a [AdvancedSwitch].
///
/// This is a convenience widget that wraps a [AdvancedSwitch] widget in a
/// [ReactiveAdvancedSwitch].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveAdvancedSwitch<T> extends ReactiveFormField<T, bool> {
  /// Creates a [ReactiveAdvancedSwitch] that contains a [AdvancedSwitch].
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
  /// ReactiveAdvancedSwitch(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveAdvancedSwitch(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveAdvancedSwitch(
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
  /// ReactiveAdvancedSwitch(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [AdvancedSwitch] class
  /// and [new AdvancedSwitch], the constructor.
  ReactiveAdvancedSwitch({
    Key? key,
    String? formControlName,
    FormControl<T>? formControl,
    ValidationMessagesFunction<T>? validationMessages,
    ControlValueAccessor<T, bool>? valueAccessor,
    ShowErrorsFunction? showErrors,

    ////////////////////////////////////////////////////////////////////////////
    InputDecoration? decoration = const InputDecoration(),
    Color activeColor = Colors.green,
    Color inactiveColor = Colors.grey,
    Widget? activeChild,
    Widget? inactiveChild,
    ImageProvider? activeImage,
    ImageProvider? inactiveImage,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(15)),
    double width = 50.0,
    double height = 30.0,
    Widget? thumb,
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          valueAccessor: valueAccessor,
          validationMessages: validationMessages,
          showErrors: showErrors,
          builder: (field) {
            final state = field as _ReactiveAdvancedSwitchState;
            final InputDecoration effectiveDecoration = (decoration ??
                    const InputDecoration())
                .applyDefaults(Theme.of(state.context).inputDecorationTheme);

            final child = AdvancedSwitch(
              controller: state._advancedSwitchController,
              activeColor: activeColor,
              inactiveColor: inactiveColor,
              activeChild: activeChild,
              inactiveChild: inactiveChild,
              activeImage: activeImage,
              inactiveImage: inactiveImage,
              borderRadius: borderRadius,
              width: width,
              height: height,
              enabled: field.control.enabled,
              thumb: thumb,
            );

            return InputDecorator(
              decoration: effectiveDecoration.copyWith(
                errorText: field.errorText,
                enabled: field.control.enabled,
              ),
              child: Row(children: [child]),
            );
          },
        );

  @override
  ReactiveFormFieldState<T, bool> createState() =>
      _ReactiveAdvancedSwitchState<T>();
}

class _ReactiveAdvancedSwitchState<T> extends ReactiveFormFieldState<T, bool> {
  late AdvancedSwitchController _advancedSwitchController;

  @override
  void initState() {
    super.initState();

    _advancedSwitchController = AdvancedSwitchController(
      valueAccessor.modelToViewValue(control.value) ?? false,
    )..addListener(
        () {
          control.markAsTouched();
          didChange(_advancedSwitchController.value);
        },
      );
  }

  @override
  void dispose() {
    _advancedSwitchController.dispose();
    super.dispose();
  }
}
