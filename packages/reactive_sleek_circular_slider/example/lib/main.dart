import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_sleek_circular_slider/reactive_sleek_circular_slider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  FormGroup buildForm() => fb.group({
        'input': FormControl<double>(value: 10),
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
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20.0,
            ),
            child: ReactiveFormBuilder(
              form: buildForm,
              builder: (context, form, child) {
                return Column(
                  children: [
                    ReactiveSleekCircularSlider<double>(
                      formControlName: 'input',
                      // appearance: CircularSliderAppearance(animationEnabled: false),
                      min: 5,
                      max: 100,
                      heightFactor: 0.78,
                      alignment: Alignment.topCenter,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                        labelText: "Search amount",
                        helperText: '',
                      ),
                    ),
                    ReactiveSleekCircularSlider<double>(
                      formControlName: 'input',
                      // appearance: CircularSliderAppearance(animationEnabled: false),
                      min: 5,
                      max: 100,
                      heightFactor: 0.78,
                      alignment: Alignment.topCenter,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      child: const Text('Sign Up'),
                      onPressed: () {
                        if (form.valid) {
                          // ignore: avoid_print
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
