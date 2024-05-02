import 'package:phone_form_field/phone_form_field.dart';
import 'package:reactive_phone_form_field/src/validators/validator/required_validator.dart';
import 'package:reactive_phone_form_field/src/validators/validator/valid_validator.dart';

import 'validator/country_phone_validator.dart';

/// Provides a set of built-in validators that can be used by form controls.
class PhoneValidators {
  /// Gets a validator that requires the control have a non-empty value.
  static RequiredPhoneValidator get required => const RequiredPhoneValidator();

  /// Gets a validator that requires the control's value pass an phone
  /// validation test.
  static ValidPhoneValidator get valid => const ValidPhoneValidator();

  /// Gets a validator that requires the control's value pass an phone
  /// validation test.
  static CountryPhoneValidator forCountries({
    required Set<IsoCode> allowedCountries,
  }) =>
      CountryPhoneValidator(allowedCountries: allowedCountries);

  /// Gets a validator that requires the control's value pass a fixed line phone
  /// validation test.
  static ValidPhoneValidator get validFixedLine =>
      const ValidPhoneValidator(type: PhoneNumberType.fixedLine);

  /// Gets a validator that requires the control's value pass a mobile phone
  /// validation test.
  static ValidPhoneValidator get validMobile =>
      const ValidPhoneValidator(type: PhoneNumberType.mobile);
}
