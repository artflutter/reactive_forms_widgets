import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

part 'multi_image.freezed.dart';

@freezed
class MultiImage<T> with _$MultiImage<T> {
  const MultiImage._();

  const factory MultiImage({
    @Default([]) List<T> images,
    @Default([]) List<Asset> assets,
  }) = _MultiImage;
}
