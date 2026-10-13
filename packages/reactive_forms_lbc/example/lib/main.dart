import 'package:material_ui/material_ui.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms_lbc/reactive_forms_lbc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

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
          child: SingleChildScrollView(
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
                ),
                const Divider(),
                const FormArrayCollectionDemo(),
              ],
            ),
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

  const MyApp1({super.key, required this.c});

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
            // ReactiveTextField(
            //   decoration: const InputDecoration(labelText: 'Input2'),
            //   formControlName: 'input2',
            // ),
            // ReactiveFormControlValueConsumer<String>(
            //   builder: (context, control) {
            //     return Text(control.value ?? '');
            //   },
            //   listenerOnInit: (control) {
            //     print("ReactiveFormControlValueConsumer => listenOnInit: true");
            //   },
            //   buildWhen: (control, prev, curr) {
            //     debugPrint('Focus => $prev -- c => $curr');
            //     return (curr?.length ?? 0) <= 6;
            //   },
            //   formControl: form.controls['input']! as FormControl<String>,
            // ),
            ReactiveFormControlValueBuilder<String>(
              builder: (context, control) {
                return Text(control.value ?? '');
              },
              // buildWhen: (control, prev, curr) {
              //   debugPrint('Focus => $prev -- c => $curr');
              //   return (curr?.length ?? 0) <= 6;
              // },
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
            ReactiveFormControlValueListener<String>(
              listener: (_, control) {
                print(control.value);
              },
              listenWhen: notEquals,
              // listenerOnInit: (control) {
              //   print("ReactiveFormControlValueListener => listener");
              // },
              // listenWhen: (control, prev, curr) {
              //   debugPrint('Value => $prev -- c => $curr');
              //   return true;
              // },
              formControl: form.controls['input']! as AbstractControl<String>,
              child: Text(c.toString()),
            ),
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
                // (form.controls['input']! as AbstractControl<String>)
                //     .markAsEnabled();
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: const Text('Enable'),
              onPressed: () {
                (form.controls['input']! as AbstractControl<String>)
                    .markAsEnabled();
              },
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

class FormArrayCollectionDemo extends StatefulWidget {
  const FormArrayCollectionDemo({super.key});

  @override
  State<FormArrayCollectionDemo> createState() =>
      _FormArrayCollectionDemoState();
}

class _FormArrayCollectionDemoState extends State<FormArrayCollectionDemo> {
  final FormArray<Map<String, Object?>> rows = FormArray<Map<String, Object?>>([
    fb.group({'name': 'Alice'}),
    fb.group({'name': 'Bob'}),
  ]);

  int _seed = 0;

  FormGroup _newRow() {
    _seed++;
    return fb.group({'name': 'Row #$_seed'});
  }

  @override
  void dispose() {
    rows.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveFormArrayCollectionConsumer<Map<String, Object?>>(
      formArray: rows,
      onItemAdded: (_, array, control, addedIndex) {
        // ignore: avoid_print
        print('added @ $addedIndex => ${control.value}');
      },
      onItemRemoved: (_, array, control, removedIndex) {
        // ignore: avoid_print
        print('removed @ $removedIndex => ${control.value}');
      },
      builder: (context, array) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text('FormArray length: ${array.controls.length}'),
            ),
            for (var i = 0; i < array.controls.length; i++)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Row(
                  children: [
                    Expanded(
                      child: Text('[$i] ${array.controls[i].value}'),
                    ),
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: () => array.removeAt(i),
                    ),
                  ],
                ),
              ),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () => array.add(_newRow()),
                  child: const Text('add'),
                ),
                ElevatedButton(
                  onPressed: () => array.insert(0, _newRow()),
                  child: const Text('insert @ 0'),
                ),
                ElevatedButton(
                  onPressed: () =>
                      array.addAll([_newRow(), _newRow(), _newRow()]),
                  child: const Text('addAll x3'),
                ),
                ElevatedButton(
                  onPressed:
                      array.controls.isEmpty ? null : () => array.removeAt(0),
                  child: const Text('removeAt(0)'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
