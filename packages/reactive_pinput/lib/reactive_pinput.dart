library reactive_pinput;

// Copyright 2020 Vasyl Dytsiak. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:reactive_forms/reactive_forms.dart';

export 'package:pinput/pinput.dart';
export 'package:smart_auth/smart_auth.dart';

/// A [ReactivePinPut] that contains a [PinPut].
///
/// This is a convenience widget that wraps a [PinPut] widget in a
/// [ReactivePinPut].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactivePinPut<T> extends ReactiveFormField<T, String> {
  /// Creates a [ReactivePinPut] that contains a [PinPut].
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
  /// ReactivePinPut(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactivePinPut(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactivePinPut(
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
  /// ReactivePinPut(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [PinPut] class
  /// and [PinPut], the constructor.
  ReactivePinPut({
    Key? key,
    String? formControlName,
    FormControl<T>? formControl,
    ValidationMessagesFunction<T>? validationMessages,
    ControlValueAccessor<T, String>? valueAccessor,
    ShowErrorsFunction? showErrors,

    ////////////////////////////////////////////////////////////////////////////
    required int length,
    VoidCallback? onTap,
    TextInputType keyboardType = TextInputType.number,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputAction? textInputAction,
    bool autofocus = false,
    ToolbarOptions toolbarOptions = const ToolbarOptions(paste: true),
    bool obscureText = false,
    List<TextInputFormatter> inputFormatters = const [],
    Brightness? keyboardAppearance,
    FocusNode? focusNode,
    Widget? preFilledWidget,
    ValueChanged<String?>? onClipboardFound,
    List<int>? separatorPositions,
    SizedBox separator = const SizedBox(width: 15.0),
    TextStyle? textStyle,
    Curve animationCurve = Curves.linear,
    Duration animationDuration = const Duration(milliseconds: 160),
    PinAnimationType pinAnimationType = PinAnimationType.slide,
    Offset? slideTransitionBeginOffset,
    bool checkClipboard = false,
    bool useNativeKeyboard = true,
    Widget? cursor,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    ValueChanged<String>? onSubmit,
    PinTheme? defaultPinTheme,
    PinTheme? focusedPinTheme,
    PinTheme? submittedPinTheme,
    PinTheme? followingPinTheme,
    PinTheme? disabledPinTheme,
    PinTheme? errorPinTheme,
    String obscuringCharacter = '•',
    Widget? obscuringWidget,
    AndroidSmsAutofillMethod androidSmsAutofillMethod =
        AndroidSmsAutofillMethod.none,
    bool listenForMultipleSmsOnAndroid = false,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
    Alignment pinContentAlignment = Alignment.center,
    HapticFeedbackType hapticFeedbackType = HapticFeedbackType.disabled,
    bool closeKeyboardWhenCompleted = true,
    bool enableSuggestions = true,
    bool showCursor = true,
    bool toolbarEnabled = true,
    bool readOnly = false,
    bool forceErrorState = false,
    String? smsCodeMatcher = '\\d{4,7}',
    ValueChanged<String>? onCompleted,
    ValueChanged<String>? onSubmitted,
    VoidCallback? onLongPress,
    String? restorationId,
    TextStyle? errorTextStyle,
    MouseCursor? mouseCursor,
    AppPrivateCommandCallback? onAppPrivateCommand,
    TextSelectionControls? selectionControls,
    Iterable<String>? autofillHints,
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          valueAccessor: valueAccessor,
          validationMessages: validationMessages,
          showErrors: showErrors,
          builder: (field) {
            final state = field as _ReactiveMacosTextFieldState<T>;

            state._setFocusNode(focusNode);

            return Pinput(
              controller: state._textController,
              focusNode: state.focusNode,
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              textCapitalization: textCapitalization,
              toolbarOptions: toolbarOptions,
              autofocus: autofocus,
              onTap: onTap,
              obscureText: obscureText,
              onChanged: field.didChange,
              inputFormatters: inputFormatters,
              enabled: field.control.enabled,
              keyboardAppearance: keyboardAppearance,
              onClipboardFound: onClipboardFound,
              preFilledWidget: preFilledWidget,
              separatorPositions: separatorPositions,
              separator: separator,
              animationCurve: animationCurve,
              animationDuration: animationDuration,
              pinAnimationType: pinAnimationType,
              slideTransitionBeginOffset: slideTransitionBeginOffset,
              useNativeKeyboard: useNativeKeyboard,
              cursor: cursor,
              length: length,
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: focusedPinTheme,
              submittedPinTheme: submittedPinTheme,
              followingPinTheme: followingPinTheme,
              disabledPinTheme: disabledPinTheme,
              errorPinTheme: errorPinTheme,
              obscuringCharacter: obscuringCharacter,
              obscuringWidget: obscuringWidget,
              androidSmsAutofillMethod: androidSmsAutofillMethod,
              listenForMultipleSmsOnAndroid: listenForMultipleSmsOnAndroid,
              mainAxisAlignment: mainAxisAlignment,
              crossAxisAlignment: crossAxisAlignment,
              pinContentAlignment: pinContentAlignment,
              errorTextStyle: errorTextStyle,
              // errorBuilder: errorBuilder,
              errorText: state.errorText,
              forceErrorState: forceErrorState,
              mouseCursor: mouseCursor,
              onAppPrivateCommand: onAppPrivateCommand,
              restorationId: restorationId,
              selectionControls: selectionControls,
              autofillHints: autofillHints,
              closeKeyboardWhenCompleted: closeKeyboardWhenCompleted,
              hapticFeedbackType: hapticFeedbackType,
              enableSuggestions: enableSuggestions,
              showCursor: showCursor,
              toolbarEnabled: toolbarEnabled,
              readOnly: readOnly,
              smsCodeMatcher: smsCodeMatcher,
              onCompleted: onCompleted,
              onSubmitted: onSubmitted,
              onLongPress: onLongPress,
            );
          },
        );

  @override
  ReactiveFormFieldState<T, String> createState() =>
      _ReactiveMacosTextFieldState<T>();
}

class _ReactiveMacosTextFieldState<T>
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

  void _setFocusNode(FocusNode? focusNode) {
    if (_focusNode != focusNode) {
      _focusNode = focusNode;
      _unregisterFocusController();
      _registerFocusController(FocusController(focusNode: _focusNode));
    }
  }
}
