import 'package:file_picker/file_picker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'multi_file.freezed.dart';

@freezed
class MultiFile<T> with _$MultiFile<T> {
  const MultiFile._();

  const factory MultiFile({
    @Default([]) List<T> files,
    @Default([]) List<PlatformFile> platformFiles,
  }) = _MultiFile<T>;

  factory MultiFile.fromFiles(List<T?>? files) => MultiFile(
        files: (files ?? []).whereType<T>().toList(),
      );
  factory MultiFile.fromFile(T? file) => MultiFile(
        files: [file].whereType<T>().toList(),
      );
}
