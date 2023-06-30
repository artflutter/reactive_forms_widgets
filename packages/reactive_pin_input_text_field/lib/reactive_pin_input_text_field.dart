library reactive_pin_input_text_field;

// Copyright 2020 Vasyl Dytsiak. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

export 'package:pin_input_text_field/pin_input_text_field.dart';

/// A [ReactivePinInputTextField] that contains a [PinInputTextField].
///
/// This is a convenience widget that wraps a [PinInputTextField] widget in a
/// [ReactivePinInputTextField].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactivePinInputTextField<T> extends ReactiveFormField<T, String> {
  /// Creates a [ReactivePinInputTextField] that contains a [PinInputTextField].
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
  /// ReactivePinInputTextField(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactivePinInputTextField(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactivePinInputTextField(
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
  /// ReactivePinInputTextField(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [PinInputTextField] class
  /// and [PinInputTextField], the constructor.
  ReactivePinInputTextField({
    Key? key,
    String? formControlName,
    FormControl<T>? formControl,
    Map<String, ValidationMessageFunction>? validationMessages,
    ControlValueAccessor<T, String>? valueAccessor,
    ShowErrorsFunction<T>? showErrors,

    ////////////////////////////////////////////////////////////////////////////
    FocusNode? focusNode,
    Cursor? cursor,
    ValueChanged<String>? onSubmit,
    int pinLength = 6,
    TextInputType keyboardType = TextInputType.phone,
    bool autoFocus = false,
    TextInputAction textInputAction = TextInputAction.done,
    bool autocorrect = false,
    bool enableInteractiveSelection = false,
    TextCapitalization? textCapitalization,
    Iterable<String>? autofillHints,
    List<TextInputFormatter>? inputFormatters,
    PinDecoration? decoration,
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

            return PinInputTextField(
              pinLength: pinLength,
              onSubmit: onSubmit,
              decoration: decoration ??
                  BoxLooseDecoration(
                    strokeColorBuilder: const FixedColorBuilder(Colors.cyan),
                  ),
              inputFormatters: inputFormatters,
              keyboardType: keyboardType,
              controller: state._textController,
              focusNode: state.focusNode,
              autoFocus: autoFocus,
              textInputAction: textInputAction,
              enabled: field.control.enabled,
              onChanged: field.didChange,
              textCapitalization: textCapitalization,
              autocorrect: autocorrect,
              enableInteractiveSelection: enableInteractiveSelection,
              autofillHints: autofillHints,
              cursor: cursor,
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

  @override
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
