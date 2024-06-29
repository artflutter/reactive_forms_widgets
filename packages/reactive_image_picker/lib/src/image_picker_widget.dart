// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_image_picker/src/reactive_image_picker.dart';
import 'package:reactive_image_picker/src/selected_file_view.dart';
import 'package:reactive_image_picker/src/widget_popup_dialog.dart';

import 'image_file.dart';

typedef OnBeforeChangeCallback = Future<List<SelectedFile>> Function(
  BuildContext context,
  List<SelectedFile> value,
);

typedef SelectedFileViewBuilder = Widget Function(SelectedFile image);

typedef SelectedValueBuilder = Widget Function(
  List<SelectedFile> image,
  OnDelete handleDelete,
  OnChange handleChange,
);

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
  Function(SelectedFile file) onConfirm,
);

typedef PopupDialogBuilder = Future<ImagePickerMode?> Function(
  BuildContext context,
  List<ImagePickerMode> mode,
);

class ImagePickerWidget extends StatelessWidget {
  final InputDecoration decoration;
  final OnBeforeChangeCallback? onBeforeChange;
  final Size? mediaSize;
  final Widget? editIcon;
  final Widget? deleteIcon;
  final InputButtonBuilder? inputBuilder;
  final DeleteDialogBuilder? deleteDialogBuilder;
  final PreprocessPickerError? processPickerError;
  final PopupDialogBuilder? popupDialogBuilder;
  final List<SelectedFile> value;
  final bool enabled;
  final double? maxWidth;
  final double? maxHeight;
  final int? imageQuality;
  final CameraDevice preferredCameraDevice;
  final ValueChanged<List<SelectedFile>> onChanged;
  final Duration? maxDuration;
  final bool requestFullMetadata;
  final Future<void> Function()? onBeforePick;
  final Future<void> Function()? onAfterPick;
  final List<ImagePickerMode> modes;

  final SelectedValueBuilder? selectedValueBuilder;
  final SelectedFileViewBuilder? selectedFileViewBuilder;
  final SelectedImageBuilder? selectedImageBuilder;
  final SelectedVideoBuilder? selectedVideoBuilder;

  const ImagePickerWidget({
    super.key,
    required this.value,
    required this.modes,
    this.enabled = true,
    required this.onChanged,
    required this.decoration,
    this.selectedFileViewBuilder,
    this.selectedValueBuilder,
    this.inputBuilder,
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
    this.selectedImageBuilder,
    this.selectedVideoBuilder,
    this.mediaSize,
  });

  Future<List<SelectedFile>> _onImageButtonPressed(
    BuildContext context,
    ImagePickerMode mode,
  ) async {
    List<SelectedFile> result = [];
    switch (mode) {
      case ImagePickerMode.cameraImage:
        final file = await _pickCameraImage();
        if (file != null) {
          result = [file];
        }
        break;
      case ImagePickerMode.galleryImage:
        final file = await _pickGalleryImage();
        if (file != null) {
          result = [file];
        }
        break;
      case ImagePickerMode.galleryMultiImage:
        return await _pickMultiGalleryImage();
      case ImagePickerMode.galleryVideo:
        final file = await _pickGalleryVideo();
        if (file != null) {
          result = [file];
        }
        break;
      case ImagePickerMode.cameraVideo:
        final file = await _pickCameraVideo();
        if (file != null) {
          result = [file];
        }
        break;
    }

    if (onBeforeChange != null && context.mounted) {
      return await onBeforeChange!.call(context, result);
    }

    return result;
  }

  Future<SelectedFile?> _pickCameraImage() async {
    final picker = ImagePicker();

    try {
      final pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        maxHeight: maxHeight,
        maxWidth: maxWidth,
        imageQuality: imageQuality,
        preferredCameraDevice: preferredCameraDevice,
        requestFullMetadata: requestFullMetadata,
      );

      if (pickedFile != null) {
        final imageFile = SelectedFile.image(file: pickedFile);

        return imageFile;
      }
    } on PlatformException catch (e) {
      await processPickerError?.call(e);
    } catch (e) {
      await processPickerError?.call(e);
    }

