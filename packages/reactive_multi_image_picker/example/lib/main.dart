import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_multi_image_picker/multi_image.dart';
import 'package:reactive_multi_image_picker/reactive_multi_image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  FormGroup buildForm() => fb.group({
        'multiImage': FormControl<MultiImage<String>>(
          value: const MultiImage<String>(
            images: [
              'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__340.jpg'
            ],
            assets: [],
          ),
        ),
      });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: ReactiveFormBuilder(
            form: buildForm,
            builder: (context, form, child) {
              return Column(
                children: [
                  Container(
                    constraints:
                        const BoxConstraints(minHeight: 0, maxHeight: 300),
                    child: ReactiveMultiImagePicker<String>(
                      formControlName: 'multiImage',
                      imagePickerBuilder: (pickImage, images, onChange) {
                        final items = [
                          ...images.images
                              .asMap()
                              .map((key, value) => MapEntry(
                                  key,
                                  Stack(
                                    children: [
                                      ImageListItem(value).build(context),
                                      Positioned.fill(
                                        child: InkWell(
                                          onTap: () => onChange(images.copyWith(
                                              images: List<String>.from(
                                                  images.images)
                                                ..removeAt(key))),
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  )))
                              .values,
                          ...images.assets
                              .asMap()
                              .map((key, value) => MapEntry(
                                  key,
                                  Stack(
                                    children: [
                                      AssetListItem(value).build(context),
                                      Positioned.fill(
                                        child: InkWell(
                                          onTap: () => onChange(images.copyWith(
                                              assets: List<Asset>.from(
                                                  images.assets)
                                                ..removeAt(key))),
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  )))
                              .values,
                        ];

                        return Column(
                          children: [
                            Expanded(
                              child: GridView.count(
                                crossAxisCount: 3,
                                children: List.generate(items.length, (index) {
                                  return items[index];
                                }),
                              ),
                            ),
                            ElevatedButton(
                              child: const Text("Pick images"),
                              onPressed: pickImage,
                            ),
                          ],
                        );
                      },
                      decoration: const InputDecoration(
                        labelText: 'Multi image picker',
                        border: OutlineInputBorder(),
                        helperText: '',
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    child: const Text('Sign Up'),
                    onPressed: () {
                      if (form.valid) {
                        print(form.value);
                      } else {
                        form.markAllAsTouched();
                      }
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

abstract class ListItem {
  Widget build(BuildContext context);
}

class ImageListItem extends ListItem {
  final String url;

  ImageListItem(this.url);

  @override
  Widget build(context) {
    return SizedBox(
      height: 300,
      width: 300,
      child: Image.network(url),
    );
  }
}

class AssetListItem extends ListItem {
  final Asset asset;

  AssetListItem(this.asset);

  @override
  Widget build(context) {
    return AssetThumb(asset: asset, width: 300, height: 300);
  }
}
