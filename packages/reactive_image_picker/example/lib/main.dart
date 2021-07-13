import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_image_picker/image_file.dart';
import 'package:reactive_image_picker/reactive_image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FormGroup buildForm() => fb.group({
          'input': FormControl<ImageFile>(),
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
              physics: BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 20.0,
              ),
              child: SafeArea(
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
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
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                labelText: 'Image',
                                filled: false,
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                helperText: ''),
                            inputBuilder: (onPressed) => TextButton.icon(
                              onPressed: onPressed,
                              icon: Icon(Icons.add),
                              label: Text('Add an image'),
                            ),
                          ),
                          SizedBox(height: 16),
                          ElevatedButton(
                            child: Text('Sign Up'),
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
            ),
          ),
        ));
  }
}
