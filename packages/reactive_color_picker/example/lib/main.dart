import 'package:flutter/material.dart';
import 'package:reactive_color_picker/reactive_color_picker.dart';

import 'package:reactive_forms/reactive_forms.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  FormGroup buildForm() => fb.group({
        'input': FormControl<Color>(),
        'inputList': FormControl<List<Color>>(),
        'material': FormControl<Color>(value: Colors.amber),
        'colorPicker': FormControl<Color>(value: Colors.red),
        'sliderColorPicker': FormControl<Color>(value: Colors.lime),
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
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
                    SizedBox(height: 16),
                    ReactiveBlockColorPicker<Color>(
                      formControlName: 'input',
                    ),
                    SizedBox(height: 16),
                    ReactiveMultipleBlockColorPicker<List<Color>>(
                      formControlName: 'inputList',
                    ),
                    SizedBox(height: 16),
                    ReactiveMaterialColorPicker<Color>(
                      formControlName: 'material',
                    ),
                    SizedBox(height: 16),
                    ReactiveColorPicker<Color>(
                      formControlName: 'colorPicker',
                    ),
                    SizedBox(height: 16),
                    ReactiveSliderColorPicker<Color>(
                      formControlName: 'sliderColorPicker',
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
    );
  }
}
