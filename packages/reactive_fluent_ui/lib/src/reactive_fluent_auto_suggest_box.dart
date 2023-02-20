import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// A [ReactiveFluentAutoSuggestBox] that contains a [FluentUi].
///
/// This is a convenience widget that wraps a [FluentUi] widget in a
/// [ReactiveFluentAutoSuggestBox].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveFluentAutoSuggestBox<T, V> extends ReactiveFormField<T, V> {
  final TextEditingController? _textController;

  /// Creates a [ReactiveFluentAutoSuggestBox] that contains a [FluentUi].
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
  /// ReactiveFluentAutoSuggestBox(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveFluentAutoSuggestBox(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveFluentAutoSuggestBox(
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
  /// ReactiveFluentAutoSuggestBox(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [FluentUi] class
  /// and [FluentUi], the constructor.
  ReactiveFluentAutoSuggestBox({
    Key? key,
    Key? autoSuggestBoxKey,
    String? formControlName,
    FormControl<T>? formControl,
    Map<String, ValidationMessageFunction>? validationMessages,
    ControlValueAccessor<T, V>? valueAccessor,
    ShowErrorsFunction? showErrors,

    //////////////////////////////////////////////////////////////////////////
    required List<AutoSuggestBoxItem<V>> items,
    TextEditingController? controller,
    BoxDecoration? decoration,
    TextInputAction? textInputAction,
    TextStyle? style,
    bool autofocus = false,
    bool? showCursor,
    List<TextInputFormatter>? inputFormatters,
    double cursorWidth = 2.0,
    double? cursorHeight,
    Color? cursorColor,
    Brightness? keyboardAppearance,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    ui.BoxHeightStyle selectionHeightStyle = ui.BoxHeightStyle.tight,
    ui.BoxWidthStyle selectionWidthStyle = ui.BoxWidthStyle.tight,
    Radius cursorRadius = const Radius.circular(2.0),
    String? placeholder,
    TextStyle? placeholderStyle,
    Color? highlightColor,
    Color? errorHighlightColor,
    Color? unfocusedColor,
    Widget? leadingIcon,
    AutoSuggestBoxSorter<V>? sorter,
    Widget? trailingIcon,
    bool clearButtonEnabled = true,
    BoxDecoration? foregroundDecoration,
    bool enableKeyboardControls = true,
    double maxPopupHeight = 380.0,
    WidgetBuilder? noResultsFoundBuilder,
  })  : _textController = controller,
        super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          valueAccessor: valueAccessor,
          validationMessages: validationMessages,
          showErrors: showErrors,
          builder: (field) {
            final state = field as _ReactiveFluentAutoSuggestBoxState<T, V>;
            return AutoSuggestBox<V>.form(
              key: autoSuggestBoxKey,
              items: items,
              controller: state._textController,
              decoration: decoration,
              focusNode: state.focusNode,
              textInputAction: textInputAction,
              style: style,
              autofocus: autofocus,
              showCursor: showCursor,
              inputFormatters: inputFormatters,
              enabled: field.control.enabled,
              cursorWidth: cursorWidth,
              cursorHeight: cursorHeight,
              cursorRadius: cursorRadius,
              cursorColor: cursorColor,
              keyboardAppearance: keyboardAppearance,
              scrollPadding: scrollPadding,
              placeholder: placeholder,
              placeholderStyle: placeholderStyle,
              selectionHeightStyle: selectionHeightStyle,
              selectionWidthStyle: selectionWidthStyle,
              highlightColor: highlightColor,
              unfocusedColor: unfocusedColor,
              validator: (_) => field.errorText,
              autovalidateMode: AutovalidateMode.always,
              onSelected: (value) => field.didChange(value.value),
              noResultsFoundBuilder: noResultsFoundBuilder,
              sorter: sorter,
              leadingIcon: leadingIcon,
              trailingIcon: trailingIcon,
              clearButtonEnabled: clearButtonEnabled,
              foregroundDecoration: foregroundDecoration,
              enableKeyboardControls: enableKeyboardControls,
              maxPopupHeight: maxPopupHeight,
            );
          },
        );

  @override
  ReactiveFormFieldState<T, V> createState() =>
      _ReactiveFluentAutoSuggestBoxState<T, V>();
}

class _ReactiveFluentAutoSuggestBoxState<T, V>
    extends ReactiveFocusableFormFieldState<T, V> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _initializeTextController();
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

  void _initializeTextController() {
    final initialValue = value;
    final currentWidget = widget as ReactiveFluentAutoSuggestBox<T, V>;
    _textController = (currentWidget._textController != null)
        ? currentWidget._textController!
        : TextEditingController();
    _textController.text = initialValue == null ? '' : initialValue.toString();
  }
}
