import 'package:reactive_forms/reactive_forms.dart';

import 'multi_file.dart';

class FileSelectorValidators {
  static Validator<MultiFile<dynamic>> limit({int? min, int? max}) => _FileSelectorGeneralValidator(min: min, max: max);
}

final x = Validators.required;

class _FileSelectorGeneralValidator extends Validator<MultiFile<dynamic>> {
  final int? min;
  final int? max;

  const _FileSelectorGeneralValidator({this.min, this.max});

  @override
  Map<String, Object?>? validate(AbstractControl<dynamic> control) {
    final Object? value = control.value;

    if (value == null) return null;

    assert(value is MultiFile,
        "The limit validator is expecting a control of type `MultiFile`, but received a control of type ${control.value.runtimeType}");
    if (value is! MultiFile) {
      return null;
    }

    final totalFilesCount = value.files.length + value.platformFiles.length;
    final minCpy = min;
    if (minCpy != null) {
      if (totalFilesCount < minCpy) {
        return <String, Object?>{
          ValidationMessage.min: <String, Object?>{
            'min': minCpy,
            'actual': totalFilesCount,
          }
        };
      }
    }
    final maxCpy = max;
    if (maxCpy != null) {
      if (totalFilesCount > maxCpy) {
        return <String, Object?>{
          ValidationMessage.max: <String, Object?>{
            'max': maxCpy,
            'actual': totalFilesCount,
          }
        };
      }
    }
    return null;
  }
}
