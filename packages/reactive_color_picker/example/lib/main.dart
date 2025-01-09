import 'package:flutter/material.dart';
import 'package:reactive_color_picker/reactive_color_picker.dart';

import 'package:reactive_forms/reactive_forms.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  FormGroup buildForm() => fb.group({
        'input': FormControl<Color>(),
        'inputDisabled': FormControl<Color>(disabled: true),
        'inputList': FormControl<List<Color>>(),
        'material': FormControl<Color>(value: Colors.amber),
        'colorPicker': FormControl<Color>(
            value: Colors.red, validators: [Validators.required]),
        'sliderColorPicker': FormControl<Color>(value: Colors.lime),
      });

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();

    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
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
                  children: [
                    _Section(
                      title: const Text('colorPicker'),
                      child: ReactiveColorPicker<Color>(
                        formControlName: 'colorPicker',
                      ),
                    ),
                    _Section(
                      title: const Text('colorPicker with custom picker'),
                      child: ReactiveColorPicker<Color>(
                        formControlName: 'colorPicker',
                        pickerAreaHeightPercent: 0.7,
                        displayThumbColor: true,
                        labelTypes: const [],
                        hexInputController: textController,
                        portraitOnly: true,
                        colorPickerBuilder: (pickColor, color) {
                          return ListTile(
                            title: const Text('Color Picker'),
                            trailing: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.grey.shade400,
                                ),
                              ),
                            ),
                            onTap: pickColor,
                          );
                        },
                        colorPickerDialogBuilder: (colorPicker) {
                          final border = OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xFFD77243)),
                            borderRadius: BorderRadius.circular(12),
                          );
                          return AlertDialog(
                            scrollable: true,
                            titlePadding: EdgeInsets.zero,
                            contentPadding: EdgeInsets.zero,
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            content: Column(
                              children: [
                                colorPicker,
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 0, 16, 16),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 40,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: const Color(0xFFD77243),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            'HEX',
                                            style: TextStyle(
                                              color: Color(0xFF0F1111),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: SizedBox(
                                          height: 40,
                                          child: TextField(
                                            decoration: InputDecoration(
                                              enabledBorder: border,
                                              focusedBorder: border,
                                              border: border,
                                              counterText: '',
                                            ),
                                            controller: textController,
                                            style: const TextStyle(
                                              color: Color(0xFF0F1111),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            autofocus: true,
                                            maxLength: 9,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    _Section(
                      title: const Text('BlockColorPicker'),
                      child: ReactiveBlockColorPicker<Color>(
                        formControlName: 'input',
                      ),
                    ),
                    _Section(
                      title: const Text('BlockColorPicker disabled'),
                      child: ReactiveBlockColorPicker<Color>(
                        formControlName: 'inputDisabled',
                      ),
                    ),
                    _Section(
                      title: const Text('MultipleBlockColorPicker'),
                      child: ReactiveMultipleBlockColorPicker<List<Color>>(
                        formControlName: 'inputList',
                      ),
                    ),
                    _Section(
                      title: const Text('MaterialColorPicker'),
                      child: ReactiveMaterialColorPicker<Color>(
                        formControlName: 'material',
                      ),
                    ),
                    _Section(
                      title: const Text('SliderColorPicker'),
                      child: ReactiveSliderColorPicker<Color>(
                        formControlName: 'sliderColorPicker',
                      ),
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
            ),
          ),
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final Widget title;
  final Widget child;

  const _Section({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title,
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}
