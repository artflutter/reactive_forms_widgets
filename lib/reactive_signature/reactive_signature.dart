// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/src/value_accessors/control_value_accessor.dart';
import 'package:reactive_forms/src/value_accessors/double_value_accessor.dart';
import 'package:reactive_forms/src/value_accessors/int_value_accessor.dart';
import 'package:signature/signature.dart';

/// A [ReactiveSignature] that contains a [TextField].
///
/// This is a convenience widget that wraps a [TextField] widget in a
/// [ReactiveSignature].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveSignature extends ReactiveFormField<Uint8List> {
  /// Creates a [ReactiveSignature] that contains a [TextField].
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
  /// ReactiveTextField(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveTextField(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveTextField(
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
  /// ReactiveTextField(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [TextField] class
  /// and [new TextField], the constructor.
  ReactiveSignature(
      {Key key,
      String formControlName,
      FormControl formControl,
      ValidationMessagesFunction validationMessages,
      ControlValueAccessor valueAccessor,
      ShowErrorsFunction showErrors,
      InputDecoration decoration = const InputDecoration(),
      SignatureController controller,
      Color backgroundColor = Colors.grey,
      double width,
      double height,
      Color penColor = Colors.black,
      this.penStrokeWidth = 3.0,
      Color exportBackgroundColor})
      : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          valueAccessor: valueAccessor,
          validationMessages: validationMessages,
          showErrors: showErrors,
          builder: (ReactiveFormFieldState field) {
            final state = field as _ReactiveTextFieldState;
            final InputDecoration effectiveDecoration = (decoration ??
                    const InputDecoration())
                .applyDefaults(Theme.of(state.context).inputDecorationTheme);

            return Signature(
              controller: state._signatureController,
              width: width,
              height: height,
              backgroundColor: backgroundColor,
            );
          },
        );

  final double penStrokeWidth;

  @override
  ReactiveFormFieldState<Uint8List> createState() => _ReactiveTextFieldState();
}

class _ReactiveTextFieldState extends ReactiveFormFieldState<Uint8List> {
  SignatureController _signatureController;
  // FocusNode _focusNode;
  // FocusController _focusController;

  // FocusNode get focusNode => _focusNode ?? _focusController.focusNode;

  @override
  void initState() {
    super.initState();

    final initialValue = this.value;
    final test = widget;
    _signatureController = SignatureController(
      penStrokeWidth: 5,
      penColor: Colors.red,
      exportBackgroundColor: Colors.blue,
    );

    _signatureController.addListener(() async {
      this.control.focus();
      didChange(await _signatureController.toPngBytes());
    });
  }

  // @override
  // void subscribeControl() {
  //   // _registerFocusController(FocusController());
  //   super.subscribeControl();
  // }
  //
  // @override
  // void unsubscribeControl() {
  //   // _unregisterFocusController();
  //   super.unsubscribeControl();
  // }

  @override
  void onControlValueChanged(dynamic value) {
    // String effectiveValue = (value == null) ? '' : value.toString();
    _signatureController.value = _signatureController.value;

    super.onControlValueChanged(value);
  }
  //
  // @override
  // ControlValueAccessor selectValueAccessor() {
  //   if (this.control is FormControl<int>) {
  //     return IntValueAccessor();
  //   } else if (this.control is FormControl<double>) {
  //     return DoubleValueAccessor();
  //   } else if (this.control is FormControl<DateTime>) {
  //     return DateTimeValueAccessor();
  //   } else if (this.control is FormControl<TimeOfDay>) {
  //     return TimeOfDayValueAccessor();
  //   }
  //
  //   return super.selectValueAccessor();
  // }

  // void _registerFocusController(FocusController focusController) {
  //   _focusController = focusController;
  //   this.control.registerFocusController(focusController);
  // }
  //
  // void _unregisterFocusController() {
  //   this.control.unregisterFocusController(_focusController);
  //   _focusController.dispose();
  // }
  //
  // void _setFocusNode(FocusNode focusNode) {
  //   if (_focusNode == focusNode) {
  //     return;
  //   } else if (focusNode == null && _focusNode != null) {
  //     _focusNode = null;
  //   } else if (focusNode != null && _focusNode == null) {
  //     _focusNode = focusNode;
  //   }
  //
  //   _unregisterFocusController();
  //   _registerFocusController(FocusController(focusNode: _focusNode));
  // }
}
