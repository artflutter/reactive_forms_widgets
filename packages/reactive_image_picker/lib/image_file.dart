import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_file.freezed.dart';

@freezed
class ImageFile with _$ImageFile {
  const ImageFile._();

  const factory ImageFile({
    String? imageUrl,
    String? localImage,
    File? image,
  }) = _ImageFile;

  bool get isEmpty {
    return imageUrl == null && localImage == null && image == null;
  }

  bool get isNotEmpty {
    return !isEmpty;
  }
}
