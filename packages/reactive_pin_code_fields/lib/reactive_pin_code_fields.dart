library reactive_pin_code_fields;

// Copyright 2020 Vasyl Dytsiak. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:reactive_forms/reactive_forms.dart';

export 'package:pin_code_fields/pin_code_fields.dart';

/// A [ReactivePinCodeTextField] that contains a [PinCodeTextField].
///
/// This is a convenience widget that wraps a [PinCodeTextField] widget in a
/// [ReactivePinCodeTextField].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactivePinCodeTextField<T> extends ReactiveFormField<T, String> {
  /// Creates a [ReactivePinCodeTextField] that contains a [PinCodeTextField].
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
  /// ReactivePinCodeTextField(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactivePinCodeTextField(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactivePinCodeTextField(
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
  /// ReactivePinCodeTextField(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [PinCodeTextField] class
  /// and [PinCodeTextField], the constructor.
  ReactivePinCodeTextField({
    Key? key,
    String? formControlName,
    FormControl<T>? formControl,
    ValidationMessagesFunction<T>? validationMessages,
    ControlValueAccessor<T, String>? valueAccessor,
    ShowErrorsFunction? showErrors,

    ////////////////////////////////////////////////////////////////////////////
    bool obscureText = false,
    List<BoxShadow>? boxShadows,
    required int length,
    String obscuringCharacter = '●',
    Widget? obscuringWidget,
    bool useHapticFeedback = false,
    HapticFeedbackTypes hapticFeedbackTypes = HapticFeedbackTypes.light,
    bool blinkWhenObscuring = false,
    Duration blinkDuration = const Duration(milliseconds: 500),
    ValueChanged<String>? onCompleted,
    ValueChanged<String>? onSubmitted,
    TextStyle? textStyle,
    TextStyle? pastedTextStyle,
    Color? backgroundColor,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.spaceBetween,
    AnimationType animationType = AnimationType.slide,
    Duration animationDuration = const Duration(milliseconds: 150),
    Curve animationCurve = Curves.easeInOut,
    TextInputType keyboardType = TextInputType.visiblePassword,
    bool autofocus = false,
    FocusNode? focusNode,
    List<TextInputFormatter> inputFormatters = const <TextInputFormatter>[],
    TextEditingController? controller,
    bool enableActiveFill = false,
    bool autoDismissKeyboard = true,
    // bool autoDisposeControllers = true,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputAction textInputAction = TextInputAction.done,
    StreamController<ErrorAnimationType>? errorAnimationController,
    bool Function(String? text)? beforeTextPaste,
    Function? onTap,
    DialogConfig? dialogConfig,
    PinTheme pinTheme = const PinTheme.defaults(),
    Brightness? keyboardAppearance,
    FormFieldValidator<String>? validator,
    FormFieldSetter<String>? onSaved,
    double errorTextSpace = 16,
    bool enablePinAutofill = true,
    int errorAnimationDuration = 500,
    bool showCursor = true,
    Color? cursorColor,
    double cursorWidth = 2,
    double? cursorHeight,
    AutofillContextAction onAutoFillDisposeAction =
        AutofillContextAction.commit,
    bool useExternalAutoFillGroup = false,
    String? hintCharacter,
    TextStyle? hintStyle,
    bool readOnly = false,
    Gradient? textGradient,
    EdgeInsets scrollPadding = const EdgeInsets.all(20),
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          valueAccessor: valueAccessor,
          validationMessages: validationMessages,
          showErrors: showErrors,
          builder: (field) {
            final state = field as _ReactivePinCodeTextFieldState<T>;
            // final effectiveDecoration = inputDecoration
            //     .applyDefaults(Theme.of(state.context).inputDecorationTheme);

            state._setFocusNode(focusNode);

            return PinCodeTextField(
              appContext: field.context,
              onChanged: field.didChange,
              focusNode: state.focusNode,
              controller: state._textController,
              length: length,
              enabled: field.control.enabled,
              obscureText: obscureText,
              obscuringCharacter: obscuringCharacter,
              obscuringWidget: obscuringWidget,
              blinkWhenObscuring: blinkWhenObscuring,
              blinkDuration: blinkDuration,
              onCompleted: onCompleted,
              backgroundColor: backgroundColor,
              mainAxisAlignment: mainAxisAlignment,
              animationDuration: animationDuration,
              animationCurve: animationCurve,
              animationType: animationType,
              keyboardType: keyboardType,
              autoFocus: autofocus,
              onTap: onTap,
              inputFormatters: inputFormatters,
              textStyle: textStyle,
              useHapticFeedback: useHapticFeedback,
              hapticFeedbackTypes: hapticFeedbackTypes,
              pastedTextStyle: pastedTextStyle,
              enableActiveFill: enableActiveFill,
              textCapitalization: textCapitalization,
              textInputAction: textInputAction,
              autoDismissKeyboard: autoDismissKeyboard,
              autoDisposeControllers: false,
              onSubmitted: onSubmitted,
              errorAnimationController: errorAnimationController,
              beforeTextPaste: beforeTextPaste,
              dialogConfig: dialogConfig,
              pinTheme: pinTheme,
              keyboardAppearance: keyboardAppearance,
              errorTextSpace: errorTextSpace,
              enablePinAutofill: enablePinAutofill,
              errorAnimationDuration: errorAnimationDuration,
              boxShadows: boxShadows,
              showCursor: showCursor,
              cursorColor: cursorColor,
              cursorWidth: cursorWidth,
              cursorHeight: cursorHeight,
              hintCharacter: hintCharacter,
              hintStyle: hintStyle,
              onAutoFillDisposeAction: onAutoFillDisposeAction,
              useExternalAutoFillGroup: useExternalAutoFillGroup,
              readOnly: readOnly,
              textGradient: textGradient,
              scrollPadding: scrollPadding,
            );
          },
        );

  @override
  ReactiveFormFieldState<T, String> createState() =>
      _ReactivePinCodeTextFieldState<T>();
}

