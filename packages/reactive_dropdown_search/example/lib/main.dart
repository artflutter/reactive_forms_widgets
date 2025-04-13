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
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        decoration: InputDecoration(
                          hintText: "Select a country",
                          helperText: '',
                          labelText: "Menu mode *",
                          contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      suffixProps: const DropdownSuffixProps(
                        dropdownButtonProps: DropdownButtonProps(
                          iconOpened: Padding(
                            padding: EdgeInsets.only(right: 120.0),
                            child: Icon(Icons.ac_unit, size: 24),
                          ),
                          iconClosed: Padding(
                            padding: EdgeInsets.only(right: 120.0),
                            child: Icon(Icons.ac_unit, size: 24),
                          ),
                        ),
                      ),
                      popupProps: PopupProps.menu(
                        showSelectedItems: true,
                        disabledItemFn: (s) {
                          return s.startsWith('I');
                        },
                          // fit: FlexFit.loose,
                        constraints: const BoxConstraints(minHeight: 100, maxHeight: 400)
                      ),
                      items: (_, __) => const [
                        "Brazil",
                        "Italia (Disabled)",
                        "Tunisia",
                        'Canada'
                      ],
                    ),
                    const SizedBox(height: 8),
                    ReactiveDropdownSearchMultiSelection<String, String>(
                      formControlName: 'menuMultiple',
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        decoration: InputDecoration(
                          hintText: "Select a country",
                          labelText: "Menu mode *",
                          helperText: '',
                          contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      popupProps: MultiSelectionPopupProps.menu(
                        showSelectedItems: true,
                        disabledItemFn: (s) {
                          return s.startsWith('I');
                        },
                      ),
                      items: (_, __) => const [
                        "Brazil",
                        "Italia (Disabled)",
                        "Tunisia",
                        'Canada'
                      ],
                    ),
                    const SizedBox(height: 8),
                    ReactiveDropdownSearch<String, String>(
                      formControlName: 'bottomSheet',
                      popupProps: PopupProps.bottomSheet(
                        showSearchBox: true,
                        bottomSheetProps: const BottomSheetProps(
                          constraints: BoxConstraints(maxHeight: 300),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                          ),
                        ),
                        title: Container(
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
                      ),
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        decoration: InputDecoration(
                          labelText: "Custom BottomSheet mode",
                          helperText: '',
                          contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      items: (_, __) => const ["Brazil", "Italia", "Tunisia", 'Canada'],
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
