import 'package:flutter/material.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'multi_file.dart';

typedef SelectFileCallback = Future<void> Function();
typedef FileSelectorChangeCallback<T> = void Function(MultiFile<T> files);
typedef FileSelectorBuilder<T> = Widget Function(
  SelectFileCallback pickFile,
  MultiFile<T> files,
  FileSelectorChangeCallback<T> onChange,
);

/// A [ReactiveFileSelector] that contains a [FileSelector].
///
/// This is a convenience widget that wraps a [FileSelector] widget in a
/// [ReactiveFileSelector].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveFileSelector<T> extends ReactiveFormField<MultiFile<T>, MultiFile<T>> {
  /// Creates a [ReactiveFileSelector].
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
  /// If [distinctPickedFiles] is true, it will attempt to remove duplicate picked files
  /// based on file name and mimeType, but you should proably provide a different implmentation
  /// based on md5 hash of file bytes during file upload/read
  ///
  /// Set [allowMultiple] to allow/disallow picking multiple files
  ///
  /// see more: [openFiles], [openFile]
  ///
  /// For documentation about the various parameters, see the [FileSelector] class
  /// and [FileSelector], the constructor.
  ReactiveFileSelector({
    super.key,
    super.formControlName,
    super.formControl,
    super.validationMessages,
    super.valueAccessor,
    super.showErrors,

    //////////////////////////////////////////////////////////////////////////
    InputDecoration? decoration,
    FileSelectorBuilder<T>? filePickerBuilder,
    List<XTypeGroup> acceptedTypeGroups = const [],
    String? confirmButtonText,
    String? initialDirectory,
    double disabledOpacity = 0.5,
    bool allowMultiple = false,
    bool distinctPickedFiles = false,
  }) : super(
          builder: (state) {
            final value = state.value ?? MultiFile<T>();
            final InputDecoration effectiveDecoration =
                (decoration ?? const InputDecoration()).applyDefaults(Theme.of(state.context).inputDecorationTheme);
            String? pickerError;
            Future<void> pickFile() async {
              List<XFile> pickedFiles = [];
              try {
                if (allowMultiple) {
                  pickedFiles = await openFiles(
                    acceptedTypeGroups: acceptedTypeGroups,
                    confirmButtonText: confirmButtonText,
                    initialDirectory: initialDirectory,
                  );
                } else {
                  final f = await openFile(
                    acceptedTypeGroups: acceptedTypeGroups,
                    confirmButtonText: confirmButtonText,
                    initialDirectory: initialDirectory,
                  );
                  if (f != null) {
                    pickedFiles.add(f);
                  }
                }
              } on PlatformException catch (e) {
                pickerError = "Unsupported operation $e";
              } catch (e) {
                pickerError = e.toString();
              }

              if (pickedFiles.isNotEmpty) {
                state.control.markAsTouched();

                final newPickedFiles = [
                  ...value.platformFiles,
                  ...pickedFiles,
                ];
                if (distinctPickedFiles) {
                  final newSet = <int>{};
                  newPickedFiles.retainWhere(
                    (element) {
                      return newSet.add(Object.hash(element.mimeType, element.name));
                    },
                  );
                }

                state.didChange(
                  value.copyWith(
                    platformFiles: newPickedFiles,
                  ),
                );
              }
            }

            return InputDecorator(
              decoration: effectiveDecoration.copyWith(
                errorText: state.errorText ?? pickerError,
                enabled: state.control.enabled,
              ),
              child: IgnorePointer(
                ignoring: !state.control.enabled,
                child: Opacity(
                  opacity: state.control.enabled ? 1 : disabledOpacity,
                  child: filePickerBuilder?.call(
                    pickFile,
                    value,
                    (files) {
                      state.control.markAsTouched();
                      state.didChange(files);
                    },
                  ),
                ),
              ),
            );
          },
        );
}
