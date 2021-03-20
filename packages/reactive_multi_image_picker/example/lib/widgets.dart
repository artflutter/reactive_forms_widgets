import 'package:example/sample_screen.dart';
import 'package:flutter/material.dart' hide ProgressIndicator;
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_multi_image_picker/reactive_multi_image_picker.dart';

class Widgets extends StatelessWidget {
  FormGroup buildForm() => fb.group({
        'multiImage': FormControl<List<Asset>>(value: []),
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
              Container(
                constraints: BoxConstraints(minHeight: 0, maxHeight: 300),
                child: ReactiveMultiImagePicker(
                  formControlName: 'multiImage',
                  decoration: const InputDecoration(
                    labelText: 'Multi image picker',
                    border: OutlineInputBorder(),
                    helperText: '',
                  ),
                ),
              ),
              SizedBox(height: 16),
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
