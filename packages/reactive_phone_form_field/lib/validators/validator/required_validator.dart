import 'package:phone_form_field/phone_form_field.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_phone_form_field/validators/validation_message.dart';

class RequiredPhoneValidator extends Validator<dynamic> {
  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    final error = <String, dynamic>{PhoneValidationMessage.required: true};

    if (control.value == null) {
      return error;
    }

    PhoneNumber? valueCandidate = control.value as PhoneNumber;

    if (PhoneValidator.required().call(valueCandidate) == null) {
      return null;
    } else {
      return error;
    }
  }
}
