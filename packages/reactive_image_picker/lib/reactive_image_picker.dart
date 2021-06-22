library reactive_image_picker;

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';

export 'package:image_picker/image_picker.dart';

import 'image_file.dart';

typedef Widget ImageViewBuilder(ImageFile image);

typedef Widget InputButtonBuilder(VoidCallback onPressed);

typedef void ErrorPickBuilder(ImageSource source, {BuildContext context});

typedef void DeleteDialogBuilder(BuildContext context, VoidCallback onConfirm);

typedef void PopupDialogBuilder(
  BuildContext context,
  ImagePickCallback pickImage,
);

typedef Future<ImageFile> OnBeforeChangeCallback(
    BuildContext context, ImageFile image);

typedef void ImagePickCallback(BuildContext context, ImageSource source);

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
  /// and [new ImagePicker], the constructor.
  ReactiveImagePicker({
    Key? key,
    String? formControlName,
    InputDecoration? decoration,
    InputButtonBuilder? inputBuilder,
    ImageViewBuilder? imageViewBuilder,
    DeleteDialogBuilder? deleteDialogBuilder,
    ErrorPickBuilder? errorPickBuilder,
    PopupDialogBuilder? popupDialogBuilder,
    BoxDecoration? imageContainerDecoration,
    OnBeforeChangeCallback? onBeforeChange,
    Widget? editIcon,
    Widget? deleteIcon,
    FormControl<ImageFile>? formControl,
    ValidationMessagesFunction<ImageFile>? validationMessages,
    ControlValueAccessor<ImageFile, ImageFile>? valueAccessor,
    ShowErrorsFunction? showErrors,
    bool enabled = true,
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          valueAccessor: valueAccessor,
          validationMessages: (control) {
            final error = validationMessages?.call(control) ?? {};

            if (error.containsKey(ImageSource.camera.toString()) != true) {
              error.addEntries([
                MapEntry(ImageSource.camera.toString(),
                    'Error while taking image from camera')
              ]);
            }

            if (error.containsKey(ImageSource.gallery.toString()) != true) {
              error.addEntries([
                MapEntry(ImageSource.gallery.toString(),
                    'Error while taking image from gallery')
              ]);
            }

            return error;
          },
          showErrors: showErrors,
          builder: (field) {
            final InputDecoration effectiveDecoration = (decoration ??
                    const InputDecoration())
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);

            return Listener(
              onPointerDown: (_) => field.control.markAsTouched(),
              child: ImagePickerWidget(
                imageViewBuilder: imageViewBuilder,
                popupDialogBuilder: popupDialogBuilder,
                onBeforeChange: onBeforeChange,
                errorPickBuilder: errorPickBuilder ??
                    (source, {BuildContext? context}) {
                      if (source == ImageSource.camera) {
                        field.control.setErrors(<String, Object>{
                          ImageSource.camera.toString(): true,
                        });
                      }

                      if (source == ImageSource.gallery) {
                        field.control.setErrors(<String, Object>{
                          ImageSource.gallery.toString(): true,
                        });
                      }
                    },
                inputBuilder: inputBuilder,
                imageContainerDecoration: imageContainerDecoration,
                deleteDialogBuilder: deleteDialogBuilder,
                editIcon: editIcon,
                deleteIcon: deleteIcon,
                decoration:
                    effectiveDecoration.copyWith(errorText: field.errorText),
                onChanged: field.didChange,
                value: field.value ?? ImageFile(),
              ),
            );
          },
        );
}

class ImagePickerWidget extends StatelessWidget {
  final InputDecoration decoration;
  final OnBeforeChangeCallback? onBeforeChange;
  final BoxDecoration? imageContainerDecoration;
  final Widget? editIcon;
  final Widget? deleteIcon;
  final InputButtonBuilder? inputBuilder;
  final ImageViewBuilder? imageViewBuilder;
  final DeleteDialogBuilder? deleteDialogBuilder;
  final ErrorPickBuilder? errorPickBuilder;
  final PopupDialogBuilder? popupDialogBuilder;
  final ImageFile value;
  final bool enabled;
  final ValueChanged<ImageFile?> onChanged;

  const ImagePickerWidget({
    Key? key,
    required this.value,
    this.enabled = true,
    required this.onChanged,
    required this.decoration,
    this.imageViewBuilder,
    this.inputBuilder,
    this.imageContainerDecoration,
    this.editIcon,
    this.deleteIcon,
    this.deleteDialogBuilder,
    this.errorPickBuilder,
    this.popupDialogBuilder,
    this.onBeforeChange,
  }) : super(key: key);

  void _onImageButtonPressed(BuildContext context, ImageSource source) async {
    final picker = ImagePicker();

    try {
      final pickedFile = await picker.getImage(source: source);

      if (pickedFile != null) {
        final imageFile = value.copyWith(image: File(pickedFile.path));

        onChanged(await onBeforeChange?.call(context, imageFile) ??
            await _onBeforeChange(imageFile));
      }
    } catch (e) {
      errorPickBuilder?.call(source, context: context);
    }
  }

  Future<ImageFile> _onBeforeChange(ImageFile image) => Future.value(image);

  void _buildPopupMenu(BuildContext context) {
    if (popupDialogBuilder != null) {
      popupDialogBuilder?.call(context, _onImageButtonPressed);
      return;
    }

    showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (context) => Row(
        children: <Widget>[
          Expanded(
              flex: 3,
              child: Container(
                child: SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.photo_camera),
                        title: Text('Take photo'),
                        onTap: () {
                          Navigator.of(context).pop();
                          _onImageButtonPressed(
                            context,
                            ImageSource.camera,
                          );
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.photo),
                        title: Text('Choose from library'),
                        onTap: () {
                          Navigator.of(context).pop();
                          _onImageButtonPressed(
                            context,
                            ImageSource.gallery,
                          );
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.clear),
                        title: Text('Cancel'),
                        onTap: Navigator.of(context).pop,
                      )
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  void _handleDelete(BuildContext context) {
    final onConfirm = () => onChanged(null);

    if (deleteDialogBuilder != null) {
      deleteDialogBuilder?.call(context, onConfirm);
      return;
    }

    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete image"),
          content: Text("This action could not be undone"),
          actions: [
            TextButton(
              child: Text("CLOSE"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text("CONFIRM"),
              onPressed: () {
                onConfirm();
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          imageViewBuilder?.call(value) ??
              Container(
                height: 250,
                child: _ImageView(image: value),
              ),
          if (enabled)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  onPressed: () => _buildPopupMenu(context),
                  icon: editIcon ?? Icon(Icons.edit),
                ),
                SizedBox(width: 8),
                IconButton(
                  onPressed: () => _handleDelete(context),
                  icon: deleteIcon ?? Icon(Icons.delete),
                )
              ],
            )
        ],
      ),
    );
  }

  Widget _buildInput(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () => _buildPopupMenu(context),
      icon: Icon(Icons.add, color: Color(0xFF00A7E1)),
      label: Text('Pick image'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: decoration,
      child: value.isNotEmpty == true
          ? _buildImage(context)
          : inputBuilder?.call(() => _buildPopupMenu(context)) ??
              _buildInput(context),
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
