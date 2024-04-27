import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:reactive_sf_signaturepad/reactive_sf_signaturepad.dart';
import 'package:reactive_forms/reactive_forms.dart';

final key = GlobalKey<SfSignaturePadState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  FormGroup buildForm() => fb.group({
        'input': FormControl<Uint8List>(value: null),
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
                    ReactiveSfSignaturePad<Uint8List>(
                      widgetKey: key,
                      decoration: const InputDecoration(
                        labelText: 'Signature',
                        border: OutlineInputBorder(),
                      ),
                      // backgroundColor: Colors.black12,
                      formControlName: 'input',
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