    return null;
  }

  Future<SelectedFile?> _pickGalleryImage() async {
    final picker = ImagePicker();

    try {
      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: maxHeight,
        maxWidth: maxWidth,
        imageQuality: imageQuality,
        preferredCameraDevice: preferredCameraDevice,
        requestFullMetadata: requestFullMetadata,
      );

      if (pickedFile != null) {
        final imageFile = SelectedFile.image(file: pickedFile);

        // if (onBeforeChange != null && context.mounted) {
        //   return await onBeforeChange?.call(context, imageFile);
        // }

        return imageFile;
      }
    } on PlatformException catch (e) {
      await processPickerError?.call(e);
    } catch (e) {
      await processPickerError?.call(e);
    }

    return null;
  }

  Future<List<SelectedFile>> _pickMultiGalleryImage() async {
    final picker = ImagePicker();

    try {
      final pickedFile = await picker.pickMultiImage(
        maxHeight: maxHeight,
        maxWidth: maxWidth,
        imageQuality: imageQuality,
        requestFullMetadata: requestFullMetadata,
      );

      if (pickedFile.isNotEmpty) {
        final imageFile = pickedFile.map(
          (e) => SelectedFile.image(file: e),
        );

        // if (onBeforeChange != null && context.mounted) {
        //   return await onBeforeChange?.call(context, imageFile);
        // }

        return imageFile.toList();
      }
    } on PlatformException catch (e) {
      await processPickerError?.call(e);
    } catch (e) {
      await processPickerError?.call(e);
    }

    return [];
  }

  Future<SelectedFile?> _pickCameraVideo() async {
    final picker = ImagePicker();

    try {
      final pickedFile = await picker.pickVideo(
        source: ImageSource.camera,
        preferredCameraDevice: preferredCameraDevice,
      );

      if (pickedFile != null) {
        final imageFile = SelectedFile.video(file: pickedFile);

        // if (onBeforeChange != null && context.mounted) {
        //   return await onBeforeChange?.call(context, imageFile);
        // }

        return imageFile;
      }
    } on PlatformException catch (e) {
      await processPickerError?.call(e);
    } catch (e) {
      await processPickerError?.call(e);
    }

    return null;
  }

  Future<SelectedFile?> _pickGalleryVideo() async {
    final picker = ImagePicker();

    try {
      final pickedFile = await picker.pickVideo(
        source: ImageSource.gallery,
        preferredCameraDevice: preferredCameraDevice,
      );

      if (pickedFile != null) {
        final imageFile = SelectedFile.video(file: pickedFile);

        // if (onBeforeChange != null && context.mounted) {
        //   return await onBeforeChange?.call(context, imageFile);
        // }

        return imageFile;
      }
    } on PlatformException catch (e) {
      await processPickerError?.call(e);
    } catch (e) {
      await processPickerError?.call(e);
    }

    return null;
  }

  void _handleChange(BuildContext context, SelectedFile? oldFile) async {
    await onBeforePick?.call();

    final mode = await (popupDialogBuilder?.call(context, modes) ??
        widgetPopupDialog(context, modes));

    if (mode != null) {
      List<SelectedFile> result = await _onImageButtonPressed(context, mode);
      if(result.isEmpty) {
        return;
      }

      final index = value.indexWhere((e) => e == oldFile);

      if (index > -1) {
        result = [
          ...value.getRange(0, index),
          ...result,
          ...value.getRange(index + 1, value.length),
        ];
      }

      onChanged(result);
    }

    await onAfterPick?.call();
  }

  void _handleDeleteConfirm(SelectedFile oldFile) {
    List<SelectedFile> result = [...value];

    final index = value.indexWhere((e) => e == oldFile);

    if (index > -1) {
      result = [
        ...value.getRange(0, index),
        ...value.getRange(index + 1, value.length),
      ];
    }

    onChanged(result);
  }

  void _handleDelete(BuildContext context, SelectedFile file) async {
    if (deleteDialogBuilder != null) {
      await deleteDialogBuilder?.call(context, _handleDeleteConfirm);
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
                _handleDeleteConfirm(file);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildImage(BuildContext context) {
    return selectedValueBuilder?.call(
          value,
          _handleDelete,
          _handleChange,
        ) ??
        Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
            child: Column(
              children: value
                  .map(
                    (e) =>
                        selectedFileViewBuilder?.call(e) ??
                        SelectedFileView(
                          file: e,
                          mediaSize: mediaSize,
                          selectedImageBuilder: selectedImageBuilder,
                          selectedVideoBuilder: selectedVideoBuilder,
                          changeIcon: editIcon,
                          onChange: _handleChange,
                          deleteIcon: deleteIcon,
                          onDelete: _handleDelete,
                        ),
                  )
                  .toList(),
            ));
  }

  Widget _buildInput(BuildContext context) {
    return inputBuilder?.call(() => _handleChange(context, null)) ??
        OutlinedButton.icon(
          onPressed: () => _handleChange(context, null),
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
