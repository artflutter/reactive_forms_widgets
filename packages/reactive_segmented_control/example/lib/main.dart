import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_segmented_control/reactive_segmented_control.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  FormGroup buildForm() => fb.group({
        'input': FormControl<String>(value: 'a'),
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
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
                    ReactiveSegmentedControl<String, String>(
                      decoration: const InputDecoration(
                        labelText: 'Rating',
                        border: OutlineInputBorder(),
                        helperText: '',
                      ),
                      padding: const EdgeInsets.all(0),
                      formControlName: 'input',
                      children: const {
                        'a': Text('A'),
                        'b': Text('B'),
                        'c': Text('C'),
                      },
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
