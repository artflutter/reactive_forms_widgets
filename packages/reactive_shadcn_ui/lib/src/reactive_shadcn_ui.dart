import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// A [ReactiveShadInput] that contains a [TextField].
///
/// This is a convenience widget that wraps a [TextField] widget in a
/// [ReactiveShadInput].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveShadInput<T> extends ReactiveFormField<T, String> {
  final TextEditingController? _textController;

  static Widget _defaultContextMenuBuilder(
      BuildContext context, EditableTextState editableTextState) {
    return AdaptiveTextSelectionToolbar.editableText(
      editableTextState: editableTextState,
    );
  }

  /// Creates a [ReactiveShadInput] that contains a [TextField].
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
  /// ReactiveShadInput(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveShadInput(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveShadInput(
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
  /// ReactiveShadInput(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [TextField] class
  /// and [TextField], the constructor.
  ReactiveShadInput({
    super.key,
    super.formControlName,
    super.formControl,
    super.validationMessages,
    super.valueAccessor,
    super.showErrors,
    super.focusNode,
    //////////////////////////////////////////////////////////////////////////
    // put component specific params here
    Key? widgetKey,
    Widget Function(BuildContext context, String error)? errorBuilder,
    TextEditingController? controller,
    ShadDecoration? decoration,
    Widget? label,
    Widget? description,
    Widget? placeholder,
    UndoHistoryController? undoController,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextAlign textAlign = TextAlign.start,
    TextDirection? textDirection,
    bool readOnly = false,
    bool? showCursor,
    bool autofocus = false,
    String obscuringCharacter = '•',
    bool obscureText = false,
    bool autocorrect = true,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    bool enableSuggestions = true,
    int maxLines = 1,
    int? minLines,
    bool expands = false,
    int? maxLength,
    MaxLengthEnforcement? maxLengthEnforcement,
    ValueChanged<String>? onChanged,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onSubmitted,
    AppPrivateCommandCallback? onAppPrivateCommand,
    List<TextInputFormatter>? inputFormatters,
    bool enabled = true,
    double cursorWidth = 2.0,
    double? cursorHeight,
    Radius? cursorRadius,
    bool? cursorOpacityAnimates,
    Color? cursorColor,
    ui.BoxHeightStyle selectionHeightStyle = ui.BoxHeightStyle.tight,
    ui.BoxWidthStyle selectionWidthStyle = ui.BoxWidthStyle.tight,
    Brightness? keyboardAppearance,
    EdgeInsets scrollPadding = const EdgeInsets.all(20),
    DragStartBehavior dragStartBehavior = DragStartBehavior.start,
    bool? enableInteractiveSelection,
    TextSelectionControls? selectionControls,
    GestureTapCallback? onPressed,
    bool onPressedAlwaysCalled = false,
    TapRegionCallback? onPressedOutside,
    MouseCursor? mouseCursor,
    ScrollController? scrollController,
    ScrollPhysics? scrollPhysics,
    Iterable<String> autofillHints = const <String>[],
    ContentInsertionConfiguration? contentInsertionConfiguration,
    Clip clipBehavior = Clip.hardEdge,
    String? restorationId,
    bool scribbleEnabled = true,
    bool stylusHandwritingEnabled =
        EditableText.defaultStylusHandwritingEnabled,
    bool enableIMEPersonalizedLearning = true,
    EditableTextContextMenuBuilder contextMenuBuilder = _defaultContextMenuBuilder,
    SpellCheckConfiguration? spellCheckConfiguration,
    TextMagnifierConfiguration magnifierConfiguration =
        TextMagnifierConfiguration.disabled,
    Color? selectionColor,
    EdgeInsets? padding,
    Widget? leading,
    Widget? trailing,
    MainAxisAlignment? mainAxisAlignment,
    CrossAxisAlignment? crossAxisAlignment,
    TextStyle? placeholderStyle,
    Alignment? placeholderAlignment,
    EdgeInsets? inputPadding,
    double? gap,
    BoxConstraints? constraints,
    Object? groupId,
    EdgeInsets? scrollbarPadding,
  })  : _textController = controller,
        super(
          builder: (ReactiveFormFieldState<T, String> field) {
            final state = field as _ReactiveShadInputState<T>;
            final errorText = field.errorText;

            final effectiveDecoration =
                (decoration ?? ShadTheme.of(field.context).decoration)
                    .mergeWith(ShadTheme.of(field.context).decoration);

            return ShadInputDecorator(
              label: label,
              description: description,
              error: errorText != null
                  ? errorBuilder?.call(field.context, errorText) ??
                      Text(errorText)
                  : null,
              decoration: effectiveDecoration.copyWith(
                hasError: errorText != null,
              ),
              child: ShadInput(
                key: widgetKey,
                controller: state._textController,
                placeholder: placeholder,
                focusNode: state.focusNode,
                decoration: decoration,
                undoController: undoController,
                keyboardType: keyboardType,
                textInputAction: textInputAction,
                textCapitalization: textCapitalization,
                style: style,
                strutStyle: strutStyle,
                textAlign: textAlign,
                textDirection: textDirection,
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
                maxLengthEnforcement: maxLengthEnforcement,
                onChanged: field.didChange,
                onEditingComplete: onEditingComplete,
                onAppPrivateCommand: onAppPrivateCommand,
                inputFormatters: inputFormatters,
                enabled: enabled,
                cursorWidth: cursorWidth,
                cursorHeight: cursorHeight,
                cursorRadius: cursorRadius,
                cursorOpacityAnimates: cursorOpacityAnimates,
                cursorColor: cursorColor,
                keyboardAppearance: keyboardAppearance,
                scrollPadding: scrollPadding,
                dragStartBehavior: dragStartBehavior,
                enableInteractiveSelection: enableInteractiveSelection,
                selectionControls: selectionControls,
                onPressed: onPressed,
                onPressedAlwaysCalled: onPressedAlwaysCalled,
                onPressedOutside: onPressedOutside,
                mouseCursor: mouseCursor,
                scrollController: scrollController,
                scrollPhysics: scrollPhysics,
                autofillHints: autofillHints,
                contentInsertionConfiguration: contentInsertionConfiguration,
                clipBehavior: clipBehavior,
                restorationId: restorationId,
                scribbleEnabled: scribbleEnabled,
                enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
                contextMenuBuilder: contextMenuBuilder,
                spellCheckConfiguration: spellCheckConfiguration,
                magnifierConfiguration: magnifierConfiguration,
                selectionColor: selectionColor,
                padding: padding,
                leading: leading,
                trailing: trailing,
                mainAxisAlignment: mainAxisAlignment,
                crossAxisAlignment: crossAxisAlignment,
                placeholderStyle: placeholderStyle,
                placeholderAlignment: placeholderAlignment,
                inputPadding: inputPadding,
                gap: gap,
                constraints: constraints,
                stylusHandwritingEnabled: stylusHandwritingEnabled,
                groupId: groupId,
                scrollbarPadding: scrollbarPadding,
              ),
            );
          },
        );

  @override
  ReactiveFormFieldState<T, String> createState() =>
      _ReactiveShadInputState<T>();
}

class _ReactiveShadInputState<T>
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
    final currentWidget = widget as ReactiveShadInput<T>;
    _textController = (currentWidget._textController != null)
        ? currentWidget._textController!
        : TextEditingController();
    _textController.text = initialValue == null ? '' : initialValue.toString();
  }

  @override
  void dispose() {
    final currentWidget = widget as ReactiveShadInput<T>;
    if (currentWidget._textController == null) {
      _textController.dispose();
    }
    super.dispose();
  }
}
