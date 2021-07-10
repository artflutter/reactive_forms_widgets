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
                    'min': 'Please select',
                  };
                },
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
