import 'package:example/sample_screen.dart';
import 'package:flutter/material.dart' hide ProgressIndicator;
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_macos_ui/reactive_macos_ui.dart';

class Widgets extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return SampleScreen(
      title: Text(''),
      body: ReactiveFormBuilder(
        form: buildForm,
        builder: (context, form, child) {
          return Column(
            children: [
              ReactiveRatingIndicator(
                formControlName: 'ratingIndicator',
                validationMessages: (_) {
                  return {
                    'min': 'Please select more than 1',
                  };
                },
              ),
              SizedBox(height: 16),
              ReactiveCapacityIndicator(
                formControlName: 'capacityIndicator',
                validationMessages: (_) {
                  return {
                    'min': 'Please select',
                  };
                },
              ),
              SizedBox(height: 16),
              ReactiveCapacityIndicator(
                formControlName: 'capacityIndicator',
                discrete: true,
                validationMessages: (_) {
                  return {
                    'min': 'Please select more than half',
                  };
                },
              ),
              SizedBox(height: 16),
              ReactiveMacosTextField<String>(
                formControlName: 'textField',
              ),
              SizedBox(height: 16),
              ReactiveMacosCheckbox(
                formControlName: 'checkbox',
              ),
              SizedBox(height: 16),
              ReactiveMacosRadioButton(
                formControlName: 'radio',
              ),
              SizedBox(height: 16),
              ReactiveMacosSwitch(
                formControlName: 'switch',
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
    );
  }
}
