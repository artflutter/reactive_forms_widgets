library reactive_dropdown_search;

// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// A [ReactiveDropdownSearchMultiSelection] that contains a [DropdownSearch].
///
/// This is a convenience widget that wraps a [DropdownSearch] widget in a
/// [ReactiveDropdownSearchMultiSelection].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveDropdownSearchMultiSelection<T, V>
    extends ReactiveFormField<List<T>, List<V>> {
  /// Creates a [ReactiveDropdownSearchMultiSelection] that contains a [DropdownSearch].
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
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveDropdownSearchMultiSelection(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveDropdownSearchMultiSelection(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveDropdownSearchMultiSelection(
  ///   formControlName: 'email',
  ///   validationMessages: {
  ///     ValidationMessage.required: 'The email must not be empty',
  ///     ValidationMessage.email: 'The email must be a valid email',
  ///   }
  /// ),
  /// ```
  ///
  /// Customize when to show up validation messages.
  /// ```dart
  /// ReactiveDropdownSearchMultiSelection(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [DropdownSearch] class
  /// and [DropdownSearch], the constructor.
  ReactiveDropdownSearchMultiSelection({
    super.key,
    Key? widgetKey,
    super.formControlName,
    super.formControl,
    super.validationMessages,
    super.valueAccessor,
    super.showErrors,

    ////////////////////////////////////////////////////////////////////////////
    DropdownSearchOnFind<V>? items,
    DropdownSearchBuilderMultiSelection<V>? dropdownBuilder,
    DropdownSearchFilterFn<V>? filterFn,
    DropdownSearchItemAsString<V>? itemAsString,
    DropdownSearchCompareFn<V>? compareFn,
    PopupPropsMultiSelection<V> popupProps =
        const PopupPropsMultiSelection.menu(),
    ScrollProps? selectedItemsScrollProps,
    BeforeChangeMultiSelection<V?>? onBeforeChange,
    FormFieldSetter<List<V>>? onSaved,
    DropdownSuffixProps suffixProps = const DropdownSuffixProps(),
    ClickProps clickProps = const ClickProps(),
    DropDownDecoratorProps dropdownDecoratorProps =
        const DropDownDecoratorProps(),
    BeforePopupOpeningMultiSelection<V>? onBeforePopupOpening,
  }) : super(
          builder: (field) {
            final effectiveDecoration = dropdownDecoratorProps.decoration
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);

            return DropdownSearch<V>.multiSelection(
              key: widgetKey,
              onChanged: (value) =>
                  field.didChange(value.isEmpty ? null : value),
              popupProps: popupProps,
              selectedItems: field.value ?? [],
              items: items,
              selectedItemsScrollProps: selectedItemsScrollProps,
              // asyncItems: asyncItems,
              suffixProps: suffixProps,
              clickProps: clickProps,
              dropdownBuilder: dropdownBuilder,
              enabled: field.control.enabled,
              filterFn: filterFn,
              itemAsString: itemAsString,
              compareFn: compareFn,
              decoratorProps: DropDownDecoratorProps(
                decoration:
                    effectiveDecoration.copyWith(errorText: field.errorText),
                baseStyle: dropdownDecoratorProps.baseStyle,
                textAlign: dropdownDecoratorProps.textAlign,
                textAlignVertical: dropdownDecoratorProps.textAlignVertical,
                expands: dropdownDecoratorProps.expands,
                isHovering: dropdownDecoratorProps.isHovering,
              ),
              onBeforeChange: onBeforeChange,
              onSaved: onSaved,
              onBeforePopupOpening: onBeforePopupOpening,
            );
          },
        );
}
