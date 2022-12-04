library reactive_phone_form_field;

// Copyright 2020 Vasyl Dytsiak. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.
import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

export 'package:phone_form_field/phone_form_field.dart';

/// A [ReactivePhoneFormField] that contains a [PhoneFormField].
///
/// This is a convenience widget that wraps a [PhoneFormField] widget in a
/// [ReactivePhoneFormField].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactivePhoneFormField<T> extends ReactiveFormField<T, PhoneNumber> {
  /// Creates a [ReactivePhoneFormField] that contains a [PhoneFormField].
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
  /// ReactivePhoneFormField(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactivePhoneFormField(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactivePhoneFormField(
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
  /// ReactivePhoneFormField(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [PhoneFormField] class
  /// and [PhoneFormField], the constructor.
  ReactivePhoneFormField({
    Key? key,
    String? formControlName,
    FormControl<T>? formControl,
    Map<String, ValidationMessageFunction>? validationMessages,
    ControlValueAccessor<T, PhoneNumber>? valueAccessor,
    ShowErrorsFunction? showErrors,

    ////////////////////////////////////////////////////////////////////////////
    bool isCountryChipPersistent = false,
    bool isCountrySelectionEnabled = true,
    TextDirection? countryChipDirection,
    bool shouldFormat = true,
    bool enabled = true,
    bool showFlagInInput = true,
    CountrySelectorNavigator countrySelectorNavigator =
        const CountrySelectorNavigator.searchDelegate(),
    Function(PhoneNumber?)? onSaved,
    IsoCode defaultCountry = IsoCode.US,
    // AutovalidateMode autovalidateMode = AutovalidateMode.onUserInteraction,
    PhoneNumber? initialValue,
    double flagSize = 16,
    InputDecoration decoration = const InputDecoration(),
    TextInputType keyboardType = TextInputType.phone,
    TextInputAction? textInputAction,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign textAlign = TextAlign.start,
    TextAlignVertical? textAlignVertical,
    bool autofocus = false,
    bool readOnly = false,
    ToolbarOptions? toolbarOptions,
    bool? showCursor,
    bool obscureText = false,
    String obscuringCharacter = '•',
    bool autocorrect = true,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    bool enableSuggestions = true,
    MaxLengthEnforcement? maxLengthEnforcement,
    int? maxLines = 1,
    int? minLines,
    bool expands = false,
    int? maxLength,
    GestureTapCallback? onTap,
    VoidCallback? onEditingComplete,
    List<TextInputFormatter>? inputFormatters,
    double cursorWidth = 2.0,
    double? cursorHeight,
    Radius? cursorRadius,
    Color? cursorColor,
    Brightness? keyboardAppearance,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,
    InputCounterWidgetBuilder? buildCounter,
    ScrollPhysics? scrollPhysics,
    VoidCallback? onSubmitted,
    FocusNode? focusNode,
    Iterable<String>? autofillHints,
    MouseCursor? mouseCursor,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    AppPrivateCommandCallback? onAppPrivateCommand,
    String? restorationId,
    ScrollController? scrollController,
    TextSelectionControls? selectionControls,
    ui.BoxHeightStyle selectionHeightStyle = ui.BoxHeightStyle.tight,
    ui.BoxWidthStyle selectionWidthStyle = ui.BoxWidthStyle.tight,
    TextStyle? countryCodeStyle,
    bool enableIMEPersonalizedLearning = true,
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          valueAccessor: valueAccessor,
          validationMessages: validationMessages,
          showErrors: showErrors,
          builder: (field) {
            final state = field as _ReactivePhoneFormFieldState<T>;
            final effectiveDecoration = decoration
                .applyDefaults(Theme.of(state.context).inputDecorationTheme);

            state._setFocusNode(focusNode);

            return PhoneFormField(
              countryCodeStyle: countryCodeStyle,
              focusNode: state.focusNode,
              controller: state._textController,
              shouldFormat: shouldFormat,
              onChanged: field.didChange,
              autofillHints: autofillHints,
              autofocus: autofocus,
              enabled: field.control.enabled,
              showFlagInInput: showFlagInInput,
              countrySelectorNavigator: countrySelectorNavigator,
              onSaved: onSaved,
              defaultCountry: defaultCountry,
              decoration: effectiveDecoration.copyWith(
                errorText: field.errorText,
                enabled: field.control.enabled,
              ),
              isCountryChipPersistent: isCountryChipPersistent,
              isCountrySelectionEnabled: isCountrySelectionEnabled,
              cursorColor: cursorColor,
              autovalidateMode: AutovalidateMode.disabled,
              flagSize: flagSize,
              onEditingComplete: onEditingComplete,
              restorationId: restorationId,
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              style: style,
              strutStyle: strutStyle,
              textAlign: textAlign,
              textAlignVertical: textAlignVertical,
              toolbarOptions: toolbarOptions,
              showCursor: showCursor,
              obscureText: obscureText,
              autocorrect: autocorrect,
              smartDashesType: smartDashesType ??
                  (obscureText
                      ? SmartDashesType.disabled
                      : SmartDashesType.enabled),
              smartQuotesType: smartQuotesType ??
                  (obscureText
                      ? SmartQuotesType.disabled
                      : SmartQuotesType.enabled),
              enableSuggestions: enableSuggestions,
              onSubmitted: onSubmitted != null ? (_) => onSubmitted() : null,
              inputFormatters: inputFormatters,
              cursorWidth: cursorWidth,
              cursorHeight: cursorHeight,
              cursorRadius: cursorRadius,
              scrollPadding: scrollPadding,
              scrollPhysics: scrollPhysics,
              keyboardAppearance: keyboardAppearance,
              enableInteractiveSelection: enableInteractiveSelection,
              mouseCursor: mouseCursor,
              obscuringCharacter: obscuringCharacter,
              onAppPrivateCommand: onAppPrivateCommand,
              scrollController: scrollController,
              countryChipDirection: countryChipDirection,
              selectionControls: selectionControls,
              selectionHeightStyle: selectionHeightStyle,
              selectionWidthStyle: selectionWidthStyle,
              enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
            );
          },
        );

  @override
  ReactiveFormFieldState<T, PhoneNumber> createState() =>
      _ReactivePhoneFormFieldState<T>();
}

class _ReactivePhoneFormFieldState<T>
    extends ReactiveFormFieldState<T, PhoneNumber> {
  late PhoneController _textController;
  FocusNode? _focusNode;
  late FocusController _focusController;

  @override
  FocusNode get focusNode => _focusNode ?? _focusController.focusNode;

  @override
  void initState() {
    super.initState();

    _textController = PhoneController(value);
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
    if (value == null) {
      _textController.value = null;
    } else if (value is PhoneNumber) {
      _textController.value = PhoneNumber(
        isoCode: value.isoCode,
        nsn: value.nsn,
      );
    }

    super.onControlValueChanged(value);
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
