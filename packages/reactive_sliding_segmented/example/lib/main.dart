import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_sliding_segmented/reactive_sliding_segmented.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  FormGroup buildForm() => fb.group({
        'input': FormControl<String>(value: null),
      });

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.deepPurpleAccent),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

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
                    ReactiveSlidingSegmentedControl<String, String>(
                      formControlName: 'input',
                      decoration: const InputDecoration(
                        labelText: 'Rating',
                        border: OutlineInputBorder(),
                        helperText: '',
                      ),
                      padding: EdgeInsets.all(0),
                      children: {
                        'a': Text('A'),
                        'b': Text('B'),
                        'c': Text('C'),
                      },
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
