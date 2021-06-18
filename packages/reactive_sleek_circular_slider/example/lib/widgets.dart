import 'package:example/sample_screen.dart';
import 'package:flutter/material.dart' hide ProgressIndicator;
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_sleek_circular_slider/reactive_sleek_circular_slider.dart';

class Widgets extends StatelessWidget {
  FormGroup buildForm() => fb.group({
        'input': FormControl<double>(value: 10),
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
              ReactiveSleekCircularSlider(
                formControlName: 'input',
                // appearance: CircularSliderAppearance(animationEnabled: false),
                min: 5,
                max: 100,
                heightFactor: 0.78,
                alignment: Alignment.topCenter,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                  labelText: "Search amount",
                  helperText: '',
                ),
              ),
              ReactiveSleekCircularSlider(
                formControlName: 'input',
                // appearance: CircularSliderAppearance(animationEnabled: false),
                min: 5,
                max: 100,
                heightFactor: 0.78,
                alignment: Alignment.topCenter,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
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
