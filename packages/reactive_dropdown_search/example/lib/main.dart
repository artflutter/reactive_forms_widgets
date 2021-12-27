import 'package:flutter/material.dart';
import 'package:reactive_dropdown_search/reactive_dropdown_search.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  FormGroup buildForm() => fb.group({
        'menu': FormControl<String>(value: 'Tunisia'),
        'menuMultiple': FormControl<List<String>>(value: ['Tunisia', 'Brazil']),
        'bottomSheet': FormControl<String>(value: 'Brazil'),
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
                    ReactiveDropdownSearch<String, String>(
                      formControlName: 'menu',
                      decoration: const InputDecoration(
                        helperText: '',
                        contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                        border: OutlineInputBorder(),
                      ),
                      mode: Mode.MENU,
                      hint: "Select a country",
                      showSelectedItems: true,
                      items: const [
                        "Brazil",
                        "Italia (Disabled)",
                        "Tunisia",
                        'Canada'
                      ],
                      label: "Menu mode *",
                      showClearButton: true,
                      popupItemDisabled: (s) {
                        return s.startsWith('I');
                      },
                    ),
                    const SizedBox(height: 8),
                    ReactiveDropdownSearchMultiSelection<String, String>(
                      formControlName: 'menuMultiple',
                      decoration: const InputDecoration(
                        helperText: '',
                        contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                        border: OutlineInputBorder(),
                      ),
                      mode: Mode.MENU,
                      hint: "Select a country",
                      showSelectedItems: true,
                      items: const [
                        "Brazil",
                        "Italia (Disabled)",
                        "Tunisia",
                        'Canada'
                      ],
                      label: "Menu mode *",
                      showClearButton: true,
                      popupItemDisabled: (s) {
                        return s.startsWith('I');
                      },
                    ),
                    const SizedBox(height: 8),
                    ReactiveDropdownSearch<String, String>(
                      formControlName: 'bottomSheet',
                      mode: Mode.BOTTOM_SHEET,
                      decoration: const InputDecoration(
                        helperText: '',
                        contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                        border: OutlineInputBorder(),
                      ),
                      maxHeight: 300,
                      items: const ["Brazil", "Italia", "Tunisia", 'Canada'],
                      label: "Custom BottomSheet mode",
                      showSearchBox: true,
                      popupTitle: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorDark,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Country',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      popupShape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
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
