import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_macos_ui/reactive_macos_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  FormGroup buildForm() => fb.group({
        'ratingIndicator': FormControl<double>(
          value: 0,
          validators: [Validators.min(1)],
        ),
        'capacityIndicator': FormControl<double>(
          value: 0,
          validators: [Validators.min(50)],
        ),
        'textField': FormControl<String>(
          value: null,
          validators: [Validators.required],
        ),
        'checkbox': FormControl<bool>(
          value: null,
        ),
        'radio': FormControl<bool>(
          value: null,
        ),
        'switch': FormControl<bool>(
          value: true,
        ),
      });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MacosApp(
      title: 'macos_ui example',
      theme: MacosThemeData.light().copyWith(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: MacosThemeData.dark().copyWith(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
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
                    ReactiveRatingIndicator<double>(
                      formControlName: 'ratingIndicator',
                      validationMessages: (_) {
                        return {
                          'min': 'Please select more than 1',
                        };
                      },
                    ),
                    const SizedBox(height: 16),
                    ReactiveCapacityIndicator<double>(
                      formControlName: 'capacityIndicator',
                      validationMessages: (_) {
                        return {
                          'min': 'Please select',
                        };
                      },
                    ),
                    const SizedBox(height: 16),
                    ReactiveCapacityIndicator<double>(
                      formControlName: 'capacityIndicator',
                      discrete: true,
                      validationMessages: (_) {
                        return {
                          'min': 'Please select more than half',
                        };
                      },
                    ),
                    const SizedBox(height: 16),
                    ReactiveMacosTextField<String>(
                      formControlName: 'textField',
                    ),
                    const SizedBox(height: 16),
                    ReactiveMacosCheckbox<bool>(
                      formControlName: 'checkbox',
                    ),
                    const SizedBox(height: 16),
                    ReactiveMacosRadioButton<bool, bool>(
                      formControlName: 'radio',
                      value: true,
                    ),
                    ReactiveMacosRadioButton<bool, bool>(
                      formControlName: 'radio',
                      value: false,
                    ),
                    const SizedBox(height: 16),
                    ReactiveMacosSwitch<bool>(
                      formControlName: 'switch',
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
