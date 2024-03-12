import 'package:phone_form_field/phone_form_field.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_phone_form_field/src/validators/validation_message.dart';

class ValidFixedLinePhoneValidator extends Validator<dynamic> {
  const ValidFixedLinePhoneValidator();

  static const message = 'phone.validFixedLine';

  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    final error = <String, dynamic>{ message: true };

    final value = control.value;

    if(value is! PhoneNumber?) {
      return error;
    }

    if (
        value.nsn.isNotEmpty &&
        !valueCandidate.isValid(type: expectedType)) {
      if (expectedType == PhoneNumberType.mobile) {
        return errorText ??
            PhoneFieldLocalization.of(context).invalidMobilePhoneNumber;
      } else if (expectedType == PhoneNumberType.fixedLine) {
        return errorText ??
            PhoneFieldLocalization.of(context).invalidFixedLinePhoneNumber;
      }
      return errorText ??
          PhoneFieldLocalization.of(context).invalidPhoneNumber;
    }
    return null;

    // if (value == null) {
    //   return null;
    // } else if (control.value is PhoneNumber) {
    //   PhoneNumber? valueCandidate = control.value as PhoneNumber;
    //
    //   if (PhoneValidator.validFixedLine().call(valueCandidate) == null) {
    //     return null;
    //   } else {
    //     return error;
    //   }
    // }

    return null;
  }
}
