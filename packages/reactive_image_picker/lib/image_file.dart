import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reactive_image_picker/reactive_image_picker.dart';

part 'image_file.freezed.dart';

@freezed
class ImageFile with _$ImageFile {
  const ImageFile._();

  const factory ImageFile({
    String? imageUrl,
    String? localImage,
    File? image,
    XFile? xFile,
  }) = _ImageFile;

  bool get isEmpty {
    return imageUrl == null &&
        localImage == null &&
        image == null &&
        xFile == null;
  }

  bool get isNotEmpty {
    return !isEmpty;
  }
}
