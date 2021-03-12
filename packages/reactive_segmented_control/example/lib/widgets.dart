import 'package:example/sample_screen.dart';
import 'package:flutter/material.dart' hide ProgressIndicator;
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_segmented_control/reactive_segmented_control.dart';

class Widgets extends StatelessWidget {
  FormGroup buildForm() => fb.group({
        'rate': FormControl<String>(value: 'a'),
      });

  @override
  Widget build(BuildContext context) {
    return SampleScreen(
      title: Text('Dropdown sample'),
      body: ReactiveFormBuilder(
        form: buildForm,
        builder: (context, form, child) {
          return Column(
            children: [
              ReactiveSegmentedControl(
                decoration: const InputDecoration(
                  labelText: 'Rating',
                  border: OutlineInputBorder(),
                  helperText: '',
                ),
                padding: EdgeInsets.all(0),
                formControlName: 'rate',
                children: {
                  'a': Text('A'),
                  'b': Text('B'),
                  'c': Text('C'),
                },
              ),
              RaisedButton(
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
