import 'package:inscruni_flutter/common/validator/phone/phone_validation_message.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ValidFixedLinePhoneValidator extends Validator<dynamic> {
  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    final error = <String, dynamic>{
      PhoneValidationMessage.validFixedLine: true
    };

    if (control.value == null) {
      return null;
    } else if (control.value is PhoneNumber) {
      PhoneNumber? valueCandidate = control.value as PhoneNumber;

      if (PhoneValidator.validFixedLine().call(valueCandidate) == null) {
        return null;
      } else {
        return error;
      }
    }

    return null;
  }
}
