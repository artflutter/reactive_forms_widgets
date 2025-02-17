// Copyright 2020 Vasyl Dytsiak. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'dart:async';

/// A [ReactiveTypeAhead] that contains a [TextField].
///
/// This is a convenience widget that wraps a [TextField] widget in a
/// [ReactiveTypeAhead].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveTypeAhead<T, V> extends ReactiveFormField<T, V> {
  /// Creates a [ReactiveTypeAhead] that contains a [TextField].
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
  /// ReactiveTypeAhead(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveTypeAhead(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveTypeAhead(
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
  /// ReactiveTypeAhead(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [TextField] class
  /// and [TextField], the constructor.
  ReactiveTypeAhead({
    super.key,
    super.formControlName,
    super.formControl,
    super.validationMessages,
    super.valueAccessor,
    super.showErrors,
    required this.stringify,
    V Function(String)? viewDataTypeFromTextEditingValue,

    ////////////////////////////////////////////////////////////////////////////
    required FutureOr<List<V>?> Function(String) suggestionsCallback,
    required Widget Function(BuildContext, V) itemBuilder,
    Widget Function(BuildContext, Widget)? decorationBuilder,
    Duration debounceDuration = const Duration(milliseconds: 300),
    Widget Function(BuildContext)? loadingBuilder,
    Widget Function(BuildContext)? emptyBuilder,
    Widget Function(BuildContext, Object?)? errorBuilder,
    Widget Function(BuildContext, Animation<double>, Widget)? transitionBuilder,
    Duration animationDuration = const Duration(milliseconds: 500),
    Offset? offset,
    VerticalDirection? direction,
    bool hideOnLoading = false,
    bool hideOnEmpty = false,
    bool hideOnError = false,
    bool hideWithKeyboard = true,
    bool retainOnLoading = true,
    bool hideOnSelect = true,
    bool autoFlipDirection = false,
    SuggestionsController<V>? suggestionsController,
    ScrollController? scrollController,
    bool hideKeyboardOnDrag = false,
    Widget Function(BuildContext, int)? itemSeparatorBuilder,
    Widget Function(BuildContext, List<Widget>)? listBuilder,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextDirection? textDirection,
    TextAlign textAlign = TextAlign.start,
    TextAlignVertical? textAlignVertical,
    TextEditingController? textEditingController,
    bool autofocus = false,
    bool readOnly = false,
    bool? showCursor,
    bool obscureText = false,
    String obscuringCharacter = '•',
    bool autocorrect = true,
    bool enabled = true,
    FocusNode? focusNode,
    InputDecoration? decoration,
    void Function(V)? onSuggestionSelected,
  }) : super(
          builder: (field) {
            final state = field as _ReactiveTypeaheadState<T, V>;
            final effectiveDecoration = (decoration ?? const InputDecoration())
                .applyDefaults(Theme.of(state.context).inputDecorationTheme);

            state._setFocusNode(focusNode);
            final controller = textEditingController ?? state._textController;
            final fieldSuggestionsController =
                suggestionsController ?? state._suggestionsController;
            if (field.value != null) {
              controller.text = stringify(field.value as V);
            }

            return TypeAheadField<V>(
              suggestionsCallback: suggestionsCallback,
              itemBuilder: itemBuilder,
              onSelected: (value) {
                controller.text = stringify(value);
                field.didChange(value);
                onSuggestionSelected?.call(value);
                fieldSuggestionsController.close(); // close the suggestions box
              },
              builder: (context, controller, focusNode) {
                // Keep the selected value in the text field
                if (field.value == null) {
                  controller.text = '';
                } else if (field.value != null) {
                  controller.text = stringify(field.value as V);
                }

                return TextField(
                  controller: controller,
                  focusNode: focusNode,
                  decoration: effectiveDecoration.copyWith(
                    errorText: state.errorText,
                  ),
                  enabled: field.control.enabled,
                  style: style,
                  strutStyle: strutStyle,
                  textDirection: textDirection,
                  textAlign: textAlign,
                  textAlignVertical: textAlignVertical,
                  autofocus: autofocus,
                  readOnly: readOnly,
                  showCursor: showCursor,
                  obscureText: obscureText,
                  obscuringCharacter: obscuringCharacter,
                  autocorrect: autocorrect,
                  onChanged: (value) {
                    if (value.isEmpty) {
                      field.didChange(null);
                    } else if (viewDataTypeFromTextEditingValue != null) {
                      field.didChange(
                          viewDataTypeFromTextEditingValue.call(value));
                    }
                  },
                );
              },
              decorationBuilder: decorationBuilder,
              debounceDuration: debounceDuration,
              suggestionsController: fieldSuggestionsController,
              loadingBuilder: loadingBuilder,
              emptyBuilder: emptyBuilder,
              errorBuilder: errorBuilder,
              transitionBuilder: transitionBuilder,
              animationDuration: animationDuration,
              offset: offset ?? const Offset(0, 5.0),
              direction: direction,
              hideOnLoading: hideOnLoading,
              hideOnEmpty: hideOnEmpty,
              hideOnError: hideOnError,
              hideWithKeyboard: hideWithKeyboard,
              retainOnLoading: retainOnLoading,
              hideOnSelect: hideOnSelect,
              autoFlipDirection: autoFlipDirection,
              scrollController: scrollController,
              hideKeyboardOnDrag: hideKeyboardOnDrag,
              itemSeparatorBuilder: itemSeparatorBuilder,
              listBuilder: listBuilder,
            );
          },
        );

  final String Function(V value) stringify;

  @override
  ReactiveFormFieldState<T, V> createState() => _ReactiveTypeaheadState<T, V>();
}

class _ReactiveTypeaheadState<T, V> extends ReactiveFormFieldState<T, V> {
  late TextEditingController _textController;
  late SuggestionsController<V> _suggestionsController;

  FocusNode? _focusNode;
  late FocusController _focusController;

  @override
  FocusNode get focusNode => _focusNode ?? _focusController.focusNode;

  @override
  void initState() {
    super.initState();
    _suggestionsController = SuggestionsController<V>();

    final initialValue = value;
    _textController = TextEditingController(
      text: initialValue == null
          ? ''
          : (widget as ReactiveTypeAhead<T, V>).stringify(initialValue),
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
  void onControlValueChanged(dynamic value) {
    final effectiveValue = value == null
        ? ''
        : (widget as ReactiveTypeAhead<T, V>).stringify(value as V);

    _textController.value = _textController.value.copyWith(
      text: effectiveValue,
      selection: TextSelection.collapsed(offset: effectiveValue.length),
      composing: TextRange.empty,
    );

    super.onControlValueChanged(value);
  }
  // @override
  // ControlValueAccessor<T, V> selectValueAccessor() {
  //   if (control is FormControl<int>) {
  //     return IntValueAccessor() as ControlValueAccessor<T, String>;
  //   } else if (control is FormControl<double>) {
  //     return DoubleValueAccessor() as ControlValueAccessor<T, String>;
  //   } else if (control is FormControl<DateTime>) {
  //     return DateTimeValueAccessor() as ControlValueAccessor<T, String>;
  //   } else if (control is FormControl<TimeOfDay>) {
  //     return TimeOfDayValueAccessor() as ControlValueAccessor<T, String>;
  //   }
  //
  //   return super.selectValueAccessor();
  // }

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
