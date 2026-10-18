import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_material_ui/reactive_material_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  FormGroup buildForm() => fb.group({
    'text': FormControl<String>(validators: [Validators.required]),
    'timeText': FormControl<TimeOfDay>(
      value: const TimeOfDay(hour: 9, minute: 30),
    ),
    'dropdown': FormControl<String>(value: 'One'),
    'checkbox': FormControl<bool>(value: false),
    'checkboxListTile': FormControl<bool>(value: true),
    'radio': FormControl<String>(value: 'A'),
    'switch': FormControl<bool>(value: true),
    'switchListTile': FormControl<bool>(value: false),
    'slider': FormControl<double>(value: 30),
    'date': FormControl<DateTime>(),
    'time': FormControl<TimeOfDay>(),
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'reactive_material_ui example',
      theme: ThemeData(colorSchemeSeed: Colors.indigo),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('reactive_material_ui')),
        body: SafeArea(
          child: ReactiveFormBuilder(
            form: buildForm,
            builder: (context, form, child) {
              return ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  ReactiveMaterialTextField<String>(
                    formControlName: 'text',
                    decoration: const InputDecoration(labelText: 'Text field'),
                    validationMessages: {
                      ValidationMessage.required: (_) => 'Required',
                    },
                  ),
                  const SizedBox(height: 16),
                  // FormControl<TimeOfDay> selects
                  // MaterialTimeOfDayValueAccessor automatically.
                  ReactiveMaterialTextField<TimeOfDay>(
                    formControlName: 'timeText',
                    decoration: const InputDecoration(
                      labelText: 'TimeOfDay as text (H:mm)',
                    ),
                  ),
                  const SizedBox(height: 16),
                  ReactiveMaterialDropdownField<String>(
                    formControlName: 'dropdown',
                    decoration: const InputDecoration(labelText: 'Dropdown'),
                    items: const [
                      DropdownMenuItem(value: 'One', child: Text('One')),
                      DropdownMenuItem(value: 'Two', child: Text('Two')),
                      DropdownMenuItem(value: 'Three', child: Text('Three')),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      ReactiveMaterialCheckbox(formControlName: 'checkbox'),
                      const Text('Checkbox'),
                    ],
                  ),
                  ReactiveMaterialCheckboxListTile(
                    formControlName: 'checkboxListTile',
                    title: const Text('Checkbox list tile'),
                  ),
                  Row(
                    children: [
                      ReactiveMaterialRadio<String>(
                        formControlName: 'radio',
                        value: 'A',
                      ),
                      const Text('Radio A'),
                    ],
                  ),
                  ReactiveMaterialRadioListTile<String>(
                    formControlName: 'radio',
                    value: 'B',
                    title: const Text('Radio list tile B'),
                  ),
                  Row(
                    children: [
                      ReactiveMaterialSwitch(formControlName: 'switch'),
                      const Text('Switch'),
                    ],
                  ),
                  ReactiveMaterialSwitchListTile(
                    formControlName: 'switchListTile',
                    title: const Text('Switch list tile'),
                  ),
                  ReactiveMaterialSlider(
                    formControlName: 'slider',
                    max: 100,
                    divisions: 10,
                    labelBuilder: (value) => value.toStringAsFixed(0),
                  ),
                  ListTile(
                    title: ReactiveValueListenableBuilder<DateTime>(
                      formControlName: 'date',
                      builder: (context, control, child) =>
                          Text('Date: ${control.value ?? '-'}'),
                    ),
                    trailing: ReactiveMaterialDatePicker<DateTime>(
                      formControlName: 'date',
                      firstDate: DateTime(1985),
                      lastDate: DateTime(2100),
                      builder: (context, picker, child) => IconButton(
                        onPressed: picker.showPicker,
                        icon: const Icon(Icons.date_range),
                      ),
                    ),
                  ),
                  ListTile(
                    title: ReactiveValueListenableBuilder<TimeOfDay>(
                      formControlName: 'time',
                      builder: (context, control, child) => Text(
                        'Time: ${control.value?.format(context) ?? '-'}',
                      ),
                    ),
                    trailing: ReactiveMaterialTimePicker(
                      formControlName: 'time',
                      builder: (context, picker, child) => IconButton(
                        onPressed: picker.showPicker,
                        icon: const Icon(Icons.access_time),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (form.valid) {
                        debugPrint(form.value.toString());
                      } else {
                        form.markAllAsTouched();
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
