library reactive_raw_autocomplete;

// Copyright 2020 Vasyl Dytsiak. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.
import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';

typedef ControllerInitCallback = void Function(
    TextEditingController controller);

/// A [ReactiveRawAutocomplete] that contains a [TextField].
///
/// This is a convenience widget that wraps a [TextField] widget in a
/// [ReactiveRawAutocomplete].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveRawAutocomplete<T, V extends Object>
    extends ReactiveFormField<T, V> {
  final ControllerInitCallback? onControllerInit;

  final AutocompleteOptionToString<V> displayStringForOption;

  /// Creates a [ReactiveRawAutocomplete] that contains a [TextField].
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
  /// ReactiveRawAutocomplete(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveRawAutocomplete(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveRawAutocomplete(
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
  /// ReactiveRawAutocomplete(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [RawAutocomplete] class
  /// and [RawAutocomplete], the constructor.
  ReactiveRawAutocomplete({
    super.key,
    super.formControlName,
    super.formControl,
    super.validationMessages,
    super.valueAccessor,
    super.showErrors,

    ////////////////////////////////////////////////////////////////////////////
    required AutocompleteOptionsBuilder<V> optionsBuilder,
    AutocompleteFieldViewBuilder? fieldViewBuilder,
    required AutocompleteOptionsViewBuilder<V> optionsViewBuilder,
    this.displayStringForOption = RawAutocomplete.defaultStringForOption,
    FocusNode? focusNode,
    V Function(String)? viewDataTypeFromTextEditingValue,

    ////////////////////////////////////////////////////////////////////////////
    InputDecoration decoration = const InputDecoration(),
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputAction? textInputAction,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextDirection? textDirection,
    TextAlign textAlign = TextAlign.start,
    TextAlignVertical? textAlignVertical,
    bool autofocus = false,
    bool readOnly = false,
    bool autocompleteOnSubmit = false,
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
    Iterable<String>? autofillHints,
    MouseCursor? mouseCursor,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    AppPrivateCommandCallback? onAppPrivateCommand,
    String? restorationId,
    ScrollController? scrollController,
    TextSelectionControls? selectionControls,
    ui.BoxHeightStyle selectionHeightStyle = ui.BoxHeightStyle.tight,
    ui.BoxWidthStyle selectionWidthStyle = ui.BoxWidthStyle.tight,
    this.onControllerInit,
    bool scribbleEnabled = true,
    bool enableIMEPersonalizedLearning = true,
  }) : super(
          builder: (field) {
            final state = field as _ReactiveRawAutocompleteState<T, V>;
            final effectiveDecoration = decoration
                .applyDefaults(Theme.of(state.context).inputDecorationTheme);

            state._setFocusNode(focusNode);

            return RawAutocomplete<V>(
              optionsViewBuilder: optionsViewBuilder,
              optionsBuilder: optionsBuilder,
              displayStringForOption: displayStringForOption,
              focusNode: state.focusNode,
              onSelected: field.didChange,
              textEditingController: state._textController,
              fieldViewBuilder: fieldViewBuilder ??
                  (
                    context,
                    textEditingController,
                    focusNode,
                    onFieldSubmitted,
                  ) {
                    return TextField(
                      controller: textEditingController,
                      focusNode: focusNode,
                      decoration: effectiveDecoration.copyWith(
                        errorText: state.errorText,
                      ),
                      onChanged: (value) {
                        if (viewDataTypeFromTextEditingValue != null) {
                          field.didChange(
                              viewDataTypeFromTextEditingValue.call(value));
                        }
                      },
                      keyboardType: keyboardType,
                      textInputAction: textInputAction,
                      style: style,
                      strutStyle: strutStyle,
                      textAlign: textAlign,
                      textAlignVertical: textAlignVertical,
                      textDirection: textDirection,
                      textCapitalization: textCapitalization,
                      autofocus: autofocus,
                      readOnly: readOnly,
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
                      maxLengthEnforcement: maxLengthEnforcement,
                      maxLines: maxLines,
                      minLines: minLines,
                      expands: expands,
                      maxLength: maxLength,
                      onTap: onTap,
                      onSubmitted: (_) {
                        if (autocompleteOnSubmit) {
                          onFieldSubmitted();
                        }

                        if (onSubmitted != null) {
                          onSubmitted();
                        }
                      },
                      onEditingComplete: onEditingComplete,
                      inputFormatters: inputFormatters,
                      enabled: field.control.enabled,
                      cursorWidth: cursorWidth,
                      cursorHeight: cursorHeight,
                      cursorRadius: cursorRadius,
                      cursorColor: cursorColor,
                      scrollPadding: scrollPadding,
                      scrollPhysics: scrollPhysics,
                      keyboardAppearance: keyboardAppearance,
                      enableInteractiveSelection: enableInteractiveSelection,
                      buildCounter: buildCounter,
                      autofillHints: autofillHints,
                      mouseCursor: mouseCursor,
                      obscuringCharacter: obscuringCharacter,
                      dragStartBehavior: dragStartBehavior,
                      onAppPrivateCommand: onAppPrivateCommand,
                      restorationId: restorationId,
                      scrollController: scrollController,
                      selectionControls: selectionControls,
                      selectionHeightStyle: selectionHeightStyle,
                      selectionWidthStyle: selectionWidthStyle,
                      scribbleEnabled: scribbleEnabled,
                      enableIMEPersonalizedLearning:
                          enableIMEPersonalizedLearning,
                    );
                  },
            );
          },
        );

  @override
  ReactiveFormFieldState<T, V> createState() =>
      _ReactiveRawAutocompleteState<T, V>();
}

class _ReactiveRawAutocompleteState<T, V extends Object>
    extends ReactiveFormFieldState<T, V> {
  late TextEditingController _textController;
  FocusNode? _focusNode;
  late FocusController _focusController;

  @override
  FocusNode get focusNode => _focusNode ?? _focusController.focusNode;

  @override
  void initState() {
    super.initState();

    final widgetInstance = (widget as ReactiveRawAutocomplete<T, V>);

    final initialValue = value;
    _textController = TextEditingController(
      text: initialValue == null
          ? ''
          : widgetInstance.displayStringForOption(initialValue),
    );

    widgetInstance.onControllerInit?.call(_textController);
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
