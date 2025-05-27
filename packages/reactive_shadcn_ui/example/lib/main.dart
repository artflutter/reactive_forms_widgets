import 'package:flutter/material.dart';
import 'package:reactive_shadcn_ui/reactive_shadcn_ui.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  FormGroup buildForm() => fb.group({
        'input': FormControl<String>(
          value: null,
          validators: [
            Validators.required,
          ],
        ),
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
            child: ShadTheme(
              data: ShadThemeData(
                brightness: Brightness.light,
                colorScheme: const ShadZincColorScheme.light(),
              ),
              child: ReactiveFormBuilder(
                form: buildForm,
                builder: (context, form, child) {
                  return Column(
                    children: [
                      ReactiveShadInput(
                        formControlName: 'input',
                        label: const Text('Username'),
                        description: const Text('This is your public display name.'),
                      ),

                      ElevatedButton(
                        child: const Text('Submit'),
                        onPressed: () {
                          form.markAllAsTouched();
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
      ),
    );
  }
}
