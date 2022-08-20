import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// A [ReactiveMacosPopupButton] that contains a [MacosSwitch].
///
/// This is a convenience widget that wraps a [MacosSwitch] widget in a
/// [ReactiveMacosPopupButton].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveMacosPopupButton<T, V> extends ReactiveFormField<T, V> {
  /// Creates a [ReactiveMacosPopupButton] that contains a [MacosSwitch].
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
  /// ReactiveMacosPopupButton(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveMacosPopupButton(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveMacosPopupButton(
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
  /// ReactiveMacosPopupButton(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [MacosSwitch] class
  /// and [MacosSwitch], the constructor.
  ReactiveMacosPopupButton({
    Key? key,
    String? formControlName,
    FormControl<T>? formControl,
    Map<String, ValidationMessageFunction>? validationMessages,
    ControlValueAccessor<T, V>? valueAccessor,
    ShowErrorsFunction? showErrors,

    ////////////////////////////////////////////////////////////////////////////
    InputDecoration decoration = const InputDecoration(
      border: InputBorder.none,
      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      isDense: true,
      isCollapsed: true,
    ),
    List<MacosPopupMenuItem<V>>? items,
    Widget? disabledHint,
    Widget? hint,
    double? itemHeight = 24.0,
    TextStyle? style,
    FocusNode? focusNode,
    bool autofocus = false,
    AlignmentDirectional alignment = AlignmentDirectional.centerStart,
    double? menuMaxHeight,
    Color? popupColor,
    VoidCallback? onTap,
    MacosPopupButtonBuilder? selectedItemBuilder,
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          valueAccessor: valueAccessor,
          validationMessages: validationMessages,
          showErrors: showErrors,
          builder: (field) {
            final state = field as ReactiveMacosPopupButtonState<T, V>;

            state._setFocusNode(focusNode);

            return Listener(
              onPointerDown: (_) {
                if (field.control.enabled) {
                  field.control.markAsTouched();
                }
              },
              child: MacosPopupButton<V>(
                selectedItemBuilder: selectedItemBuilder,
                value: field.value,
                items: items,
                hint: hint,
                disabledHint: disabledHint,
                onChanged: field.control.enabled ? field.didChange : null,
                onTap: onTap,
                style: style,
                itemHeight: itemHeight,
                autofocus: autofocus,
                focusNode: state.focusNode,
                popupColor: popupColor,
                menuMaxHeight: menuMaxHeight,
                alignment: alignment,
              ),
            );
          },
        );

  @override
  ReactiveMacosPopupButtonState<T, V> createState() =>
      ReactiveMacosPopupButtonState<T, V>();
}

class ReactiveMacosPopupButtonState<T, V> extends ReactiveFormFieldState<T, V> {
  FocusNode? _focusNode;
  late FocusController _focusController;

  @override
  FocusNode get focusNode => _focusNode ?? _focusController.focusNode;

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
