import 'package:language_picker/languages.dart';
import 'package:reactive_forms/reactive_forms.dart';

abstract class LanguageValueAccessor<T>
    extends ControlValueAccessor<T, Language> {}

class LanguageCodeValueAccessor extends LanguageValueAccessor<String> {
  @override
  Language? modelToViewValue(String? modelValue) {
    if (modelValue == null) return null;
    return Language.fromIsoCode(modelValue);
  }

  @override
  String? viewToModelValue(Language? viewValue) {
    return viewValue?.isoCode;
  }
}
