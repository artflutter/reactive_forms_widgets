import 'package:collection/collection.dart';
import 'package:file_selector/file_selector.dart';

class MultiFile<T> {
  final List<T> files;
  final List<XFile> platformFiles;

  const MultiFile({
    this.files = const [],
    this.platformFiles = const [],
  });

  MultiFile<T> copyWith({
    List<T>? files,
    List<XFile>? platformFiles,
  }) =>
      MultiFile<T>(
        files: files ?? this.files,
        platformFiles: platformFiles ?? this.platformFiles,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is MultiFile<T> && listEquals(other.files, files) && listEquals(other.platformFiles, platformFiles);
  }

  @override
  int get hashCode => files.hashCode ^ platformFiles.hashCode;

  @override
  String toString() => 'MultiFile(files: $files, platformFiles: $platformFiles)';
}
