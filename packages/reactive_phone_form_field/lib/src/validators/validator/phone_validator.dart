import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';

typedef PhoneNumberInputValidator = String? Function(PhoneNumber? phoneNumber);

abstract class PhoneValidator {
  /// allow to compose several validators
  /// Note that validator list order is important as first
  /// validator failing will return according message.
  static PhoneNumberInputValidator compose(
      List<PhoneNumberInputValidator> validators,
      ) {
    return (valueCandidate) {
      for (var validator in validators) {
        final validatorResult = validator.call(valueCandidate);
        if (validatorResult != null) {
          return validatorResult;
        }
      }
      return null;
    };
  }

  static PhoneNumberInputValidator required(
      {
        /// custom error message
        String? errorText,
      }) {
    return (PhoneNumber? valueCandidate) {
      if (valueCandidate == null || (valueCandidate.nsn.trim().isEmpty)) {
        return errorText;
      }
      return null;
    };
  }

  static PhoneNumberInputValidator valid(
      BuildContext context, {
        /// custom error message
        String? errorText,
      }) {
    return (PhoneNumber? valueCandidate) {
      if (valueCandidate != null &&
          valueCandidate.nsn.isNotEmpty &&
          !valueCandidate.isValid()) {
        return errorText ??
            PhoneFieldLocalization.of(context).invalidPhoneNumber;
      }
      return null;
    };
  }

  static PhoneNumberInputValidator validType(
      BuildContext context,

      /// expected phonetype
      PhoneNumberType expectedType, {
        /// custom error message
        String? errorText,
      }) {
    return (PhoneNumber? valueCandidate) {
      if (valueCandidate != null &&
          valueCandidate.nsn.isNotEmpty &&
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
    };
  }

  /// convenience shortcut method for
  /// invalidType(context, PhoneNumberType.fixedLine, ...)
  static PhoneNumberInputValidator validFixedLine(
      BuildContext context, {
        /// custom error message
        String? errorText,
      }) =>
      validType(
        context,
        PhoneNumberType.fixedLine,
        errorText: errorText,
      );

  /// convenience shortcut method for
  /// invalidType(context, PhoneNumberType.mobile, ...)
  static PhoneNumberInputValidator validMobile(
      BuildContext context, {
        /// custom error message
        String? errorText,
      }) =>
      validType(
        context,
        PhoneNumberType.mobile,
        errorText: errorText,
      );

  static PhoneNumberInputValidator validCountry(
      BuildContext context,

      /// list of valid country isocode
      List<IsoCode> expectedCountries, {
        /// custom error message
        String? errorText,
      }) {
    return (PhoneNumber? valueCandidate) {
      if (valueCandidate != null &&
          (valueCandidate.nsn.isNotEmpty) &&
          !expectedCountries.contains(valueCandidate.isoCode)) {
        return errorText ?? PhoneFieldLocalization.of(context).invalidCountry;
      }
      return null;
    };
  }

  @Deprecated('Use null instead')
  static PhoneNumberInputValidator get none => (PhoneNumber? valueCandidate) {
    return null;
  };
}
