import 'package:phone_form_field/phone_form_field.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_phone_form_field/src/validators/validation_message.dart';

class RequiredPhoneValidator extends Validator<dynamic> {
  const RequiredPhoneValidator();

  static const message = 'phone.required';

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    final error = <String, dynamic>{message: true};
    final value = control.value;

    if(value is! PhoneNumber?) {
      return error;
    }

    if (value == null || (value.nsn.trim().isEmpty)) {
      return error;
    }

    return null;
  }
}
