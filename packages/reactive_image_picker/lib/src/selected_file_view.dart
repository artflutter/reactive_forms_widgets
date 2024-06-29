import 'package:flutter/material.dart';
import 'package:reactive_image_picker/src/image_file.dart';
import 'package:reactive_image_picker/src/image_view.dart';
import 'package:reactive_image_picker/src/video_view.dart';

typedef OnChange = void Function(BuildContext context, SelectedFile file);
typedef OnDelete = void Function(BuildContext context, SelectedFile file);

typedef SelectedImageBuilder = Widget Function(SelectedFileImage file);
typedef SelectedVideoBuilder = Widget Function(SelectedFileVideo file);

class SelectedFileView extends StatelessWidget {
  final SelectedFile file;
  final SelectedImageBuilder? selectedImageBuilder;
  final SelectedVideoBuilder? selectedVideoBuilder;
  final Widget? changeIcon;
  final OnChange onChange;
  final Widget? deleteIcon;
  final OnDelete onDelete;
  final Size? mediaSize;

  const SelectedFileView({
    super.key,
    required this.file,
    required this.onChange,
    required this.onDelete,
    required this.changeIcon,
    required this.deleteIcon,
    this.selectedImageBuilder,
    this.mediaSize,
    this.selectedVideoBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox.fromSize(
          size: mediaSize ?? const Size(double.infinity, 250),
          child: file.map(
            video: (v) => selectedVideoBuilder?.call(v) ?? VideoView(video: v),
            image: (i) => selectedImageBuilder?.call(i) ?? ImageView(image: i),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
              onPressed: () => onChange(context, file),
              icon: changeIcon ?? const Icon(Icons.edit),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: () => onDelete(context, file),
              icon: deleteIcon ?? const Icon(Icons.delete),
            )
          ],
        )
      ],
    );
  }
}
