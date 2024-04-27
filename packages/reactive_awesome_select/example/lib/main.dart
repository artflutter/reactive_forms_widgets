import 'package:flutter/material.dart';
import 'package:reactive_awesome_select/reactive_awesome_select.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'choices.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  FormGroup buildForm() => fb.group({
        'input': FormControl<String>(
          value: null,
          validators: [Validators.required],
        ),
        'inputMultiple': FormControl<List<String>>(value: null),
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
                    ReactiveSmartSelectSingle<String, String>(
                      formControlName: 'input',
                      title: 'Day selector',
                      choiceItems: days,
                    ),
                    const Text('data'),
                    ReactiveSmartSelectMultiple<String, String>(
                      formControlName: 'inputMultiple',
                      title: 'Fruit',
                      choiceItems: fruits,
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
