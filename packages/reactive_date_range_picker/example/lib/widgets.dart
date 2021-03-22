import 'package:example/sample_screen.dart';
import 'package:flutter/material.dart' hide ProgressIndicator;
import 'package:reactive_date_range_picker/reactive_date_range_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';

class Widgets extends StatelessWidget {
  FormGroup buildForm() => fb.group({
        'dateRange': FormControl<DateTimeRange>(),
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
              ReactiveDateRangePicker(
                formControlName: 'dateRange',
                decoration: const InputDecoration(
                  labelText: 'Date range',
                  border: OutlineInputBorder(),
                  helperText: '',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
              ),
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
