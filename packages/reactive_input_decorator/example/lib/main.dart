import 'package:flutter/material.dart';
import 'package:reactive_input_decorator/reactive_input_decorator.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  FormGroup buildForm() => fb.group({
        'input': FormControl<bool>(
          value: null,
          validators: [const RequiredValidator()],
        ),
      });

  @override
  Widget build(BuildContext context) {
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
            child: ReactiveFormBuilder(
              form: buildForm,
              builder: (context, form, child) {
                return Column(
                  children: [
                    ReactiveInputDecorator(
                      formControlName: 'input',
                      errorBuilder: (_, text) => Text('$text+'),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        isCollapsed: true,
                        helperText: "",
                        helperStyle: TextStyle(height: 0.8),
                        errorStyle: TextStyle(height: 0.8),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 16),
                          const Expanded(child: Text('Some label')),
                          ReactiveCheckbox(formControlName: 'input'),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      child: const Text('Submit'),
                      onPressed: () {
                        if (form.valid) {
                          debugPrint(form.value.toString());
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
