// ignore_for_file: use_build_context_synchronously

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_image_picker/reactive_image_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<void> _photoDenied(BuildContext context) async =>
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Photo access required'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    'Open settings to allow access',
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: const Text('Settings'),
                onPressed: () async {
                  await AppSettings.openAppSettings();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );

  Future<void> _cameraDenied(BuildContext context) async =>
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Camera access required'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    'Open settings to allow access',
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: const Text('Settings'),
                onPressed: () async {
                  await AppSettings.openAppSettings();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    FormGroup buildForm() => fb.group({
          'input': FormControl<List<SelectedFile>>(validators: [
            Validators.required,
          ]),
        });

    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 20.0,
              ),
              child: SafeArea(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 20.0,
                  ),
                  child: ReactiveFormBuilder(
                    form: buildForm,
                    builder: (context, form, child) {
                      return Column(
                        children: [
                          ReactiveImagePicker(
                            formControlName: 'input',
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                labelText: 'Image',
                                filled: false,
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                helperText: ''),
                            preprocessError: (e) async {
                              if (e is PlatformException) {
                                switch (e.code) {
                                  case 'photo_access_denied':
                                    await _photoDenied(context);
                                    break;
                                  case 'camera_access_denied':
                                    await _cameraDenied(context);
                                    break;
                                }
                              }
                            },
                            selectedValueBuilder:
                                (context, value, _, handleChange) {
                              return Wrap(
                                runSpacing: 24,
                                spacing: 24,
                                children: value
                                    .map(
                                      (selectedFile) => switch (selectedFile) {
                                        SelectedFileVideo() => Text("video"),
                                        SelectedFileImage() => SizedBox.square(
                                            dimension: 50,
                                            child: InkWell(
                                                onTap: () {
                                                  handleChange(
                                                    context,
                                                    null,
                                                  );
                                                },
                                                child: ImageView(
                                                    image: selectedFile))),
                                      },
                                    )
                                    .toList()
                                  ..add(IconButton(
                                    style: IconButton.styleFrom(
                                      minimumSize: Size.square(50),
                                    ),
                                    onPressed: () => handleChange(
                                      context,
                                      null,
                                    ),
                                    icon: const Icon(Icons.read_more),
                                  )),
                              );
                            },
                            inputBuilder: (onPressed) => Center(
                              child: IconButton(
                                style: IconButton.styleFrom(
                                  minimumSize: Size.square(100),
                                ),
                                onPressed: onPressed,
                                icon: const Icon(Icons.read_more),
                              ),
                            ),
                            // TextButton.icon(
                            //   onPressed: onPressed,
                            //   icon: const Icon(Icons.add),
                            //   label: const Text('Add an image'),
                            // ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            child: const Text('Sign Up'),
                            onPressed: () {
                              if (form.valid) {
                                // ignore: avoid_print
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
            ),
          ),
        ));
  }
}
