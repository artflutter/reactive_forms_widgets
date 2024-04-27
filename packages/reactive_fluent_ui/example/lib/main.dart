import 'package:flutter/material.dart' hide Colors;
import 'package:reactive_fluent_ui/reactive_fluent_ui.dart' as fui;
import 'package:reactive_fluent_ui/reactive_fluent_ui.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  runApp(const MyApp());
}

const cats = <String>[
  'Abyssinian',
  'Aegean',
  'American Bobtail',
  'American Curl',
  'American Ringtail',
  'American Shorthair',
  'American Wirehair',
  'Aphrodite Giant',
  'Arabian Mau',
  'Asian cat',
  'Asian Semi-longhair',
  'Australian Mist',
];

Map<String, Color> colors = {
  'Blue': Colors.blue,
  'Green': Colors.green,
  'Red': Colors.red,
  'Yellow': Colors.yellow,
  'Grey': Colors.grey,
  'Orange': Colors.orange,
  'Purple': Colors.purple,
  'Teal': Colors.teal,
};

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  FormGroup buildForm() => fb.group({
        'textBox': FormControl<String>(
          value: null,
          validators: [Validators.required],
        ),
        'textBox1': FormControl<String>(
          value: 'asdf',
        ),
        'autoSuggestBox': FormControl<String>(
          value: null,
        ),
        'comboBox': FormControl<String>(
          value: null,
        ),
        'timePicker': FormControl<DateTime>(
          value: null,
        ),
        'datePicker': FormControl<DateTime>(
          value: null,
        ),
        'checkBox': FormControl<bool>(
          value: false,
        ),
        'toggleSwitch': FormControl<bool>(
          value: null,
        ),
        'slider': FormControl<double>(
          value: null,
        ),
      });

  @override
  Widget build(BuildContext context) {
    return fui.FluentApp(
      theme: fui.FluentThemeData(),
      home: Scaffold(
        appBar: AppBar(),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('TextFormBox'),
                    fui.ReactiveFluentTextFormBox<String>(
                      formControlName: 'textBox',
                    ),
                    const SizedBox(height: 8),
                    const Text('TextFormBox'),
                    fui.ReactiveFluentTextFormBox<String>(
                      formControlName: 'textBox1',
                    ),
                    const SizedBox(height: 8),
                    const Text('AutoSuggestBox'),
                    fui.ReactiveFluentAutoSuggestBox<String, String>(
                      formControlName: 'autoSuggestBox',
                      items: cats
                          .map<fui.AutoSuggestBoxItem<String>>(
                            (cat) => fui.AutoSuggestBoxItem<String>(
                              value: cat,
                              label: cat,
                              onFocusChange: (focused) {
                                if (focused) debugPrint('Focused $cat');
                              },
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 8),
                    const Text('ComboBox'),
                    fui.ReactiveFluentComboBox<String, String>(
                      formControlName: 'comboBox',
                      isExpanded: false,
                      items: colors.entries.map((e) {
                        return ComboBoxItem(
                          value: e.key,
                          child: Text(e.key),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 8),
                    const Text('TimePicker'),
                    fui.ReactiveFluentTimePicker<DateTime>(
                      formControlName: 'timePicker',
                    ),
                    const SizedBox(height: 8),
                    const Text('datePicker'),
                    fui.ReactiveFluentDatePicker<DateTime>(
                      formControlName: 'datePicker',
                    ),
                    const SizedBox(height: 8),
                    const Text('slider'),
                    fui.ReactiveFluentSlider<double>(
                      formControlName: 'slider',
                    ),
                    const SizedBox(height: 8),
                    const Text('checkBox'),
                    fui.ReactiveFluentCheckBox<bool>(
                      formControlName: 'checkBox',
                    ),
                    const SizedBox(height: 8),
                    const Text('toggleSwitch'),
                    fui.ReactiveFluentToggleSwitch<bool>(
                      formControlName: 'toggleSwitch',
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      child: const Text('Submit'),
                      onPressed: () {
                        if (form.valid) {
                          debugPrint(form.value.toString());
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
