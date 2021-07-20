import 'package:flutter/material.dart';
import 'package:reactive_date_time_picker/reactive_date_time_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  FormGroup buildForm() => fb.group({
        'date': FormControl<DateTime>(value: DateTime.now()),
        'time': FormControl<DateTime>(value: DateTime.now()),
        'dateTime': FormControl<DateTime>(value: DateTime.now()),
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20.0,
            ),
            child: ReactiveFormBuilder(
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
          ),
        ),
      ),
    );
  }
}
