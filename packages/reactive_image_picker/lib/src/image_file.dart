import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'image_file.freezed.dart';

@freezed
class SelectedFile with _$SelectedFile {
  SelectedFile._();

  factory SelectedFile.video({
    String? url,
    XFile? file,
  }) = SelectedFileVideo;

  factory SelectedFile.image({
    String? url,
    XFile? file,
  }) = SelectedFileImage;

  bool get isEmpty {
    return url == null && file == null;
  }

  bool get isNotEmpty {
    return !isEmpty;
  }
}
