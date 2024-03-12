import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:reactive_dropdown_button2/reactive_dropdown_button2.dart';
import 'package:reactive_forms/reactive_forms.dart';

void main() {
  runApp(const MyApp());
}

final List<String> items = [
  'Item1',
  'Item2',
  'Item3',
  'Item4',
  'Item5',
  'Item6',
  'Item7',
  'Item8',
];

final List<({int id, String value})> itemsRecord = [
  (id: 1, value: 'Item1'),
  (id: 2, value: 'Item2'),
  (id: 3, value: 'Item3'),
  (id: 4, value: 'Item4'),
  (id: 5, value: 'Item5'),
  (id: 6, value: 'Item6'),
  (id: 7, value: 'Item7'),
  (id: 8, value: 'Item8'),
];

class Drop extends DropDownValueAccessor<int, ({int id, String value})> {
  @override
  ({int id, String value})? modelToViewValue(List<DropdownItem<({int id, String value})>> items, int? modelValue) {
    return items.firstWhereOrNull((e) => e.value?.id == modelValue)?.value;
  }

  @override
  int? viewToModelValue(List<DropdownItem<({int id, String value})>> items, ({int id, String value})? modelValue) {
    return modelValue?.id;
  }

}

const icon = Icon(
  Icons.access_alarms,
  size: 24,
);
const hint = Text('Hint text');

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  FormGroup buildForm() => fb.group({
    'input': FormControl<String>(
      value: null,
      validators: [
        const RequiredValidator(),
      ],
    ),
    'input2': FormControl<int>(
      value: null,
      validators: [
        const RequiredValidator(),
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
            child: ReactiveFormBuilder(
              form: buildForm,
              builder: (context, form, child) {
                return Column(
                  children: [
                    const SizedBox(height: 16),
                    DropdownButtonHideUnderline(
                      child: ReactiveDropdownButton2<String, String>(
                        formControlName: 'input',
                        isExpanded: true,
                        items: items
                            .map(
                              (String item) => DropdownItem<String>(
                                value: item,
                                child: Text(item),
                              ),
                            )
                            .toList(),
                        buttonStyleData: ButtonStyleData(
                          height: 50,
                          width: 160,
                          padding: const EdgeInsets.only(left: 14, right: 14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: Colors.black26,
                            ),
                            color: Colors.redAccent,
                          ),
                          elevation: 2,
                        ),
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_forward_ios_outlined,
                          ),
                          iconSize: 14,
                          iconEnabledColor: Colors.yellow,
                          iconDisabledColor: Colors.grey,
                        ),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.redAccent,
                          ),
                          offset: const Offset(-20, 0),
                          scrollbarTheme: ScrollbarThemeData(
                            radius: const Radius.circular(40),
                            thickness: MaterialStateProperty.all(6),
                            thumbVisibility: MaterialStateProperty.all(true),
                          ),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          padding: EdgeInsets.only(left: 14, right: 14),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ReactiveDropdownButton2<int, ({int id, String value})>(
                      formControlName: 'input2',
                      valueAccessor: Drop(),
                      isExpanded: true,
                      inputDecoration: const InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        helperText: "",
                        helperStyle: TextStyle(height: 0.8),
                        errorStyle: TextStyle(height: 0.8),
                      ),
                      items: itemsRecord
                          .map(
                            (({int id, String value}) item) => DropdownItem<({int id, String value})>(
                          value: item,
                          child: Row(
                            children: [
                              const SizedBox.square(dimension: 40,),
                              Text(item.value),
                            ],
                          ),
                        ),
                      )
                          .toList(),
                      hint: Row(
                        children: [
                          const SizedBox.square(
                            dimension: 40,
                            child: icon,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: DefaultTextStyle.merge(
                              style: const TextStyle(
                                fontSize: 14.0,
                                height: 1.8,
                              ),
                              overflow: TextOverflow.ellipsis,
                              child: hint,
                            ),
                          ),
                        ],
                      ),
                      underline: const SizedBox.shrink(),
                      errorButtonStyleData: ButtonStyleData(
                        height: 48,
                        padding: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: Theme.of(context).colorScheme.error),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                      buttonStyleData: ButtonStyleData(
                        height: 48,
                        padding: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: const Color(0xFFBCC2CE)),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(Icons.arrow_drop_down),
                        iconEnabledColor: Colors.black,
                        iconDisabledColor: Colors.grey,
                        openMenuIcon: Icon(Icons.arrow_drop_up),
                      ),
                      errorBuilder: (_, error) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          error,
                          style: const TextStyle(height: 0.8),
                        ),
                      ),
                      disabledHint: Row(
                        children: [
                          SizedBox.square(
                            dimension: 24,
                            child: Builder(
                              builder: (context) {
                                final color =
                                    DefaultTextStyle.of(context).style.color;


                                return IconTheme(
                                  data: IconTheme.of(context).copyWith(
                                    color: color,
                                    size: 16,
                                  ),
                                  child: icon,
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(''),
                        ],
                      ),
                      selectedItemBuilder: (_) {
                        return items.map(
                          (value) {
                            return DropdownMenuItem<String>(
                              alignment: Alignment.centerLeft,
                              value: value,
                              child: Row(
                                children: [
                                  SizedBox.square(
                                    dimension: 40,
                                    child: Center(
                                      child: Builder(
                                        builder: (context) {
                                          final color =
                                              DefaultTextStyle.of(context)
                                                  .style
                                                  .color;

                                          return IconTheme(
                                            data:
                                                IconTheme.of(context).copyWith(
                                              color: color,
                                              size: 24,
                                            ),
                                            child: icon,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      value,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ).toList();
                      },
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.zero,
                        maxHeight: 300,
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 0),
                      ),
                    ),
                    const SizedBox(height: 16),
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
    );
  }
}
