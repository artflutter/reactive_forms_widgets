import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// A [ReactiveFluentTextFormBox] that contains a [FluentUi].
///
/// This is a convenience widget that wraps a [FluentUi] widget in a
/// [ReactiveFluentTextFormBox].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveFluentTextFormBox<T> extends ReactiveFormField<T, String> {
  final TextEditingController? _textController;

  /// Creates a [ReactiveFluentTextFormBox] that contains a [FluentUi].
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
  /// ReactiveFluentTextFormBox(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveFluentTextFormBox(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveFluentTextFormBox(
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
  /// ReactiveFluentTextFormBox(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [FluentUi] class
  /// and [FluentUi], the constructor.
  ReactiveFluentTextFormBox({
    Key? key,
    Key? textFormBox,
    String? formControlName,
    FormControl<T>? formControl,
    Map<String, ValidationMessageFunction>? validationMessages,
    ControlValueAccessor<T, String>? valueAccessor,
    ShowErrorsFunction<T>? showErrors,

    //////////////////////////////////////////////////////////////////////////
    TextEditingController? controller,
    BoxDecoration? decoration,
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
    List<TextInputFormatter>? inputFormatters,
    double cursorWidth = 2.0,
    double? cursorHeight,
    Color? cursorColor,
    Brightness? keyboardAppearance,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,
    InputCounterWidgetBuilder? buildCounter,
    ScrollPhysics? scrollPhysics,
    Iterable<String>? autofillHints,
    MouseCursor? mouseCursor,
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    AppPrivateCommandCallback? onAppPrivateCommand,
    String? restorationId,
    ScrollController? scrollController,
    TextSelectionControls? selectionControls,
    ui.BoxHeightStyle selectionHeightStyle = ui.BoxHeightStyle.tight,
    ui.BoxWidthStyle selectionWidthStyle = ui.BoxWidthStyle.tight,
    Clip clipBehavior = Clip.hardEdge,
    bool enableIMEPersonalizedLearning = true,
    bool scribbleEnabled = true,
    double? minHeight,
    EdgeInsetsGeometry padding =
        const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
    GestureTapCallback? onTap,
    VoidCallback? onEditingComplete,
    Radius cursorRadius = const Radius.circular(2.0),
    String? placeholder,
    TextStyle? placeholderStyle,
    String? header,
    TextStyle? headerStyle,
    Widget? prefix,
    OverlayVisibilityMode prefixMode = OverlayVisibilityMode.always,
    Widget? suffix,
    OverlayVisibilityMode suffixMode = OverlayVisibilityMode.always,
    Color? highlightColor,
    Color? errorHighlightColor,
    Color? unfocusedColor,
  })  : _textController = controller,
        super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          valueAccessor: valueAccessor,
          validationMessages: validationMessages,
          showErrors: showErrors,
          builder: (field) {
            final state = field as _ReactiveFluentTextFormBoxState<T>;
            return TextFormBox(
              key: textFormBox,
              controller: state._textController,
              decoration: decoration,
              focusNode: state.focusNode,
              validator: (_) => field.errorText,
              autovalidateMode: AutovalidateMode.always,
              //     String? initialValue,
              keyboardType: keyboardType,
              textCapitalization: textCapitalization,
              textInputAction: textInputAction,
              style: style,
              strutStyle: strutStyle,
              textDirection: textDirection,
              textAlign: textAlign,
              textAlignVertical: textAlignVertical,
              autofocus: autofocus,
              readOnly: readOnly,
              showCursor: showCursor,
              obscuringCharacter: obscuringCharacter,
              obscureText: obscureText,
              autocorrect: autocorrect,
              smartDashesType: smartDashesType,
              smartQuotesType: smartQuotesType,
              enableSuggestions: enableSuggestions,
              maxLines: maxLines,
              minLines: minLines,
              expands: expands,
              maxLength: maxLength,
              padding: padding,
              onChanged: field.didChange,
              onTap: onTap,
              onEditingComplete: onEditingComplete,
              inputFormatters: inputFormatters,
              enabled: field.control.enabled,
              cursorWidth: cursorWidth,
              cursorHeight: cursorHeight,
              cursorRadius: cursorRadius,
              cursorColor: cursorColor,
              keyboardAppearance: keyboardAppearance,
              scrollPadding: scrollPadding,
              enableInteractiveSelection: enableInteractiveSelection,
              selectionControls: selectionControls,
              scrollPhysics: scrollPhysics,
              autofillHints: autofillHints,
              placeholder: placeholder,
              placeholderStyle: placeholderStyle,
              scrollController: scrollController,
              clipBehavior: clipBehavior,
              prefix: prefix,
              prefixMode: prefixMode,
              suffix: suffix,
              suffixMode: suffixMode,
              dragStartBehavior: dragStartBehavior,
              restorationId: restorationId,
              maxLengthEnforcement: maxLengthEnforcement,
              selectionHeightStyle: selectionHeightStyle,
              selectionWidthStyle: selectionWidthStyle,
              enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
              mouseCursor: mouseCursor,
              scribbleEnabled: scribbleEnabled,
              highlightColor: highlightColor,
              errorHighlightColor: errorHighlightColor,
              unfocusedColor: unfocusedColor,
            );
          },
        );

  @override
  ReactiveFormFieldState<T, String> createState() =>
      _ReactiveFluentTextFormBoxState<T>();
}

class _ReactiveFluentTextFormBoxState<T>
    extends ReactiveFocusableFormFieldState<T, String> {
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

  void _initializeTextController() {
    final initialValue = value;
    final currentWidget = widget as ReactiveFluentTextFormBox<T>;
    _textController = (currentWidget._textController != null)
        ? currentWidget._textController!
        : TextEditingController();
    _textController.text = initialValue == null ? '' : initialValue.toString();
  }
}
