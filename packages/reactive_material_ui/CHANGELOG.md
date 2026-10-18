## 1.0.0

* Initial release.
* Ports the Material input widgets of `reactive_forms` 18.2.2 on top of
  [`material_ui`](https://pub.dev/packages/material_ui) 1.7.0:
  `ReactiveMaterialTextField`, `ReactiveMaterialDropdownField`,
  `ReactiveMaterialCheckbox`, `ReactiveMaterialCheckboxListTile`,
  `ReactiveMaterialRadio`, `ReactiveMaterialRadioListTile`,
  `ReactiveMaterialSwitch`, `ReactiveMaterialSwitchListTile`,
  `ReactiveMaterialSlider`, `ReactiveMaterialDatePicker`,
  `ReactiveMaterialTimePicker` and `MaterialTimeOfDayValueAccessor`.
* Support `reactive_forms: 18.x`.
* Uses only the non-deprecated `material_ui` APIs: switches take
  `activeThumbColor` instead of `activeColor`, radios are driven by a
  `RadioGroup`, and the dropdown passes the control value as `initialValue`.
