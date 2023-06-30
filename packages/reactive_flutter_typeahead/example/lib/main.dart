// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:reactive_flutter_typeahead/reactive_flutter_typeahead.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  FormGroup buildForm() => fb.group({
        'input': FormControl<String>(value: null),
        'input2': FormControl<String>(value: null),
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
                    // ReactiveTypeAhead(
                    //   formControlName: 'phone',
                    //   textFieldConfiguration: TextFieldConfiguration(
                    //     keyboardType: TextInputType.phone,
                    //     decoration: InputDecoration(
                    //       labelText: 'Phone Number',
                    //       icon: Icon(Icons.email),
                    //     ),
                    //     // inputFormatters: [
                    //     //   phoneNumberMask,
                    //     // ],
                    //     controller: _typeAheadController1,
                    //   ),
                    //   suggestionsCallback: (pattern) =>
                    //       queryMemberPhoneData1(pattern),
                    //   itemBuilder: (context, Member suggestion) {
                    //     return ListTile(
                    //       title: Text(suggestion.phone),
                    //       subtitle: Text('${suggestion.firstName}'),
                    //     );
                    //   },
                    //   onSuggestionSelected: (Member suggestion) {
                    //     form.control('phone').value(suggestion.phone);
                    //   },
                    // ),
                    ReactiveTypeAhead<String, String>(
                      formControlName: 'input',
                      stringify: (_) => _,
                      textFieldConfiguration: TextFieldConfiguration(
                        autofocus: false,
                        style: DefaultTextStyle.of(context)
                            .style
                            .copyWith(fontStyle: FontStyle.italic),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                      suggestionsCallback: (pattern) async {
                        return CitiesService.getSuggestions(pattern);
                      },
                      itemBuilder: (context, suggestion) {
                        return ListTile(
                          leading: const Icon(Icons.shopping_cart),
                          title: Text(suggestion),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    ReactiveCupertinoTypeAhead<String, String>(
                      formControlName: 'input2',
                      stringify: (_) => _,
                      getImmediateSuggestions: true,
                      suggestionsCallback: (pattern) {
                        return Future.delayed(
                          const Duration(seconds: 1),
                          () => CitiesService.getSuggestions(pattern),
                        );
                      },
                      itemBuilder: (context, suggestion) {
                        return Material(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              suggestion,
                            ),
                          ),
                        );
                      },
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
