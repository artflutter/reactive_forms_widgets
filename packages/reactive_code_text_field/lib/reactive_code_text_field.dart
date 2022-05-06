library reactive_code_text_field;

// Copyright 2020 Vasyl Dytsiak. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

export 'package:code_text_field/code_text_field.dart';

/// A [ReactiveCodeTextField] that contains a [CodeTextField].
///
/// This is a convenience widget that wraps a [CodeTextField] widget in a
/// [ReactiveCodeTextField].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveCodeTextField<T> extends ReactiveFormField<T, String> {
  /// Creates a [ReactiveCodeTextField] that contains a [CodeTextField].
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
  /// ReactiveCodeTextField(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveCodeTextField(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveCodeTextField(
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
  /// ReactiveCodeTextField(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [CodeTextField] class
  /// and [CodeTextField], the constructor.
  ReactiveCodeTextField({
    Key? key,
    String? formControlName,
    FormControl<T>? formControl,
    ValidationMessagesFunction<T>? validationMessages,
    ControlValueAccessor<T, String>? valueAccessor,
    ShowErrorsFunction? showErrors,

    ////////////////////////////////////////////////////////////////////////////
    InputDecoration inputDecoration = const InputDecoration(
      border: InputBorder.none,
      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      isDense: true,
      isCollapsed: true,
    ),
    required this.controller,
    int? minLines,
    int? maxLines,
    bool expands = false,
    bool wrap = false,
    LineNumberStyle lineNumberStyle = const LineNumberStyle(),
    Color? cursorColor,
    TextStyle? textStyle,
    TextSpan Function(int, TextStyle?)? lineNumberBuilder,
    bool? enabled,
    Color? background,
    EdgeInsets padding = const EdgeInsets.symmetric(),
    Decoration? decoration,
    TextSelectionThemeData? textSelectionTheme,
    FocusNode? focusNode,
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          valueAccessor: valueAccessor,
          validationMessages: validationMessages,
          showErrors: showErrors,
          builder: (field) {
            final state = field as _ReactiveCodeTextFieldState<T>;
            state._setFocusNode(focusNode);

            final InputDecoration effectiveDecoration = inputDecoration
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);

            return InputDecorator(
              decoration: effectiveDecoration.copyWith(
                errorText: field.errorText,
                enabled: field.control.enabled,
              ),
              child: CodeField(
                controller: state._textController,
                minLines: minLines,
                maxLines: maxLines,
                expands: expands = false,
                wrap: wrap = false,
                background: background,
                decoration: decoration,
                textStyle: textStyle,
                padding: padding,
                lineNumberStyle: lineNumberStyle,
                enabled: enabled,
                cursorColor: cursorColor,
                textSelectionTheme: textSelectionTheme,
                lineNumberBuilder: lineNumberBuilder,
                focusNode: state.focusNode,
              ),
            );
          },
        );

  final CodeController controller;

  @override
  ReactiveFormFieldState<T, String> createState() =>
      _ReactiveCodeTextFieldState<T>();
}

class _ReactiveCodeTextFieldState<T> extends ReactiveFormFieldState<T, String> {
  late CodeController _textController;
  FocusNode? _focusNode;
  late FocusController _focusController;

  FocusNode get focusNode => _focusNode ?? _focusController.focusNode;

  @override
  void initState() {
    super.initState();

    final codeTextField = widget as ReactiveCodeTextField;
    final initialValue = value;
    _textController = CodeController(
      text: initialValue == null ? '' : initialValue.toString(),
      language: codeTextField.controller.language,
      theme: codeTextField.controller.theme,
      patternMap: codeTextField.controller.patternMap,
      stringMap: codeTextField.controller.stringMap,
      params: codeTextField.controller.params,
      modifiers: codeTextField.controller.modifiers,
      webSpaceFix: codeTextField.controller.webSpaceFix,
      onChange: didChange,
    );
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
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  void onControlValueChanged(dynamic value) {
    final effectiveValue = (value == null) ? '' : value.toString();
    _textController.value = _textController.value.copyWith(
      text: effectiveValue,
      // selection: TextSelection.collapsed(offset: effectiveValue.length),
      // composing: TextRange.empty,
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
