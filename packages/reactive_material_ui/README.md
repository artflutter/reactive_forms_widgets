# reactive_material_ui

Wrapper around [material_ui](https://pub.dev/packages/material_ui) input widgets to use with [`reactive_forms`](https://pub.dev/packages/reactive_forms).

## Why

Since Flutter 3.47 the Material library is published as the standalone official package [`material_ui`](https://pub.dev/packages/material_ui), and `package:flutter/material.dart` is going to be removed from the SDK.

The Material input widgets shipped by `reactive_forms` (`ReactiveTextField`, `ReactiveCheckbox`, ...) are still built on `package:flutter/material.dart`, which defines separate classes with the same names as `material_ui`. In an app that migrated to `package:material_ui`:

- the widgets throw `No Material widget found` at runtime, because the `Material` ancestor of the app is the one of `material_ui`;
- passing a `decoration` does not compile:

```
error • The argument type 'InputDecoration' can't be assigned to the
parameter type 'InputDecoration'.
 - one is from 'package:material_ui/src/input_decorator.dart'
 - the other from 'flutter/lib/src/material/input_decorator.dart'
```

See [joanpablo/reactive_forms#507](https://github.com/joanpablo/reactive_forms/issues/507).

This package provides the same widgets, with the same parameters, defaults and behavior as `reactive_forms` 18.2.2, but built on `package:material_ui`. Everything else (`ReactiveForm`, `ReactiveFormField`, `ReactiveFormArray`, `ReactiveFormConsumer`, models, validators, the other value accessors) keeps coming from `reactive_forms`, which exposes no Material types in those APIs.

## Installation

```yaml
dependencies:
  material_ui: ^1.7.0
  reactive_forms: ">=18.0.0 <19.0.0"
  reactive_material_ui: ^1.0.0
```

Requires Flutter `>=3.47.0` and Dart `^3.13.0` (the minimum versions of `material_ui`).

## Usage

```dart
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_material_ui/reactive_material_ui.dart';

final form = FormGroup({
  'email': FormControl<String>(validators: [Validators.required, Validators.email]),
  'acceptTerms': FormControl<bool>(value: false),
});

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: form,
      child: Column(
        children: [
          ReactiveMaterialTextField<String>(
            formControlName: 'email',
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          ReactiveMaterialCheckboxListTile(
            formControlName: 'acceptTerms',
            title: const Text('Accept terms'),
          ),
        ],
      ),
    );
  }
}
```

`reactive_material_ui` re-exports `package:material_ui/material_ui.dart` (like `reactive_macos_ui` re-exports `macos_ui`), so `InputDecoration`, `Text`, `TimeOfDay`, ... above come from `material_ui`. It does **not** re-export `reactive_forms`: import it yourself.

See the [`example`](https://github.com/artflutter/reactive_forms_widgets/tree/master/packages/reactive_material_ui/example) folder for every widget in action.

## Widgets

| reactive_forms | reactive_material_ui |
| --- | --- |
| `ReactiveTextField` | `ReactiveMaterialTextField` |
| `ReactiveDropdownField` | `ReactiveMaterialDropdownField` |
| `ReactiveCheckbox` | `ReactiveMaterialCheckbox` |
| `ReactiveCheckboxListTile` | `ReactiveMaterialCheckboxListTile` |
| `ReactiveRadio` | `ReactiveMaterialRadio` |
| `ReactiveRadioListTile` | `ReactiveMaterialRadioListTile` |
| `ReactiveSwitch` / `ReactiveSwitch.adaptive` | `ReactiveMaterialSwitch` / `ReactiveMaterialSwitch.adaptive` |
| `ReactiveSwitchListTile` / `ReactiveSwitchListTile.adaptive` | `ReactiveMaterialSwitchListTile` / `ReactiveMaterialSwitchListTile.adaptive` |
| `ReactiveSlider` | `ReactiveMaterialSlider` |
| `ReactiveSliderLabelBuilder` | `ReactiveMaterialSliderLabelBuilder` |
| `ReactiveDatePicker` | `ReactiveMaterialDatePicker` |
| `ReactiveDatePickerBuilder` | `ReactiveMaterialDatePickerBuilder` |
| `ReactiveDatePickerDelegate` | `ReactiveMaterialDatePickerDelegate` |
| `ReactiveTimePicker` | `ReactiveMaterialTimePicker` |
| `ReactiveTimePickerBuilder` | `ReactiveMaterialTimePickerBuilder` |
| `ReactiveTimePickerDelegate` | `ReactiveMaterialTimePickerDelegate` |
| `TimeOfDayValueAccessor` | `MaterialTimeOfDayValueAccessor` |

The names are prefixed so that both packages can be imported in the same file without conflicts.

`ReactiveMaterialTextField` automatically uses `MaterialTimeOfDayValueAccessor` for a `FormControl<TimeOfDay>` (the `TimeOfDay` of `material_ui`), exactly like `ReactiveTextField` does with `TimeOfDayValueAccessor`.

## Migration from reactive_forms Material widgets

1. Migrate the app from `package:flutter/material.dart` to `package:material_ui/material_ui.dart`.
2. Add `reactive_material_ui` and import `package:reactive_material_ui/reactive_material_ui.dart` next to `package:reactive_forms/reactive_forms.dart`.
3. Rename the widgets following the table above. Constructor parameters are the same.
4. `FormControl<TimeOfDay>` must use the `TimeOfDay` of `material_ui`. If you passed `TimeOfDayValueAccessor()` explicitly, replace it with `MaterialTimeOfDayValueAccessor()`.

Form models, validators and the non-Material widgets of `reactive_forms` stay unchanged.
