import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_phone_form_field/reactive_phone_form_field.dart';

class RequiredPhoneValidator extends Validator<PhoneNumber> {
  const RequiredPhoneValidator();

  @override
  Map<String, Object>? validate(AbstractControl<PhoneNumber> control) {
    final value = control.value;

    if (value == null || value.nsn.trim().isEmpty) {
      return {PhoneValidationMessage.required: true};
    }

    return null;
  }
}
