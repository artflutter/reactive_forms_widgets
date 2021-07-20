import 'package:flutter/material.dart';
import 'package:reactive_advanced_switch/reactive_advanced_switch.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  FormGroup buildForm() => fb.group({
        'switch': FormControl<bool>(value: false),
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
                    ReactiveAdvancedSwitch<bool>(
                      formControlName: 'switch',
                      decoration: InputDecoration(
                        isCollapsed: true,
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                      ),
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
