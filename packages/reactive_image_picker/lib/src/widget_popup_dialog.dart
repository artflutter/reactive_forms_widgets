import 'package:flutter/material.dart';
import 'package:reactive_image_picker/src/reactive_image_picker.dart';

Future<ImagePickerMode?> widgetPopupDialog(
  BuildContext context,
  List<ImagePickerMode> mode,
) async {
  return await showModalBottomSheet<ImagePickerMode>(
    isScrollControlled: true,
    context: context,
    builder: (context) => Row(
      children: <Widget>[
        Expanded(
            flex: 3,
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  if (mode.contains(ImagePickerMode.cameraImage))
                    ListTile(
                      leading: const Icon(Icons.photo_camera),
                      title: const Text('Take photo'),
                      onTap: () => Navigator.of(context).pop(
                        ImagePickerMode.cameraImage,
                      ),
                    ),
                  if (mode.contains(ImagePickerMode.galleryImage))
                    ListTile(
                      leading: const Icon(Icons.photo),
                      title: const Text('Choose from library'),
                      onTap: () => Navigator.of(context).pop(
                        ImagePickerMode.galleryImage,
                      ),
                    ),
                  if (mode.contains(ImagePickerMode.galleryMultiImage))
                    ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Choose multiple from library'),
                      onTap: () => Navigator.of(context).pop(
                        ImagePickerMode.galleryMultiImage,
                      ),
                    ),
                  if (mode.contains(ImagePickerMode.cameraVideo))
                    ListTile(
                      leading: const Icon(Icons.videocam),
                      title: const Text('Take video'),
                      onTap: () {
                        Navigator.of(context).pop(
                          ImagePickerMode.cameraVideo,
                        );
                      },
                    ),
                  if (mode.contains(ImagePickerMode.galleryVideo))
                    ListTile(
                      leading: const Icon(Icons.video_library),
                      title: const Text('Pick Video from gallery'),
                      onTap: () {
                        Navigator.of(context).pop(
                          ImagePickerMode.galleryVideo,
                        );
                      },
                    ),
                  ListTile(
                    leading: const Icon(Icons.clear),
                    title: const Text('Cancel'),
                    onTap: Navigator.of(context).pop,
                  )
                ],
              ),
            )),
      ],
    ),
  );
}
