import 'package:phone_form_field/phone_form_field.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_phone_form_field/src/validators/validation_message.dart';

/// Validator that requires the control have a non-empty value.
class ValidPhoneValidator extends Validator<dynamic> {
  const ValidPhoneValidator();

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    final error = <String, dynamic>{PhoneValidationMessage.valid: true};

    if (control.value == null) {
      return null;
    } else if (control.value is PhoneNumber) {
      PhoneNumber? valueCandidate = control.value as PhoneNumber;

      if (PhoneValidator.valid().call(valueCandidate) == null) {
        return null;
      } else {
        return error;
      }
    }

    return null;
  }
}
