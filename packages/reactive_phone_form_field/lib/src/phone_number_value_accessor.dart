import 'package:phone_form_field/phone_form_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Assigns `null` in case if there is no phone number present
///
class PhoneNumberValueAccessor extends ControlValueAccessor<PhoneNumber, PhoneNumber> {
  @override
  PhoneNumber? modelToViewValue(PhoneNumber? modelValue) {
    return modelValue;
  }

  @override
  PhoneNumber? viewToModelValue(PhoneNumber? viewValue) {
    return (viewValue?.nsn == '' || viewValue == null)
        ? null
        : viewValue;
  }
}