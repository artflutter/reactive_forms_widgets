import 'package:flutter/material.dart';
import 'package:reactive_dropdown_search/reactive_dropdown_search.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
                    ReactiveDropdownSearch<String, String>(
                      formControlName: 'menu',
                      decoration: InputDecoration(
                        helperText: '',
                        contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                        border: OutlineInputBorder(),
                      ),
                      mode: Mode.MENU,
                      hint: "Select a country",
                      showSelectedItems: true,
                      items: [
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
                    SizedBox(height: 8),
                    ReactiveDropdownSearchMultiSelection<String, String>(
                      formControlName: 'menuMultiple',
                      decoration: InputDecoration(
                        helperText: '',
                        contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                        border: OutlineInputBorder(),
                      ),
                      mode: Mode.MENU,
                      hint: "Select a country",
                      showSelectedItems: true,
                      items: [
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
                    SizedBox(height: 8),
                    ReactiveDropdownSearch<String, String>(
                      formControlName: 'bottomSheet',
                      mode: Mode.BOTTOM_SHEET,
                      decoration: InputDecoration(
                        helperText: '',
                        contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                        border: OutlineInputBorder(),
                      ),
                      maxHeight: 300,
                      items: ["Brazil", "Italia", "Tunisia", 'Canada'],
                      label: "Custom BottomSheet mode",
                      showSearchBox: true,
                      popupTitle: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColorDark,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Center(
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
                      popupShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
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
