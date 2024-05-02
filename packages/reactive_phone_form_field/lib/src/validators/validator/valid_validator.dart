import 'package:phone_form_field/phone_form_field.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_phone_form_field/src/validators/validation_message.dart';

/// Validator that requires the control have a non-empty value.
class ValidPhoneValidator extends Validator<PhoneNumber> {
  const ValidPhoneValidator({this.type});

  final PhoneNumberType? type;

  @override
  Map<String, Object>? validate(AbstractControl<PhoneNumber> control) {
    final value = control.value;

    if (value == null || value.nsn.trim().isEmpty) return null;

    if (!value.isValid(type: type)) {
      final messageKey = switch (type) {
        PhoneNumberType.mobile =>
          PhoneValidationMessage.invalidMobilePhoneNumber,
        PhoneNumberType.fixedLine =>
          PhoneValidationMessage.invalidFixedLinePhoneNumber,
        _ => PhoneValidationMessage.invalidPhoneNumber,
      };

      return {
        messageKey: type ?? true,
      };
    }

    return null;
  }
}
