library reactive_dropdown_search;

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

abstract class DropDownSearchMultiSelectionValueAccessor<T, V> {
  DropDownSearchMultiSelectionValueAccessor();

  List<V>? modelToViewValue(List<V> items, List<T>? modelValue);

  List<T>? viewToModelValue(List<V> items, List<V>? modelValue);
}

class _DropDownSearchMultiSelectionValueAccessor<T, V>
    extends ControlValueAccessor<List<T>, List<V>> {
  final DropdownSearchOnFind<V>? items;

  final DropDownSearchMultiSelectionValueAccessor<T, V> dropDownValueAccessor;

  _DropDownSearchMultiSelectionValueAccessor({
    this.items,
    required this.dropDownValueAccessor,
  });

  @override
  List<V>? modelToViewValue(List<T>? modelValue) {
    final result = items?.call('', null) ?? [];
    if (result is List<V>) {
      return dropDownValueAccessor.modelToViewValue(result, modelValue);
    }

    throw UnsupportedError('Asynchronously fetched values are not supported');
  }

  @override
  List<T>? viewToModelValue(List<V>? viewValue) {
    final result = items?.call('', null) ?? [];

    if (result is List<V>) {
      return dropDownValueAccessor.viewToModelValue(result, viewValue);
    }

    throw UnsupportedError('Asynchronously fetched values are not supported');
  }
}

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
    DropDownSearchMultiSelectionValueAccessor<T, V>? valueAccessor,
    super.showErrors,

    ////////////////////////////////////////////////////////////////////////////
    DropdownSearchOnFind<V>? items,
    DropdownSearchBuilderMultiSelection<V>? dropdownBuilder,
    DropdownSearchFilterFn<V>? filterFn,
    DropdownSearchItemAsString<V>? itemAsString,
    DropdownSearchCompareFn<V>? compareFn,
    MultiSelectionPopupProps<V> popupProps =
        const MultiSelectionPopupProps.menu(),
    ScrollProps? selectedItemsScrollProps,
    BeforeChangeMultiSelection<V?>? onBeforeChange,
    FormFieldSetter<List<V>>? onSaved,
    DropdownSuffixProps suffixProps = const DropdownSuffixProps(),
    ClickProps clickProps = const ClickProps(),
    DropDownDecoratorProps dropdownDecoratorProps =
        const DropDownDecoratorProps(),
    BeforePopupOpeningMultiSelection<V>? onBeforePopupOpening,
    Widget Function(BuildContext context, String error)? errorBuilder,
  }) : super(
          valueAccessor: valueAccessor != null
              ? _DropDownSearchMultiSelectionValueAccessor(
                  items: items,
                  dropDownValueAccessor: valueAccessor,
                )
              : null,
          builder: (field) {
            final effectiveDecoration = dropdownDecoratorProps.decoration?.applyDefaults(Theme.of(field.context).inputDecorationTheme);

            final errorText = field.errorText;
            final x = Stack();

            return DropdownSearch<V>.multiSelection(
              key: widgetKey,
              onSelected: (value) =>
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
                decoration: effectiveDecoration?.copyWith(
                  errorText: errorBuilder == null ? errorText : null,
                  error: errorBuilder != null && errorText != null
                      ? DefaultTextStyle.merge(
                    style: Theme.of(field.context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(
                      color:
                      Theme.of(field.context).colorScheme.error,
                    ).merge(effectiveDecoration.errorStyle),
                    maxLines: effectiveDecoration.errorMaxLines,
                    child: errorBuilder.call(
                      field.context,
                      errorText,
                    ),
                  )
                      : null,
                ),
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
