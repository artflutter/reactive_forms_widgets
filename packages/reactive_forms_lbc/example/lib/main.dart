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
                child: Text('Increment counter'),
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
      });

  @override
  Widget build(BuildContext context) {
    return ReactiveFormBuilder(
      form: buildForm,
      builder: (context, form, child) {
        return Column(
          children: [
            ReactiveTextField(
              formControlName: 'input',
            ),
            ReactiveFormControlListener<String>(
              listener: (context, value) {
                // print(value);
              },
              listenWhen: (prev, curr) {
                print('p => ${prev} -- c => ${curr}');
                return true;
              },
              formControl: form.controls['input']! as AbstractControl<String>,
              child: Text(c.toString()),
            ),
            ReactiveFormControlListener<String>(
              listener: (context, value) {
                // print(value);
              },
              listenWhen: (prev, curr) {
                print('p ====> ${prev} -- c ====> ${curr}');
                return true;
              },
              formControlName: 'input',
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
    );
  }
}
