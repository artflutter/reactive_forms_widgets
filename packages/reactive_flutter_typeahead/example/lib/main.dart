// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:reactive_flutter_typeahead/reactive_flutter_typeahead.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reactive TypeAhead Example',
      home: Scaffold(
        appBar: AppBar(title: const Text('Reactive TypeAhead Example')),
        body: const TypeaheadExample(),
      ),
    );
  }
}

class TypeaheadExample extends StatelessWidget {
  const TypeaheadExample({super.key});

  @override
  Widget build(BuildContext context) {
    final form = FormGroup({
      'city': FormControl<String>(value: 'Los Angeles'),
    });

    return ReactiveForm(
      formGroup: form,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  form.control('city').value = 'New York';
                },
                child: const Text('Set New York')),
            ElevatedButton(
                onPressed: () {
                  form.control('city').value = null;
                },
                child: const Text('Clear value')),
            ReactiveTypeAhead<String, String>(
              formControlName: 'city',
              stringify: (value) => value,
              suggestionsCallback: (pattern) async {
                // Simulated API call
                await Future.delayed(const Duration(milliseconds: 500));
                final cities = [
                  'New York',
                  'Los Angeles',
                  'Chicago',
                  'Houston',
                  'Phoenix',
                ];
                return cities
                    .where((city) =>
                        city.toLowerCase().contains(pattern.toLowerCase()))
                    .toList();
              },
              itemBuilder: (context, city) {
                return ListTile(
                  title: Text(city),
                );
              },
              decoration: const InputDecoration(
                labelText: 'City',
                helperText: 'Start typing a city name',
              ),
            ),
            const SizedBox(height: 16),
            ReactiveFormConsumer(
              builder: (context, form, child) {
                return Text(
                    'Selected city: ${form.control('city').value ?? ''}');
              },
            ),
          ],
        ),
      ),
    );
  }
}
