import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

export 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

const decorationInvisible = InputDecoration(
  border: InputBorder.none,
  contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
  isDense: true,
  isCollapsed: true,
);

/// A [ReactiveSfSignaturePad] that contains a [SfSignaturePad].
///
/// This is a convenience widget that wraps a [SfSignaturePad] widget in a
/// [ReactiveSfSignaturePad].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveSfSignaturePad<T> extends ReactiveFormField<T, Uint8List> {
  /// Creates a [ReactiveSfSignaturePad] that contains a [SfSignaturePad].
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
  /// ReactiveSfSignaturePad(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveSfSignaturePad(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveSfSignaturePad(
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
  /// ReactiveSfSignaturePad(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [SfSignaturePad] class
  /// and [SfSignaturePad], the constructor.
  ReactiveSfSignaturePad({
    Key? key,
    Key? widgetKey,
    String? formControlName,
    FormControl<T>? formControl,
    Map<String, ValidationMessageFunction>? validationMessages,
    ControlValueAccessor<T, Uint8List>? valueAccessor,
    ShowErrorsFunction<T>? showErrors,

    //////////////////////////////////////////////////////////////////////////
    InputDecoration decoration = decorationInvisible,
    double minimumStrokeWidth = 0.8,
    double maximumStrokeWidth = 5.0,
    Color? backgroundColor,
    Color? strokeColor,
    SignatureOnDrawStartCallback? onDrawStart,
    SignatureDrawCallback? onDraw,
    VoidCallback? onDrawEnd,
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          valueAccessor: valueAccessor,
          validationMessages: validationMessages,
          showErrors: showErrors,
          builder: (field) {
            final InputDecoration effectiveDecoration = decoration
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);

            return IgnorePointer(
              ignoring: !field.control.enabled,
              child: Listener(
                onPointerDown: (_) => field.control.markAsTouched(),
                child: InputDecorator(
                  decoration: effectiveDecoration.copyWith(
                    errorText: field.errorText,
                    enabled: field.control.enabled,
                  ),
                  child: SfSignaturePad(
                    key: widgetKey,
                    minimumStrokeWidth: minimumStrokeWidth,
                    maximumStrokeWidth: maximumStrokeWidth,
                    backgroundColor: backgroundColor,
                    strokeColor: strokeColor,
                    onDrawStart: onDrawStart,
                    onDraw: onDraw,
                    onDrawEnd: () async {
                      if (widgetKey != null &&
                          widgetKey is GlobalKey<SfSignaturePadState>) {
                        final currentState = widgetKey.currentState;

                        if (currentState != null) {
                          final data = await currentState.toImage(
                            pixelRatio: 3.0,
                          );

                          final bytes = await data.toByteData(
                            format: ui.ImageByteFormat.png,
                          );

                          field.didChange(bytes?.buffer.asUint8List());
                        }
                      }

                      onDrawEnd?.call();
                    },
                  ),
                ),
              ),
            );
          },
        );
}
