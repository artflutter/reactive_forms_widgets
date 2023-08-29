import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_file.freezed.dart';

@freezed
class SelectedFile with _$SelectedFile {
  SelectedFile._();

  factory SelectedFile.video({
    String? url,
    File? file,
  }) = SelectedFileVideo;

  factory SelectedFile.image({
    String? url,
    File? file,
  }) = SelectedFileImage;

  bool get isEmpty {
    return url == null && file == null;
  }

  bool get isNotEmpty {
    return !isEmpty;
  }
}
