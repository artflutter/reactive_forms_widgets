import 'package:flutter/material.dart';
import 'package:reactive_phone_form_field/reactive_phone_form_field.dart';

class PhoneValidationMessage {
  static const String required = 'phone.required';
  static const String invalidPhoneNumber = 'phone.invalidPhoneNumber';
  static const String invalidCountry = 'phone.invalidCountry';
  static const String invalidMobilePhoneNumber =
      'phone.invalidMobilePhoneNumber';
  static const String invalidFixedLinePhoneNumber =
      'phone.invalidFixedLinePhoneNumber';

  static Map<String, String Function(Object)> localizedValidationMessages(
    BuildContext context,
  ) {
    final localizations = PhoneFieldLocalization.of(context);
    return {
      PhoneValidationMessage.required: (error) =>
          localizations.requiredPhoneNumber,
      PhoneValidationMessage.invalidCountry: (error) =>
          localizations.invalidCountry,
      PhoneValidationMessage.invalidFixedLinePhoneNumber: (error) =>
          localizations.invalidFixedLinePhoneNumber,
      PhoneValidationMessage.invalidMobilePhoneNumber: (error) =>
          localizations.invalidMobilePhoneNumber,
      PhoneValidationMessage.invalidPhoneNumber: (error) =>
          localizations.invalidPhoneNumber,
    };
  }
}
