import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_phone_form_field/reactive_phone_form_field.dart';

class CountryPhoneValidator extends Validator<PhoneNumber> {
  final Set<IsoCode> allowedCountries;

  const CountryPhoneValidator({
    required this.allowedCountries,
  });

  @override
  Map<String, Object>? validate(AbstractControl<PhoneNumber> control) {
    final value = control.value;

    if (value == null || value.nsn.trim().isEmpty) return null;

    if (!allowedCountries.contains(value.isoCode)) {
      return {PhoneValidationMessage.invalidCountry: allowedCountries};
    }

    return null;
  }
}
