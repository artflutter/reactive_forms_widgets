import 'package:example/sample_screen.dart';
import 'package:flutter/material.dart' hide ProgressIndicator;
import 'package:reactive_cupertino_text_field/reactive_cupertino_text_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

class Widgets extends StatelessWidget {
  FormGroup buildForm() => fb.group({
        'input': FormControl<String>(value: 'asdfg'),
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
              ReactiveCupertinoTextField(
                formControlName: 'input',
                inputDecoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
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
