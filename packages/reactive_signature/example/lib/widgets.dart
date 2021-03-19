import 'dart:typed_data';

import 'package:example/sample_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ProgressIndicator;
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_signature/reactive_signature.dart';

class Widgets extends StatelessWidget {
  FormGroup buildForm() => fb.group({
        'signature': FormControl<Uint8List>(),
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
              ReactiveSignature(
                // width: 200,
                height: 200,
                backgroundColor: Colors.grey,
                formControlName: 'signature',
                decoration: const InputDecoration(
                  labelText: 'Signature',
                  border: OutlineInputBorder(),
                  helperText: '',
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
