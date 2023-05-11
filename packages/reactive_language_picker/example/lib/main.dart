import 'package:flutter/material.dart';
import 'package:reactive_language_picker/reactive_language_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
                    ReactiveLanguagePickerDropdown<String>(
                      formControlName: 'input',
                      valueAccessor: LanguageCodeValueAccessor(),
                    ),
                    ReactiveLanguagePickerDialog<String>(
                      formControlName: 'input',
                      valueAccessor: LanguageCodeValueAccessor(),
                      builder: (context, language, showDialog) {
                        return ListTile(
                          onTap: showDialog,
                          title: Text(language?.name ?? "No language selected"),
                        );
                      },
                    ),
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
