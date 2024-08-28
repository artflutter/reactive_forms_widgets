library reactive_phone_form_field;

// Copyright 2020 Vasyl Dytsiak. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.
import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;

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
class ReactivePhoneFormField<T>
    extends ReactiveFocusableFormField<T, PhoneNumber> {
  final PhoneController? _textController;

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
    super.key,
    super.formControlName,
    super.formControl,
    super.validationMessages,
    super.valueAccessor,
    super.showErrors,
    super.focusNode,
    ////////////////////////////////////////////////////////////////////////////
    CountrySelectorNavigator countrySelectorNavigator =
        const CountrySelectorNavigator.page(),
    Function(PhoneNumber?)? onSaved,
    ReactiveFormFieldCallback<T>? onChanged,
    InputDecoration decoration = const InputDecoration(),
    TextInputType keyboardType = TextInputType.phone,
    TextInputAction? textInputAction,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlignVertical? textAlignVertical,
    bool autofocus = false,
    bool? showCursor,
    bool obscureText = false,
    String obscuringCharacter = '•',
    bool autocorrect = true,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    bool enableSuggestions = true,
    VoidCallback? onEditingComplete,
    List<TextInputFormatter>? inputFormatters,
    double cursorWidth = 2.0,
    double? cursorHeight,
    Radius? cursorRadius,
    Color? cursorColor,
    Brightness? keyboardAppearance,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,
    ScrollPhysics? scrollPhysics,
    VoidCallback? onSubmitted,
    Iterable<String>? autofillHints,
    MouseCursor? mouseCursor,
    AppPrivateCommandCallback? onAppPrivateCommand,
    String? restorationId,
    ScrollController? scrollController,
    TextSelectionControls? selectionControls,
    ui.BoxHeightStyle selectionHeightStyle = ui.BoxHeightStyle.tight,
    ui.BoxWidthStyle selectionWidthStyle = ui.BoxWidthStyle.tight,
    CountryButtonStyle countryButtonStyle = const CountryButtonStyle(),
    bool enableIMEPersonalizedLearning = true,
    bool isCountrySelectionEnabled = true,
    bool isCountryButtonPersistent = false,
    Widget Function(BuildContext, EditableTextState)? contextMenuBuilder,
    Function(PointerDownEvent)? onTapOutside,
    PhoneController? controller,
  })  : _textController = controller,
        super(
          builder: (field) {
            final state = field as _ReactivePhoneFormFieldState<T>;
            final effectiveDecoration = decoration
                .applyDefaults(Theme.of(state.context).inputDecorationTheme);
            return PhoneFormField(
              countryButtonStyle: countryButtonStyle,
              focusNode: state.focusNode,
              controller: state._textController,
              autofillHints: autofillHints,
              contextMenuBuilder: contextMenuBuilder,
              autofocus: autofocus,
              enabled: field.control.enabled,
              countrySelectorNavigator: countrySelectorNavigator,
              onSaved: onSaved,
              decoration: effectiveDecoration.copyWith(
                errorText: field.errorText,
                enabled: field.control.enabled,
              ),
              cursorColor: cursorColor,
              autovalidateMode: AutovalidateMode.disabled,
              onChanged: (value) {
                field.didChange(value);
                onChanged?.call(field.control);
              },
              onEditingComplete: onEditingComplete,
              restorationId: restorationId,
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              style: style,
              strutStyle: strutStyle,
              textAlignVertical: textAlignVertical,
              showCursor: showCursor,
              obscureText: obscureText,
              autocorrect: autocorrect,
              smartDashesType: smartDashesType,
              smartQuotesType: smartQuotesType,
              onTapOutside: onTapOutside,
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
              selectionControls: selectionControls,
              selectionHeightStyle: selectionHeightStyle,
              selectionWidthStyle: selectionWidthStyle,
              enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
              isCountrySelectionEnabled: isCountrySelectionEnabled,
              isCountryButtonPersistent: isCountryButtonPersistent,
            );
          },
        );

  @override
  ReactiveFormFieldState<T, PhoneNumber> createState() =>
      _ReactivePhoneFormFieldState<T>();
}

class _ReactivePhoneFormFieldState<T>
    extends ReactiveFocusableFormFieldState<T, PhoneNumber> {
  late PhoneController _textController;

  static const defaultPhone = PhoneNumber(isoCode: IsoCode.US, nsn: '');

  @override
  void initState() {
    super.initState();
    _initializeTextController();
  }

  void _initializeTextController() {
    final initialValue = value;
    final currentWidget = widget as ReactivePhoneFormField<T>;
    _textController = (currentWidget._textController != null)
        ? currentWidget._textController!
        : PhoneController(initialValue: initialValue ?? defaultPhone);
  }

  @override
  void onControlValueChanged(dynamic value) {
    if (value is PhoneNumber?) {
      _textController.value = value ?? defaultPhone;
    }

    super.onControlValueChanged(value);
  }

  @override
  void dispose() {
    final currentWidget = widget as ReactivePhoneFormField<T>;
    if (currentWidget._textController == null) {
      _textController.dispose();
    }
    super.dispose();
  }
}
