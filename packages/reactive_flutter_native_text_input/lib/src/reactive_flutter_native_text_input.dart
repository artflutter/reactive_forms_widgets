import 'package:flutter/material.dart';
import 'package:flutter_native_text_input/flutter_native_text_input.dart';
import 'package:reactive_forms/reactive_forms.dart';

typedef ControllerInitCallback = void Function(
    TextEditingController controller);

/// A [ReactiveFlutterNativeTextInput] that contains a [FlutterNativeTextInput].
///
/// This is a convenience widget that wraps a [FlutterNativeTextInput] widget in a
/// [ReactiveFlutterNativeTextInput].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveFlutterNativeTextInput<T> extends ReactiveFormField<T, String> {
  final ControllerInitCallback? onControllerInit;

  /// Creates a [ReactiveFlutterNativeTextInput] that contains a [FlutterNativeTextInput].
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
  /// ReactiveFlutterNativeTextInput(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveFlutterNativeTextInput(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveFlutterNativeTextInput(
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
  /// ReactiveFlutterNativeTextInput(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [FlutterNativeTextInput] class
  /// and [FlutterNativeTextInput], the constructor.
  ReactiveFlutterNativeTextInput(
      {Key? key,
        String? formControlName,
        FormControl<T>? formControl,
        Map<String, ValidationMessageFunction>? validationMessages,
        ControlValueAccessor<T, String>? valueAccessor,
        ShowErrorsFunction? showErrors,

        //////////////////////////////////////////////////////////////////////////
        InputDecoration inputDecoration = const InputDecoration(
          isCollapsed: true,
          contentPadding: EdgeInsets.zero,
          border: InputBorder.none,
        ),
        TextEditingController? controller,
        BoxDecoration? decoration,
        FocusNode? focusNode,
        IosOptions? iosOptions,
        KeyboardType keyboardType  = KeyboardType.defaultType,
        double minHeightPadding = 18,
        int maxLines = 1,
        int minLines = 1,
        String? placeholder,
        Color? placeholderColor,
        ReturnKeyType returnKeyType = ReturnKeyType.done,
        TextStyle? style,
        TextAlign textAlign = TextAlign.start,
        TextCapitalization textCapitalization = TextCapitalization.none,
        TextContentType? textContentType,
        ValueChanged<String>? onChanged,
        VoidCallback? onEditingComplete,
        ValueChanged<String?>? onSubmitted,
        VoidCallback? onTap,
        this.onControllerInit,
    })
      : super(
    key: key,
    formControl: formControl,
    formControlName: formControlName,
    valueAccessor: valueAccessor,
    validationMessages: validationMessages,
    showErrors: showErrors,
    builder: (field) {
      final state = field as _ReactiveFlutterNativeTextInputState<T>;
      final effectiveDecoration = inputDecoration
          .applyDefaults(Theme.of(field.context).inputDecorationTheme);

      return InputDecorator(
          decoration: effectiveDecoration.copyWith(
            errorText: field.errorText,
            enabled: field.control.enabled,
          ),
        child: NativeTextInput(
            controller: state._textController,
          decoration:decoration,
          focusNode:focusNode,
          iosOptions:iosOptions,
          keyboardType:keyboardType,
          maxLines:maxLines,
          minHeightPadding:minHeightPadding,
          minLines:minLines,
          placeholder:placeholder,
          placeholderColor:placeholderColor,
          returnKeyType:returnKeyType,
          style:style,
          textAlign:textAlign,
          textCapitalization:textCapitalization,
          textContentType:textContentType,
          onChanged: (value) => field.didChange(value),
          onEditingComplete:onEditingComplete,
          onSubmitted:onSubmitted,
          onTap:onTap,
        ),
      );
    },
  );

  @override
  ReactiveFormFieldState<T, String> createState() =>
      _ReactiveFlutterNativeTextInputState<T>();
}

class _ReactiveFlutterNativeTextInputState<T> extends ReactiveFormFieldState<T, String> {
  late TextEditingController _textController;
  FocusNode? _focusNode;
  late FocusController _focusController;

  @override
  FocusNode get focusNode => _focusNode ?? _focusController.focusNode;

  @override
  void initState() {
    super.initState();

    final initialValue = value;
    _textController = TextEditingController(
        text: initialValue == null ? '' : initialValue.toString());

    (widget as ReactiveFlutterNativeTextInput<T>).onControllerInit?.call(_textController);
  }

  @override
  void didUpdateWidget(ReactiveFormField<T, String> oldWidget) {
    final newControl = _resolveFormControl();
    if (control != newControl) {
      unsubscribeControl();
      control = newControl;
      subscribeControl();
      final initialValue = value;
      _textController.text =
      initialValue == null ? '' : initialValue.toString();
    }

    super.didUpdateWidget(oldWidget);
  }

  FormControl<T> _resolveFormControl() {
    if (widget.formControl != null) {
      return widget.formControl!;
    }

    final parent = ReactiveForm.of(context, listen: false);
    if (parent == null || parent is! FormControlCollection) {
      throw FormControlParentNotFoundException(widget);
    }

    final collection = parent as FormControlCollection;
    final control = collection.control(widget.formControlName!);
    if (control is! FormControl<T>) {
      throw BindingCastException<T, String>(widget, control);
    }

    return control;
  }

  @override
  void subscribeControl() {
    _registerFocusController(FocusController());
    super.subscribeControl();
  }

  @override
  void dispose() {
    _unregisterFocusController();
    _textController.dispose();
    super.dispose();
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
