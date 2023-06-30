// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_image_picker/src/image_picker_widget.dart';
import 'package:reactive_image_picker/src/selected_file_view.dart';

import 'image_file.dart';

export 'package:image_picker/image_picker.dart';

enum ImagePickerMode {
  cameraImage,
  galleryImage,
  galleryMultiImage,
  galleryVideo,
  cameraVideo,
}

typedef ImagePickCallback = void Function(
  BuildContext context,
  ImageSource source,
);

/// A [ReactiveImagePicker] that contains a [DropdownSearch].
///
/// This is a convenience widget that wraps a [DropdownSearch] widget in a
/// [ReactiveImagePicker].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveImagePicker
    extends ReactiveFormField<List<SelectedFile>, List<SelectedFile>> {
  /// Creates a [ReactiveImagePicker] that contains a [DropdownSearch].
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
  /// ReactiveUpload(
  ///   formControlName: 'image',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'image': Validators.required});
  ///
  /// ReactiveUpload(
  ///   formControl: form.control('image'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveUpload(
  ///   formControlName: 'image',
  ///   validationMessages: {
  ///     ValidationMessage.required: 'The image must not be empty',
  ///   }
  /// ),
  /// ```
  ///
  /// Customize when to show up validation messages.
  /// ```dart
  /// ReactiveUpload(
  ///   formControlName: 'image',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [ImagePicker] class
  /// and [ImagePicker], the constructor.
  ReactiveImagePicker({
    Key? key,
    String? formControlName,
    FormControl<List<SelectedFile>>? formControl,
    Map<String, ValidationMessageFunction>? validationMessages,
    ControlValueAccessor<List<SelectedFile>, List<SelectedFile>>? valueAccessor,
    ShowErrorsFunction<List<SelectedFile>>? showErrors,
    InputDecoration? decoration,
    InputButtonBuilder? inputBuilder,
    SelectedFileViewBuilder? selectedFileViewBuilder,
    SelectedValueBuilder? selectedValueBuilder,
    DeleteDialogBuilder? deleteDialogBuilder,
    ErrorBuilder? errorBuilder,
    PreprocessPickerError? preprocessError,
    PopupDialogBuilder? popupDialogBuilder,
    BoxDecoration? imageContainerDecoration,
    OnBeforeChangeCallback? onBeforeChange,
    Widget? editIcon,
    Widget? deleteIcon,
    bool enabled = true,
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
    CameraDevice preferredCameraDevice = CameraDevice.rear,
    Duration? maxDuration,
    double disabledOpacity = 0.5,
    List<ImagePickerMode> modes = ImagePickerMode.values,
    SelectedImageBuilder? selectedImageBuilder,
    SelectedVideoBuilder? selectedVideoBuilder,
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          valueAccessor: valueAccessor,
          showErrors: showErrors,
          validationMessages: _validationMessages(validationMessages),
          builder: (field) {
            final InputDecoration effectiveDecoration = (decoration ??
                    const InputDecoration())
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);

            return IgnorePointer(
              ignoring: !field.control.enabled,
              child: Opacity(
                opacity: field.control.enabled ? 1 : disabledOpacity,
                child: ImagePickerWidget(
                  modes: modes,
                  selectedFileViewBuilder: selectedFileViewBuilder,
                  selectedValueBuilder: selectedValueBuilder,
                  onBeforePick: () async {
                    field.control.focus();
                    field.control.updateValueAndValidity();
                  },
                  onAfterPick: () async {
                    field.control.unfocus();
                    // field.control.updateValueAndValidity();
                    field.control.markAsTouched();
                  },
                  popupDialogBuilder: popupDialogBuilder,
                  onBeforeChange: onBeforeChange,
                  processPickerError: preprocessError,
                  inputBuilder: inputBuilder,
                  deleteDialogBuilder: deleteDialogBuilder,
                  editIcon: editIcon,
                  deleteIcon: deleteIcon,
                  decoration:
                      effectiveDecoration.copyWith(errorText: field.errorText),
                  onChanged: field.didChange,
                  value: field.value ?? [],
                  maxHeight: maxHeight,
                  maxWidth: maxWidth,
                  imageQuality: imageQuality,
                  preferredCameraDevice: preferredCameraDevice,
                  maxDuration: maxDuration,
                  selectedImageBuilder: selectedImageBuilder,
                  selectedVideoBuilder: selectedVideoBuilder,
                ),
              ),
            );
          },
        );

  static Map<String, ValidationMessageFunction>? _validationMessages(
    Map<String, ValidationMessageFunction>? validationMessages,
  ) {
    final error = validationMessages ?? {};

    if (error.containsKey(ImageSource.camera.toString()) != true) {
      error.addEntries([
        MapEntry(
          ImageSource.camera.toString(),
          (_) => 'Error while taking image from camera',
        )
      ]);
    }

    if (error.containsKey(ImageSource.gallery.toString()) != true) {
      error.addEntries([
        MapEntry(
          ImageSource.gallery.toString(),
          (_) => 'Error while taking image from gallery',
        )
      ]);
    }

    return error;
  }
}
