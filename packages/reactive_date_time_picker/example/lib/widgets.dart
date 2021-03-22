import 'package:example/sample_screen.dart';
import 'package:flutter/material.dart' hide ProgressIndicator;
import 'package:reactive_date_time_picker/reactive_date_time_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';

class Widgets extends StatelessWidget {
  FormGroup buildForm() => fb.group({
        'date': FormControl<DateTime>(value: DateTime.now()),
        'time': FormControl<DateTime>(value: DateTime.now()),
        'dateTime': FormControl<DateTime>(value: DateTime.now()),
      });

  @override
  Widget build(BuildContext context) {
    return SampleScreen(
      body: ReactiveFormBuilder(
        form: buildForm,
        builder: (context, form, child) {
          return Column(
            children: [
              SizedBox(height: 8),
              ReactiveDateTimePicker(
                formControlName: 'date',
                decoration: const InputDecoration(
                  labelText: 'Date',
                  border: OutlineInputBorder(),
                  helperText: '',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
              ),
              SizedBox(height: 8),
              ReactiveDateTimePicker(
                formControlName: 'time',
                type: ReactiveDatePickerFieldType.time,
                decoration: const InputDecoration(
                  labelText: 'Time',
                  border: OutlineInputBorder(),
                  helperText: '',
                  suffixIcon: Icon(Icons.watch_later_outlined),
                ),
              ),
              SizedBox(height: 8),
              ReactiveDateTimePicker(
                formControlName: 'dateTime',
                type: ReactiveDatePickerFieldType.dateTime,
                decoration: const InputDecoration(
                  labelText: 'Date & Time',
                  border: OutlineInputBorder(),
                  helperText: '',
                  suffixIcon: Icon(Icons.calendar_today),
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