class _ReactivePinCodeTextFieldState<T>
    extends ReactiveFormFieldState<T, String> {
  late TextEditingController _textController;
  FocusNode? _focusNode;
  late FocusController _focusController;

  FocusNode get focusNode => _focusNode ?? _focusController.focusNode;

  @override
  void initState() {
    super.initState();

    final initialValue = value;
    _textController = TextEditingController(
        text: initialValue == null ? '' : initialValue.toString());
  }

  @override
  void subscribeControl() {
    _registerFocusController(FocusController());
    super.subscribeControl();
  }

  @override
  void unsubscribeControl() {
    _unregisterFocusController();
    super.unsubscribeControl();
  }

  @override
  void onControlValueChanged(dynamic value) {
    final effectiveValue = (value == null) ? '' : value.toString();
    _textController.value = _textController.value.copyWith(
      text: effectiveValue,
      selection: TextSelection.collapsed(offset: effectiveValue.length),
      composing: TextRange.empty,
    );

    super.onControlValueChanged(value);
  }

  @override
  ControlValueAccessor<T, String> selectValueAccessor() {
    if (control is FormControl<int>) {
      return IntValueAccessor() as ControlValueAccessor<T, String>;
    } else if (control is FormControl<double>) {
      return DoubleValueAccessor() as ControlValueAccessor<T, String>;
    } else if (control is FormControl<DateTime>) {
      return DateTimeValueAccessor() as ControlValueAccessor<T, String>;
    } else if (control is FormControl<TimeOfDay>) {
      return TimeOfDayValueAccessor() as ControlValueAccessor<T, String>;
    }

    return super.selectValueAccessor();
  }

  void _registerFocusController(FocusController focusController) {
    _focusController = focusController;
    control.registerFocusController(focusController);
  }

  void _unregisterFocusController() {
    control.unregisterFocusController(_focusController);
    _focusController.dispose();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _setFocusNode(FocusNode? focusNode) {
    if (_focusNode != focusNode) {
      _focusNode = focusNode;
      _unregisterFocusController();
      _registerFocusController(FocusController(focusNode: _focusNode));
    }
  }
}
