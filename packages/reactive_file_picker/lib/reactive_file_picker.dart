library;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_file_picker/multi_file.dart';
import 'package:reactive_forms/reactive_forms.dart';

export 'package:reactive_file_picker/multi_file.dart';
export 'package:file_picker/file_picker.dart';

typedef PickFileCallback = Future<void> Function();
typedef FilePickerChangeCallback<T> = void Function(MultiFile<T> files);

typedef FilePickerBuilder<T> = Widget Function(
  PickFileCallback pickImage,
  MultiFile<T> files,
  FilePickerChangeCallback<T> onChange,
);

/// A [ReactiveFilePicker] that contains a [FilePicker].
///
/// This is a convenience widget that wraps a [FilePicker] widget in a
/// [ReactiveFilePicker].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveFilePicker<T>
    extends ReactiveFormField<MultiFile<T>, MultiFile<T>> {
  /// Creates a [ReactiveFilePicker] that contains a [FilePicker].
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
  /// ReactiveFilePicker(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveFilePicker(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveFilePicker(
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
  /// ReactiveFilePicker(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [FilePicker] class
  /// and [FilePicker], the constructor.
  ReactiveFilePicker({
    super.key,
    super.formControlName,
    super.formControl,
    super.validationMessages,
    super.valueAccessor,
    super.showErrors,

    ////////////////////////////////////////////////////////////////////////////
    InputDecoration? decoration,
    FilePickerBuilder<T>? filePickerBuilder,
    String? dialogTitle,
    bool allowMultiple = false,
    FileType type = FileType.any,
    List<String>? allowedExtensions,
    Function(FilePickerStatus)? onFileLoading,
    int compressionQuality = 0,
    bool withData = false,
    bool withReadStream = false,
    bool lockParentWindow = false,
    double disabledOpacity = 0.5,
    String? initialDirectory,
    Widget Function(BuildContext context, String error)? errorBuilder,

    // input decorator props
    TextStyle? baseStyle,
    TextAlign? textAlign,
    TextAlignVertical? textAlignVertical,
    bool expands = false,
    MouseCursor cursor = SystemMouseCursors.basic,
  }) : super(
          builder: (field) {
            final value = field.value ?? MultiFile<T>();
            final InputDecoration effectiveDecoration = (decoration ??
                    const InputDecoration())
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);

            String? pickerError;

            pickFile() async {
              List<PlatformFile> platformFiles = [];
              try {
                platformFiles = ((await FilePicker.platform.pickFiles(
                      initialDirectory: initialDirectory,
                      dialogTitle: dialogTitle,
                      allowMultiple: allowMultiple,
                      type: type,
                      allowedExtensions: allowedExtensions,
                      onFileLoading: onFileLoading,
                      compressionQuality: compressionQuality,
                      withData: withData,
                      withReadStream: withReadStream,
                      lockParentWindow: lockParentWindow,
                    ))
                        ?.files) ??
                    [];
              } on PlatformException catch (e) {
                pickerError = "Unsupported operation $e";
              } catch (e) {
                pickerError = e.toString();
              }

              if (platformFiles.isNotEmpty) {
                field.control.markAsTouched();
                field.didChange(
                  value.copyWith(
                    platformFiles: [
                      ...value.platformFiles,
                      ...platformFiles,
                    ],
                  ),
                );
              }
            }

            final errorText = field.errorText;

            final isEmptyValue = field.value == null ||
                (field.value?.platformFiles.isEmpty == true &&
                    field.value?.files.isEmpty == true);

            return IgnorePointer(
              ignoring: !field.control.enabled,
              child: MouseRegion(
                cursor: cursor,
                child: HoverBuilder(builder: (context, isHovered) {
                  return InputDecorator(
                    isHovering: isHovered,
                    baseStyle: baseStyle,
                    textAlign: textAlign,
                    textAlignVertical: textAlignVertical,
                    expands: expands,
                    isEmpty: isEmptyValue,
                    decoration: effectiveDecoration.copyWith(
                      enabled: field.control.enabled,
                      errorText: errorBuilder == null
                          ? field.errorText ?? pickerError
                          : null,
                      error: errorBuilder != null && errorText != null
                          ? DefaultTextStyle.merge(
                              style: Theme.of(field.context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: Theme.of(field.context)
                                        .colorScheme
                                        .error,
                                  )
                                  .merge(effectiveDecoration.errorStyle),
                              child: errorBuilder.call(
                                field.context,
                                errorText,
                              ),
                            )
                          : null,
                    ),
                    child: Opacity(
                      opacity: field.control.enabled ? 1 : disabledOpacity,
                      child: filePickerBuilder?.call(pickFile, value, (files) {
                        field.control.markAsTouched();
                        field.didChange(files);
                      }),
                    ),
                  );
                }),
              ),
            );
          },
        );
}

class HoverBuilder extends StatefulWidget {
  const HoverBuilder({
    required this.builder,
    super.key,
  });

  final Widget Function(BuildContext context, bool isHovered) builder;

  @override
  State<HoverBuilder> createState() => _HoverBuilderState();
}

class _HoverBuilderState extends State<HoverBuilder> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => _onHoverChanged(enabled: true),
      onExit: (event) => _onHoverChanged(enabled: false),
      child: widget.builder(context, _isHovered),
    );
  }

  void _onHoverChanged({required bool enabled}) {
    setState(() {
      _isHovered = enabled;
    });
  }
}
