// Copyright 2020 Vasyl Dytsiak. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/src/value_accessors/control_value_accessor.dart';
import 'package:reactive_forms/src/value_accessors/double_value_accessor.dart';
import 'package:reactive_forms/src/value_accessors/int_value_accessor.dart';

export 'package:flutter_typeahead/flutter_typeahead.dart';

/// A [ReactiveTypeAhead] that contains a [TextField].
///
/// This is a convenience widget that wraps a [TextField] widget in a
/// [ReactiveTypeAhead].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveTypeAhead<T> extends ReactiveFormField<T, String> {
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
  /// and [new TextField], the constructor.
  ReactiveTypeAhead({
    Key? key,
    String? formControlName,
    FormControl<T>? formControl,
    ValidationMessagesFunction<T>? validationMessages,
    ControlValueAccessor<T, String>? valueAccessor,
    ShowErrorsFunction? showErrors,
    required SuggestionsCallback<T> suggestionsCallback,
    required ItemBuilder<T> itemBuilder,
    required SuggestionSelectionCallback<T> onSuggestionSelected,
    SuggestionsBoxDecoration suggestionsBoxDecoration =
        const SuggestionsBoxDecoration(),
    Duration debounceDuration = const Duration(milliseconds: 300),
    WidgetBuilder? loadingBuilder,
    WidgetBuilder? noItemsFoundBuilder,
    ErrorBuilder? errorBuilder,
    AnimationTransitionBuilder? transitionBuilder,
    double animationStart = 0.25,
    Duration animationDuration = const Duration(milliseconds: 500),
    bool getImmediateSuggestions = false,
    double suggestionsBoxVerticalOffset = 5.0,
    AxisDirection direction: AxisDirection.down,
    bool hideOnLoading = false,
    bool hideOnEmpty = false,
    bool hideOnError = false,
    bool hideSuggestionsOnKeyboardHide = true,
    bool keepSuggestionsOnLoading = true,
    bool keepSuggestionsOnSuggestionSelected = false,
    bool autoFlipDirection = false,
    bool hideKeyboard = false,
    TextFieldConfiguration textFieldConfiguration =
        const TextFieldConfiguration(),
    SuggestionsBoxController? suggestionsBoxController,
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
    ToolbarOptions? toolbarOptions,
    bool? showCursor,
    bool obscureText = false,
    String obscuringCharacter = '•',
    bool autocorrect = true,
    // SmartDashesType? smartDashesType,
    // SmartQuotesType? smartQuotesType,
    // bool enableSuggestions = true,
    // MaxLengthEnforcement? maxLengthEnforcement,
    // int? maxLines = 1,
    // int? minLines,
    // bool expands = false,
    // int? maxLength,
    // GestureTapCallback? onTap,
    // VoidCallback? onEditingComplete,
    // List<TextInputFormatter>? inputFormatters,
    // double cursorWidth = 2.0,
    // double? cursorHeight,
    // Radius? cursorRadius,
    // Color? cursorColor,
    // Brightness? keyboardAppearance,
    // EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    // bool enableInteractiveSelection = true,
    // InputCounterWidgetBuilder? buildCounter,
    // ScrollPhysics? scrollPhysics,
    // VoidCallback? onSubmitted,
    // FocusNode? focusNode,
    // Iterable<String>? autofillHints,
    // MouseCursor? mouseCursor,
    // DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    // AppPrivateCommandCallback? onAppPrivateCommand,
    // String? restorationId,
    // ScrollController? scrollController,
    // TextSelectionControls? selectionControls,
    // ui.BoxHeightStyle selectionHeightStyle = ui.BoxHeightStyle.tight,
    // ui.BoxWidthStyle selectionWidthStyle = ui.BoxWidthStyle.tight,
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          valueAccessor: valueAccessor,
          validationMessages: validationMessages,
          showErrors: showErrors,
          builder: (field) {
            final state = field as _ReactiveTypeaheadState<T>;
            final effectiveDecoration = textFieldConfiguration.decoration
                .applyDefaults(Theme.of(state.context).inputDecorationTheme);

            state._setFocusNode(textFieldConfiguration.focusNode);

            return TypeAheadField<T>(
              suggestionsCallback: suggestionsCallback,
              itemBuilder: itemBuilder,
              onSuggestionSelected: onSuggestionSelected,
              textFieldConfiguration: (textFieldConfiguration.copyWith(
                focusNode: state.focusNode,
                controller: state._textController,
                decoration: effectiveDecoration.copyWith(
                  errorText: state.errorText,
                ),
                onChanged: field.didChange,
              )) as TextFieldConfiguration,
              suggestionsBoxDecoration: suggestionsBoxDecoration,
              debounceDuration: debounceDuration,
              suggestionsBoxController: suggestionsBoxController,
              loadingBuilder: loadingBuilder,
              noItemsFoundBuilder: noItemsFoundBuilder,
              errorBuilder: errorBuilder,
              transitionBuilder: transitionBuilder,
              animationStart: animationStart,
              animationDuration: animationDuration,
              getImmediateSuggestions: getImmediateSuggestions,
              suggestionsBoxVerticalOffset: suggestionsBoxVerticalOffset,
              direction: direction,
              hideOnLoading: hideOnLoading,
              hideOnEmpty: hideOnEmpty,
              hideOnError: hideOnError,
              hideSuggestionsOnKeyboardHide: hideSuggestionsOnKeyboardHide,
              keepSuggestionsOnLoading: keepSuggestionsOnLoading,
              keepSuggestionsOnSuggestionSelected:
                  keepSuggestionsOnSuggestionSelected,
              autoFlipDirection: autoFlipDirection,
              hideKeyboard: hideKeyboard,
            );
          },
        );

  @override
  ReactiveFormFieldState<T, String> createState() =>
      _ReactiveTypeaheadState<T>();
}

class _ReactiveTypeaheadState<T> extends ReactiveFormFieldState<T, String> {
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
