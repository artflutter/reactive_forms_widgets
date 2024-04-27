import 'package:flutter/material.dart';
import 'package:reactive_contact_picker/reactive_contact_picker.dart';

import 'package:reactive_forms/reactive_forms.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  FormGroup buildForm() => fb.group({
        'input': FormControl<PhoneContact>(),
      });

  @override
  Widget build(BuildContext context) {
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
                    const SizedBox(height: 16),
                    ReactivePhoneContactPicker<PhoneContact>(
                      formControlName: 'input',
                      contactBuilder: (contact) {
                        if (contact == null) {
                          return const SizedBox(
                            width: double.infinity,
                            height: 60,
                            child: Center(
                              child: Text('tap to select contact'),
                            ),
                          );
                        }

                        return Column(
                          children: <Widget>[
                            const Text("Phone contact:"),
                            Text("Name: ${contact.fullName}"),
                            Text(
                                "Phone: ${contact.phoneNumber!.number} (${contact.phoneNumber!.label})")
                          ],
                        );
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
            ),
          ),
        ),
      ),
    );
  }
}
