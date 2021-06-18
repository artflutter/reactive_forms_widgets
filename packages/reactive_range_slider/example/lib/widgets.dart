import 'package:example/sample_screen.dart';
import 'package:flutter/material.dart' hide ProgressIndicator;
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_range_slider/reactive_range_slider.dart';

class Widgets extends StatelessWidget {
  FormGroup buildForm() => fb.group({
        'input': FormControl<RangeValues>(value: RangeValues(0, 10)),
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
              ReactiveRangeSlider(
                formControlName: 'input',
                min: 0,
                max: 100,
                divisions: 5,
                labelBuilder: (values) => RangeLabels(
                  values.start.round().toString(),
                  values.end.round().toString(),
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                ),
                // step: 5,
                // textStyle: const TextStyle(fontSize: 18),
                // decoration: InputDecoration(
                //   border: OutlineInputBorder(),
                //   contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                //   labelText: "Search amount",
                //   helperText: '',
                // ),
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
