library reactive_signature;

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:signature/signature.dart';

typedef SignatureBuilder = Widget Function(
  BuildContext context,
  Widget signaturePad,
  SignatureController controller,
);

/// A [ReactiveSignature] that contains a [Signature].
///
/// This is a convenience widget that wraps a [Signature] widget in a
/// [ReactiveSignature].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveSignature<T> extends ReactiveFormField<T, Uint8List> {
  /// Creates a [ReactiveSignature] that contains a [Signature].
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
  /// ReactiveSignature(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveSignature(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveSignature(
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
  /// ReactiveSignature(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [Signature] class
  /// and [Signature], the constructor.
  ReactiveSignature({
    super.key,
    super.formControlName,
    super.formControl,
    super.validationMessages,
    super.valueAccessor,
    super.showErrors,

    ////////////////////////////////////////////////////////////////////////////
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
    this.onDrawStart,
    this.onDrawMove,
    this.onDrawEnd,
  }) : super(
          builder: (field) {
            final state = field as _ReactiveSignatureState;
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
                        icon: const Icon(Icons.clear),
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

  final VoidCallback? onDrawStart;

  final VoidCallback? onDrawMove;

  final VoidCallback? onDrawEnd;

  @override
  ReactiveFormFieldState<T, Uint8List> createState() =>
      _ReactiveSignatureState();
}

class _ReactiveSignatureState<T> extends ReactiveFormFieldState<T, Uint8List> {
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
      onDrawStart: reactiveSignature.onDrawStart,
      onDrawMove: reactiveSignature.onDrawMove,
      onDrawEnd: reactiveSignature.onDrawEnd,
    );

    _signatureController.addListener(() async {
      if (!control.hasFocus) {
        control.focus();
      }
      if (_signatureController.isEmpty) {
        didChange(null);
      }
    });

    _signatureController.onDrawEnd = () async {
      didChange(await _signatureController.toPngBytes());
    };
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
