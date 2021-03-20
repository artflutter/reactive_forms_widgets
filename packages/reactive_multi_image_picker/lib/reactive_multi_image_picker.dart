library reactive_multi_image_picker;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';

export 'package:multi_image_picker/multi_image_picker.dart';

typedef Future<void> PickImageCallback();
typedef Widget ImagePickerBuilder(
    PickImageCallback pickImage, List<Asset> images);

/// A [ReactiveMultiImagePicker] that contains a [CupertinoSegmentedControl].
///
/// This is a convenience widget that wraps a [CupertinoSegmentedControl] widget in a
/// [ReactiveMultiImagePicker].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveMultiImagePicker extends ReactiveFormField<List<Asset>> {
  /// Creates a [ReactiveMultiImagePicker] that contains a [CupertinoSegmentedControl].
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
  /// For documentation about the various parameters, see the [CupertinoSegmentedControl] class
  /// and [new CupertinoSegmentedControl], the constructor.
  ReactiveMultiImagePicker({
    Key key,
    String formControlName,
    InputDecoration decoration,
    FormControl formControl,
    ValidationMessagesFunction validationMessages,
    ControlValueAccessor valueAccessor,
    ShowErrorsFunction showErrors,
    ImagePickerBuilder imagePickerBuilder,
    int maxImages = 300,
    bool enableCamera = false,
    CupertinoOptions cupertinoOptions = const CupertinoOptions(),
    MaterialOptions materialOptions = const MaterialOptions(),
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          valueAccessor: valueAccessor,
          validationMessages: validationMessages,
          showErrors: showErrors,
          builder: (ReactiveFormFieldState field) {
            final InputDecoration effectiveDecoration = (decoration ??
                    const InputDecoration())
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);

            var resultList = <Asset>[];
            String pickerError;

            final pickImage = () async {
              try {
                resultList = await MultiImagePicker.pickImages(
                  maxImages: maxImages,
                  enableCamera: enableCamera,
                  selectedAssets: field.value,
                  cupertinoOptions: cupertinoOptions,
                  materialOptions: materialOptions,
                );

                field.control.markAsTouched();
                field.didChange(resultList);
              } on Exception catch (e) {
                pickerError = e.toString();
              }
            };

            return InputDecorator(
              decoration: effectiveDecoration.copyWith(
                errorText: field.errorText ?? pickerError,
                enabled: field.control.enabled,
              ),
              child: imagePickerBuilder?.call(
                      pickImage, field.value as List<Asset>) ??
                  Column(
                    children: [
                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 3,
                          children: List.generate(
                              (field.value as List<Asset>).length, (index) {
                            final asset = field.value[index];
                            return AssetThumb(
                                asset: asset, width: 300, height: 300);
                          }),
                        ),
                      ),
                      ElevatedButton(
                        child: Text("Pick images"),
                        onPressed: pickImage,
                      ),
                    ],
                  ),
            );
          },
        );
}
