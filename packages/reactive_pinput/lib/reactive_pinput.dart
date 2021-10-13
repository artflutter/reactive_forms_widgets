library reactive_pinput;

// Copyright 2020 Vasyl Dytsiak. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/cupertino.dart' hide OverlayVisibilityMode;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:reactive_forms/src/value_accessors/control_value_accessor.dart';
import 'package:reactive_forms/src/value_accessors/double_value_accessor.dart';
import 'package:reactive_forms/src/value_accessors/int_value_accessor.dart';

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
  /// and [new PinPut], the constructor.
  ReactivePinPut(
      {Key? key,
      String? formControlName,
      FormControl<T>? formControl,
      ValidationMessagesFunction<T>? validationMessages,
      ControlValueAccessor<T, String>? valueAccessor,
      ShowErrorsFunction? showErrors,

      ////////////////////////////////////////////////////////////////////////////
      required int fieldsCount,
      VoidCallback? onTap,
      TextInputType keyboardType = TextInputType.number,
      TextCapitalization textCapitalization = TextCapitalization.none,
      TextInputAction? textInputAction,
      bool autofocus = false,
      ToolbarOptions? toolbarOptions,
      String? obscureText,
      List<TextInputFormatter>? inputFormatters,
      Brightness? keyboardAppearance,
      FocusNode? focusNode,
      Widget? preFilledWidget,
      ValueChanged<String?>? onClipboardFound,
      List<int> separatorPositions = const [],
      SizedBox separator = const SizedBox(width: 15.0),
      TextStyle? textStyle,
      BoxDecoration? submittedFieldDecoration,
      BoxDecoration? selectedFieldDecoration,
      BoxDecoration? followingFieldDecoration,
      BoxDecoration? disabledDecoration,
      double? eachFieldWidth,
      double? eachFieldHeight,
      MainAxisAlignment fieldsAlignment = MainAxisAlignment.spaceBetween,
      AlignmentGeometry eachFieldAlignment = Alignment.center,
      EdgeInsetsGeometry? eachFieldMargin,
      EdgeInsetsGeometry? eachFieldPadding,
      BoxConstraints eachFieldConstraints =
          const BoxConstraints(minHeight: 40.0, minWidth: 40.0),
      InputDecoration inputDecoration = const InputDecoration(
        contentPadding: EdgeInsets.zero,
        border: InputBorder.none,
        counterText: '',
      ),
      Curve animationCurve = Curves.linear,
      Duration animationDuration = const Duration(milliseconds: 160),
      PinAnimationType pinAnimationType = PinAnimationType.slide,
      Offset? slideTransitionBeginOffset,
      bool checkClipboard = false,
      bool useNativeKeyboard = true,
      bool withCursor = false,
      Widget? cursor,
      MainAxisSize mainAxisSize = MainAxisSize.max,
      AutovalidateMode autovalidateMode = AutovalidateMode.disabled})
      : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          valueAccessor: valueAccessor,
          validationMessages: validationMessages,
          showErrors: showErrors,
          builder: (field) {
            final state = field as _ReactiveMacosTextFieldState<T>;
            final effectiveDecoration = inputDecoration
                .applyDefaults(Theme.of(state.context).inputDecorationTheme);

            return PinPut(
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
              fieldsCount: fieldsCount,
              // onSubmit: onSubmit,
              // onSaved: onSaved,
              onClipboardFound: onClipboardFound,
              preFilledWidget: preFilledWidget,
              separatorPositions: separatorPositions,
              separator: separator,
              textStyle: textStyle,
              submittedFieldDecoration: submittedFieldDecoration,
              selectedFieldDecoration: selectedFieldDecoration,
              followingFieldDecoration: followingFieldDecoration,
              disabledDecoration: disabledDecoration,
              eachFieldWidth: eachFieldWidth,
              eachFieldHeight: eachFieldHeight,
              fieldsAlignment: fieldsAlignment,
              eachFieldAlignment: eachFieldAlignment,
              eachFieldMargin: eachFieldMargin,
              eachFieldPadding: eachFieldPadding,
              eachFieldConstraints: eachFieldConstraints,
              inputDecoration: effectiveDecoration,
              animationCurve: animationCurve,
              animationDuration: animationDuration,
              pinAnimationType: pinAnimationType,
              slideTransitionBeginOffset: slideTransitionBeginOffset,
              checkClipboard: checkClipboard,
              useNativeKeyboard: useNativeKeyboard,
              autovalidateMode: autovalidateMode,
              withCursor: withCursor,
              cursor: cursor,
              mainAxisSize: mainAxisSize,
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
