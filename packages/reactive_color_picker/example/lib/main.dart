import 'package:flutter/material.dart';
import 'package:reactive_color_picker/reactive_color_picker.dart';

import 'package:reactive_forms/reactive_forms.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  FormGroup buildForm() => fb.group({
        'input': FormControl<Color>(),
        'inputDisabled': FormControl<Color>(disabled: true),
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
                    const SizedBox(height: 16),
                    ReactiveBlockColorPicker<Color>(
                      formControlName: 'input',
                    ),
                    const SizedBox(height: 16),
                    ReactiveBlockColorPicker<Color>(
                      formControlName: 'inputDisabled',
                    ),
                    const SizedBox(height: 16),
                    ReactiveMultipleBlockColorPicker<List<Color>>(
                      formControlName: 'inputList',
                    ),
                    const SizedBox(height: 16),
                    ReactiveMaterialColorPicker<Color>(
                      formControlName: 'material',
                    ),
                    const SizedBox(height: 16),
                    ReactiveColorPicker<Color>(
                      formControlName: 'colorPicker',
                      enableAlpha: false,
                    ),
                    const SizedBox(height: 16),
                    ReactiveSliderColorPicker<Color>(
                      formControlName: 'sliderColorPicker',
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
    );
  }
}
