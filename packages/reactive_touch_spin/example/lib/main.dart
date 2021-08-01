import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_touch_spin/reactive_touch_spin.dart';

void main() {
  runApp(MyApp());
}

class NumValueAccessor extends ControlValueAccessor<int, num> {
  final int fractionDigits;

  NumValueAccessor({
    this.fractionDigits = 2,
  });

  @override
  num? modelToViewValue(int? modelValue) {
    return modelValue;
  }

  @override
  int? viewToModelValue(num? viewValue) {
    return viewValue?.toInt();
  }
}

class MyApp extends StatelessWidget {
  FormGroup buildForm() => fb.group({
        'touchSpin': FormControl<int>(value: 10),
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
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
                    ReactiveTouchSpin<int>(
                      formControlName: 'touchSpin',
                      valueAccessor: NumValueAccessor(),
                      displayFormat: NumberFormat()..minimumFractionDigits = 0,
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
          ),
        ),
      ),
    );
  }
}
