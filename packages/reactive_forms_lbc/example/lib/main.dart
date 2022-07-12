import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms_lbc/reactive_forms_lbc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _counter = 0;

  FormGroup buildForm() => fb.group({
        'input': FormControl<String>(value: null),
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
          child: Column(
            children: [
              MyApp1(
                c: _counter,
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _counter++;
                  });
                },
                child: const Text('Increment counter'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CitiesService {
  static final List<String> cities = [
    'Beirut',
    'Damascus',
    'San Fransisco',
    'Rome',
    'Los Angeles',
    'Madrid',
    'Bali',
    'Barcelona',
    'Paris',
    'Bucharest',
    'New York City',
    'Philadelphia',
    'Sydney',
  ];

  static List<String> getSuggestions(String query) {
    List<String> matches = <String>[];
    matches.addAll(cities);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}

class MyApp1 extends StatelessWidget {
  final int c;

  const MyApp1({Key? key, required this.c}) : super(key: key);

  FormGroup buildForm() => fb.group({
        'input': FormControl<String>(value: null),
        'input2': FormControl<String>(value: null),
      });

  @override
  Widget build(BuildContext context) {
    return ReactiveFormBuilder(
      form: buildForm,
      builder: (context, form, child) {
        return Column(
          children: [
            ReactiveTextField(
              decoration: const InputDecoration(labelText: 'Input'),
              formControlName: 'input',
            ),
            ReactiveTextField(
              decoration: const InputDecoration(labelText: 'Input2'),
              formControlName: 'input2',
            ),
            ReactiveFormControlValueBuilder<String>(
              builder: (context, control) {
                return Text(control.value ?? '');
              },
              buildWhen: (control, prev, curr) {
                debugPrint('Focus => $prev -- c => $curr');
                return (curr?.length ?? 0) <= 6;
              },
              formControl: form.controls['input']! as FormControl<String>,
            ),
            // ReactiveFormControlFocusListener<String>(
            //   listener: (context, control) {
            //     // print(value);
            //   },
            //   listenWhen: (control, prev, curr) {
            //     debugPrint('Focus => $prev -- c => $curr');
            //     return true;
            //   },
            //   formControl: form.controls['input']! as FormControl<String>,
            //   child: Text(c.toString()),
            // ),
            // ReactiveFormControlTouchListener<String>(
            //   listener: (context, control) {
            //     // print(value);
            //   },
            //   listenWhen: (control, prev, curr) {
            //     debugPrint('Touch => $prev -- c => $curr');
            //     return true;
            //   },
            //   formControl: form.controls['input']! as AbstractControl<String>,
            //   child: Text(c.toString()),
            // ),
            // ReactiveFormControlStatusListener<String>(
            //   listener: (context, control) {
            //     // print(value);
            //   },
            //   listenWhen: (control, prev, curr) {
            //     debugPrint('Status => $prev -- c => $curr');
            //     return true;
            //   },
            //   formControl: form.controls['input']! as AbstractControl<String>,
            //   child: Text(c.toString()),
            // ),
            // ReactiveFormControlValueListener<String>(
            //   listener: (context, control) {
            //     // print(value);
            //   },
            //   listenWhen: (control, prev, curr) {
            //     debugPrint('Value => $prev -- c => $curr');
            //     return true;
            //   },
            //   formControl: form.controls['input']! as AbstractControl<String>,
            //   child: Text(c.toString()),
            // ),
            // ReactiveFormControlValueListener<String>(
            //   listener: (context, control) {
            //     // print(value);
            //   },
            //   listenWhen: (control, previousValue, currentValue) {
            //     debugPrint('p ====> $previousValue -- c ====> $currentValue');
            //     return true;
            //   },
            //   formControlName: 'input',
            // ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('Disable'),
              onPressed: () {
                (form.controls['input']! as AbstractControl<String>)
                    .markAsDisabled();
                (form.controls['input']! as AbstractControl<String>)
                    .markAsEnabled();
              },
            ),
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
    );
  }
}
