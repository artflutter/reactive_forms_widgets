import 'package:example/sample_screen.dart';
import 'package:flutter/material.dart' hide ProgressIndicator;
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_touch_spin/reactive_touch_spin.dart';

class Widgets extends StatelessWidget {
  FormGroup buildForm() => fb.group({
        'touchSpin': FormControl<num>(value: 10),
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
              ReactiveTouchSpin(
                formControlName: 'touchSpin',
                min: 5,
                max: 100,
                step: 5,
                textStyle: const TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                  labelText: "Search amount",
                  helperText: '',
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
    );
  }
}
