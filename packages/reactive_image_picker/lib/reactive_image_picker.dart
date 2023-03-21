// ignore_for_file: use_build_context_synchronously

library reactive_image_picker;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'image_file.dart';

export 'package:image_picker/image_picker.dart';

typedef ImageViewBuilder = Widget Function(ImageFile image);

typedef ImageBuilder = Widget Function(
    ImageFile image, VoidCallback handleDelete, VoidCallback selectImage);

typedef InputButtonBuilder = Widget Function(VoidCallback onPressed);

typedef ErrorBuilder = Map<String, Object> Function(
  String errorCode,
  Object error,
);

typedef PreprocessPickerError = Future<void> Function(
  Object error,
);

typedef DeleteDialogBuilder = Future<void> Function(
  BuildContext context,
  VoidCallback onConfirm,
);

typedef PopupDialogBuilder = Future<ImageSource?> Function(
    BuildContext context);

typedef OnBeforeChangeCallback = Future<ImageFile?> Function(
    BuildContext context, ImageFile image);

enum ImagePickerMode { image, video, multiImage }

typedef ImagePickCallback = void Function(
  BuildContext context,
  ImageSource source,
);

final x = FocusNode();

/// A [ReactiveImagePicker] that contains a [DropdownSearch].
///
/// This is a convenience widget that wraps a [DropdownSearch] widget in a
/// [ReactiveImagePicker].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveImagePicker extends ReactiveFormField<ImageFile, ImageFile> {
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
    FormControl<ImageFile>? formControl,
    Map<String, ValidationMessageFunction>? validationMessages,
    ControlValueAccessor<ImageFile, ImageFile>? valueAccessor,
    ShowErrorsFunction? showErrors,
    InputDecoration? decoration,
    InputButtonBuilder? inputBuilder,
    ImageViewBuilder? imageViewBuilder,
    ImageBuilder? imageBuilder,
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
    // ImagePickerMode mode = ImagePickerMode.image,
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
            // TextField

            return IgnorePointer(
              ignoring: !field.control.enabled,
              child: Opacity(
                opacity: field.control.enabled ? 1 : disabledOpacity,
                child: ImagePickerWidget(
                  imageViewBuilder: imageViewBuilder,
                  imageBuilder: imageBuilder,
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
                  imageContainerDecoration: imageContainerDecoration,
                  deleteDialogBuilder: deleteDialogBuilder,
                  editIcon: editIcon,
                  deleteIcon: deleteIcon,
                  decoration:
                      effectiveDecoration.copyWith(errorText: field.errorText),
                  onChanged: field.didChange,
                  value: field.value ?? const ImageFile(),
                  maxHeight: maxHeight,
                  maxWidth: maxWidth,
                  imageQuality: imageQuality,
                  preferredCameraDevice: preferredCameraDevice,
                  maxDuration: maxDuration,
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

class ImagePickerWidget extends StatelessWidget {
  final InputDecoration decoration;
  final OnBeforeChangeCallback? onBeforeChange;
  final BoxDecoration? imageContainerDecoration;
  final Widget? editIcon;
  final Widget? deleteIcon;
  final InputButtonBuilder? inputBuilder;
  final ImageViewBuilder? imageViewBuilder;
  final ImageBuilder? imageBuilder;
  final DeleteDialogBuilder? deleteDialogBuilder;
  final PreprocessPickerError? processPickerError;
  final PopupDialogBuilder? popupDialogBuilder;
  final ImageFile value;
  final bool enabled;
  final double? maxWidth;
  final double? maxHeight;
  final int? imageQuality;
  final CameraDevice preferredCameraDevice;
  final ValueChanged<ImageFile?> onChanged;
  final Duration? maxDuration;
  final bool requestFullMetadata;
  final Future<void> Function()? onBeforePick;
  final Future<void> Function()? onAfterPick;

  // final ImagePickerMode mode;

  const ImagePickerWidget({
    Key? key,
    required this.value,
    this.enabled = true,
    required this.onChanged,
    required this.decoration,
    this.imageViewBuilder,
    this.imageBuilder,
    this.inputBuilder,
    this.imageContainerDecoration,
    this.editIcon,
    this.deleteIcon,
    this.deleteDialogBuilder,
    this.processPickerError,
    this.popupDialogBuilder,
    this.onBeforeChange,
    this.maxWidth,
    this.maxHeight,
    this.imageQuality,
    this.preferredCameraDevice = CameraDevice.rear,
    this.maxDuration,
    this.requestFullMetadata = true,
    this.onBeforePick,
    this.onAfterPick,
  }) : super(key: key);

  Future<ImageFile?> _onImageButtonPressed(
      BuildContext context, ImageSource source) async {
    final picker = ImagePicker();

    try {
      final pickedFile = await picker.pickImage(
        source: source,
        maxHeight: maxHeight,
        maxWidth: maxWidth,
        imageQuality: imageQuality,
        preferredCameraDevice: preferredCameraDevice,
        requestFullMetadata: requestFullMetadata,
      );

      if (pickedFile != null) {
        final imageFile = value.copyWith(image: File(pickedFile.path));

        if (onBeforeChange != null) {
          return await onBeforeChange?.call(context, imageFile);
        }

        return imageFile;
      }
    } on PlatformException catch (e) {
      await processPickerError?.call(e);
    } catch (e) {
      await processPickerError?.call(e);
    }

    return null;
  }

  // void _onVideoButtonPressed(BuildContext context, ImageSource source) async {
  //   final picker = ImagePicker();
  //
  //   try {
  //     final pickedFile = await picker.pickVideo(
  //       source: source,
  //       maxDuration: maxDuration,
  //       preferredCameraDevice: preferredCameraDevice,
  //     );
  //
  //     if (pickedFile != null) {
  //       final imageFile = value.copyWith(image: File(pickedFile.path));
  //
  //       onChanged(await onBeforeChange?.call(context, imageFile) ??
  //           await _onBeforeChange(imageFile));
  //     }
  //   } catch (e) {
  //     errorPickBuilder?.call(source, context: context);
  //   }
  // }

  Future<ImageSource?> _widgetPopupDialog(BuildContext context) async {
    return await showModalBottomSheet<ImageSource>(
      isScrollControlled: true,
      context: context,
      builder: (context) => Row(
        children: <Widget>[
          Expanded(
              flex: 3,
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.photo_camera),
                      title: const Text('Take photo'),
                      onTap: () =>
                          Navigator.of(context).pop(ImageSource.camera),
                    ),
                    ListTile(
                      leading: const Icon(Icons.photo),
                      title: const Text('Choose from library'),
                      onTap: () =>
                          Navigator.of(context).pop(ImageSource.gallery),
                    ),
                    // ListTile(
                    //   leading: Icon(Icons.video_call),
                    //   title: Text('Take video'),
                    //   onTap: () {
                    //     Navigator.of(context).pop();
                    //     _onVideoButtonPressed(
                    //       context,
                    //       ImageSource.camera,
                    //     );
                    //   },
                    // ),
                    // ListTile(
                    //   leading: Icon(Icons.video_call),
                    //   title: Text('Choose video from library'),
                    //   onTap: () {
                    //     Navigator.of(context).pop();
                    //     _onVideoButtonPressed(
                    //       context,
                    //       ImageSource.gallery,
                    //     );
                    //   },
                    // ),
                    ListTile(
                      leading: const Icon(Icons.clear),
                      title: const Text('Cancel'),
                      onTap: Navigator.of(context).pop,
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }

  void _buildPopupMenu(BuildContext context) async {
    await onBeforePick?.call();
    final source = await (popupDialogBuilder?.call(context) ??
        _widgetPopupDialog(context));

    if (source != null) {
      final file = await _onImageButtonPressed(context, source);

      if ((value.isNotEmpty && file != null) || value.isEmpty) {
        onChanged(file);
      }
    }
    await onAfterPick?.call();
  }

  void _onConfirm() => onChanged(null);

  void _handleDelete(BuildContext context) async {
    if (deleteDialogBuilder != null) {
      await deleteDialogBuilder?.call(context, _onConfirm);
      return;
    }

    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete image"),
          content: const Text("This action could not be undone"),
          actions: [
            TextButton(
              child: const Text("CLOSE"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text("CONFIRM"),
              onPressed: () {
                _onConfirm();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildImage(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: imageContainerDecoration ??
          BoxDecoration(
            borderRadius: BorderRadius.circular(6),
          ),
      child: imageBuilder?.call(value, () => _handleDelete(context),
              () => _buildPopupMenu(context)) ??
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              imageViewBuilder?.call(value) ??
                  SizedBox(
                    height: 250,
                    child: _ImageView(image: value),
                  ),
              if (enabled)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      onPressed: () => _buildPopupMenu(context),
                      icon: editIcon ?? const Icon(Icons.edit),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () => _handleDelete(context),
                      icon: deleteIcon ?? const Icon(Icons.delete),
                    )
                  ],
                )
            ],
          ),
    );
  }

  Widget _buildInput(BuildContext context) {
    return inputBuilder?.call(() => _buildPopupMenu(context)) ??
        OutlinedButton.icon(
          onPressed: () => _buildPopupMenu(context),
          icon: const Icon(Icons.add, color: Color(0xFF00A7E1)),
          label: const Text('Pick image'),
        );
  }

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: decoration,
      child: value.isNotEmpty ? _buildImage(context) : _buildInput(context),
    );
  }
}

class _ImageView extends StatelessWidget {
  final ImageFile image;

  const _ImageView({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageFile = image.image;
    if (imageFile != null) {
      return Image.file(imageFile, fit: BoxFit.cover);
    }

    final localImage = image.localImage;
    if (localImage != null) {
      final file = File(localImage);
      return Image.memory(file.readAsBytesSync(), fit: BoxFit.cover);
    }

    final imageUrl = image.imageUrl;
    if (imageUrl != null) {
      return Image.network(imageUrl);
    }

    return Container();
  }
}
