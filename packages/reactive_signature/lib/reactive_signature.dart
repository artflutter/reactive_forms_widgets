library reactive_signature;

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:signature/signature.dart';

typedef Widget SignatureBuilder(
  BuildContext context,
  Widget signaturePad,
  SignatureController controller,
);

/// A [ReactiveSignature] that contains a [TextField].
///
/// This is a convenience widget that wraps a [TextField] widget in a
/// [ReactiveSignature].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveSignature extends ReactiveFormField<Uint8List, Uint8List> {
  /// Creates a [ReactiveSignature] that contains a [TextField].
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
  /// ReactiveTextField(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveTextField(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveTextField(
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
  /// ReactiveTextField(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [TextField] class
  /// and [new TextField], the constructor.
  ReactiveSignature({
    Key? key,
    String? formControlName,
    FormControl<Uint8List>? formControl,
    ValidationMessagesFunction<Uint8List>? validationMessages,
    ControlValueAccessor<Uint8List, Uint8List>? valueAccessor,
    ShowErrorsFunction? showErrors,
    InputDecoration? decoration,
    SignatureController? controller,
    SignatureBuilder? signatureBuilder,
    Color backgroundColor = Colors.grey,
    double? width,
    double? height,
    this.penColor = Colors.black,
    this.exportBackgroundColor = Colors.blue,
    this.penStrokeWidth = 3.0,
    this.points,
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          valueAccessor: valueAccessor,
          validationMessages: validationMessages,
          showErrors: showErrors,
          builder: (ReactiveFormFieldState field) {
            final state = field as _ReactiveTextFieldState;
            final InputDecoration effectiveDecoration = (decoration ??
                    const InputDecoration())
                .applyDefaults(Theme.of(state.context).inputDecorationTheme);

            final child = Signature(
              controller: state._signatureController,
              width: width,
              height: height,
              backgroundColor: backgroundColor,
            );

            return InputDecorator(
              decoration: effectiveDecoration.copyWith(
                errorText: field.errorText,
                enabled: field.control.enabled,
              ),
              child: signatureBuilder?.call(
                      field.context, child, state._signatureController) ??
                  Row(
                    children: [
                      Expanded(child: child),
                      IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () => state._signatureController.clear(),
                      )
                    ],
                  ),
            );
          },
        );

  final double penStrokeWidth;

  final Color penColor;

  final Color exportBackgroundColor;

  final List<Point>? points;

  @override
  ReactiveFormFieldState<Uint8List, Uint8List> createState() =>
      _ReactiveTextFieldState();
}

class _ReactiveTextFieldState
    extends ReactiveFormFieldState<Uint8List, Uint8List> {
  late SignatureController _signatureController;

  @override
  void initState() {
    super.initState();

    final reactiveSignature = widget as ReactiveSignature;
    _signatureController = SignatureController(
      points: reactiveSignature.points,
      penStrokeWidth: reactiveSignature.penStrokeWidth,
      penColor: reactiveSignature.penColor,
      exportBackgroundColor: reactiveSignature.exportBackgroundColor,
    );

    _signatureController.addListener(() async {
      this.control.focus();
      didChange(await _signatureController.toPngBytes());
    });
  }

  @override
  void dispose() {
    _signatureController.dispose();
    super.dispose();
  }

  @override
  void onControlValueChanged(dynamic value) {
    _signatureController.value = _signatureController.value;

    super.onControlValueChanged(value);
  }
}
