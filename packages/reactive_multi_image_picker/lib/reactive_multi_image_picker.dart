library reactive_multi_image_picker;

import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_multi_image_picker/multi_image.dart';

export 'package:multi_image_picker/multi_image_picker.dart';

typedef PickImageCallback = Future<void> Function();
typedef ImagePickerChangeCallback<T> = void Function(MultiImage<T> images);

typedef ImagePickerBuilder<T> = Widget Function(
  PickImageCallback pickImage,
  MultiImage<T> images,
  ImagePickerChangeCallback<T> onChange,
);

/// A [ReactiveMultiImagePicker] that contains a [ReactiveMultiImagePicker].
///
/// This is a convenience widget that wraps a [ReactiveMultiImagePicker] widget in a
/// [ReactiveMultiImagePicker].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveMultiImagePicker<T>
    extends ReactiveFormField<MultiImage<T>, MultiImage<T>> {
  /// Creates a [ReactiveMultiImagePicker] that contains a [ReactiveMultiImagePicker].
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
  /// ReactiveMultiImagePicker(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveMultiImagePicker(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveMultiImagePicker(
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
  /// ReactiveMultiImagePicker(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [ReactiveMultiImagePicker] class
  /// and [ReactiveMultiImagePicker], the constructor.
  ReactiveMultiImagePicker({
    Key? key,
    String? formControlName,
    FormControl<MultiImage<T>>? formControl,
    Map<String, ValidationMessageFunction>? validationMessages,
    ControlValueAccessor<MultiImage<T>, MultiImage<T>>? valueAccessor,
    ShowErrorsFunction? showErrors,

    ////////////////////////////////////////////////////////////////////////////
    InputDecoration? decoration,
    required ImagePickerBuilder<T> imagePickerBuilder,
    int maxImages = 300,
    bool enableCamera = false,
    CupertinoOptions cupertinoOptions = const CupertinoOptions(),
    MaterialOptions materialOptions = const MaterialOptions(),
    double disabledOpacity = 0.5,
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          valueAccessor: valueAccessor,
          validationMessages: validationMessages,
          showErrors: showErrors,
          builder: (field) {
            final value = field.value ?? MultiImage<T>();

            final InputDecoration effectiveDecoration = (decoration ??
                    const InputDecoration())
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);

            String? pickerError;

            pickImage() async {
              try {
                final resultList = await MultiImagePicker.pickImages(
                  maxImages: maxImages,
                  enableCamera: enableCamera,
                  selectedAssets: value.assets,
                  cupertinoOptions: cupertinoOptions,
                  materialOptions: materialOptions,
                );

                field.control.markAsTouched();
                field.didChange(value.copyWith(assets: resultList));
              } on Exception catch (e) {
                pickerError = e.toString();
              }
            }

            return InputDecorator(
              decoration: effectiveDecoration.copyWith(
                errorText: field.errorText ?? pickerError,
                enabled: field.control.enabled,
              ),
              child: IgnorePointer(
                ignoring: !field.control.enabled,
                child: Opacity(
                  opacity: field.control.enabled ? 1 : disabledOpacity,
                  child: imagePickerBuilder.call(pickImage, value, (images) {
                    field.control.markAsTouched();
                    field.didChange(images);
                  }),
                ),
              ),
            );
          },
        );
}
