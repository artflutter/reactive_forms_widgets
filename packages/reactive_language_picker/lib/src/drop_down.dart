import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_language_picker/reactive_language_picker.dart';

/// A [ReactiveLanguagePickerDropdown] that contains a [LanguagePicker].
///
/// This is a convenience widget that wraps a [LanguagePicker] widget in a
/// [ReactiveLanguagePickerDropdown].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveLanguagePickerDropdown<T> extends ReactiveFormField<T, Language> {
  /// Creates a [ReactiveLanguagePickerDropdown] that contains a [LanguagePickerDropdown].
  ///
  /// Can optionally provide a [formControl] to bind this widget to a control.
  ///
  /// Can optionally provide a [formControlName] to bind this ReactiveFormField
  /// to a [FormControl].
  ///
  /// Must provide one of the arguments [formControl] or a [formControlName],
  /// but not both at the same time.
  ///
  /// Can optionally provide a [validationMessages] argument to customize a
  /// message for different kinds of validation errors.
  ///
  /// Can optionally provide a [valueAccessor] to set a custom value accessors.
  /// See [ControlValueAccessor].
  ///
  /// Can optionally provide a [showErrors] function to customize when to show
  /// validation messages. Reactive Widgets make validation messages visible
  /// when the control is INVALID and TOUCHED, this behavior can be customized
  /// in the [showErrors] function.
  ///
  /// ### Example:
  /// Binds a text field.
  /// ```
  /// final form = fb.group({'language': Validators.required});
  ///
  /// ReactiveLanguagePickerDropdown(
  ///   formControlName: 'language',
  /// ),
  ///
  /// ```
  ///
  /// Binds directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'language': Validators.required});
  ///
  /// ReactiveLanguagePickerDropdown(
  ///   formControl: form.control('language'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveLanguagePickerDropdown(
  ///   formControlName: 'language',
  ///   validationMessages: {
  ///     ValidationMessage.required: 'The language is required',
  ///   }
  /// ),
  /// ```
  ///
  /// Customize when to show up validation messages.
  /// ```dart
  /// ReactiveLanguagePickerDropdown(
  ///   formControlName: 'language',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [LanguagePicker] class
  /// and [LanguagePicker], the constructor.
  ReactiveLanguagePickerDropdown({
    super.key,
    super.formControlName,
    super.formControl,
    super.validationMessages,
    super.valueAccessor,
    super.showErrors,
    super.focusNode,

    ///This function will be called to build the child of DropdownMenuItem
    ///If it is not provided, default one will be used which displays
    ///flag image, isoCode and phoneCode in a row.
    ///Check _buildDefaultMenuItem method for details.
    ItemBuilder? itemBuilder,

    ///Preselected language.
    Language? initialValue,

    ///This function will be called whenever a Language item is selected.
    ValueChanged<Language?>? onValuePicked,

    /// An optional controller.
    LanguagePickerDropdownController? controller,

    /// List of languages available in this picker.
    List<Language>? languages,
  }) : super(
          builder: (field) {
            final value = field.value;
            // TODO(ahmednfwela): should pass `key: UniqueKey()` 
            // see https://github.com/atn832/language_picker/issues/5
            return LanguagePickerDropdown(
              controller: controller,
              initialValue: value,
              itemBuilder: itemBuilder,
              languages: languages,
              onValuePicked: (value) {
                field.didChange(value);
                onValuePicked?.call(value);
              },
            );
          },
        );
}
