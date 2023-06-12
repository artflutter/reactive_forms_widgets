import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_phone_form_field/validators/validator/required_validator.dart';
import 'package:reactive_phone_form_field/validators/validator/valid_fixed_line_validator.dart';
import 'package:reactive_phone_form_field/validators/validator/valid_mobile_validator.dart';
import 'package:reactive_phone_form_field/validators/validator/valid_validator.dart';

/// Provides a set of built-in validators that can be used by form controls.
class PhoneValidators {
  /// Gets a validator that requires the control have a non-empty value.
  static Validator<dynamic> get required => RequiredPhoneValidator();

  /// Gets a validator that requires the control's value pass an phone
  /// validation test.
  static Validator<dynamic> get valid => ValidPhoneValidator();

  /// Gets a validator that requires the control's value pass a fixed line phone
  /// validation test.
  static Validator<dynamic> get validFixedLine =>
      ValidFixedLinePhoneValidator();

  /// Gets a validator that requires the control's value pass a mobile phone
  /// validation test.
  static Validator<dynamic> get validMobile => ValidMobilePhoneValidator();
}
