library reactive_dropdown_search;

// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

abstract class DropDownSearchValueAccessor<T, V> {
  DropDownSearchValueAccessor();

  V? modelToViewValue(List<V> items, T? modelValue);

  T? viewToModelValue(List<V> items, V? modelValue);
}

class _DropDownSearchValueAccessor<T, V> extends ControlValueAccessor<T, V> {
  final DropdownSearchOnFind<V>? items;

  final DropDownSearchValueAccessor<T, V> dropDownValueAccessor;

  _DropDownSearchValueAccessor({
    this.items,
    required this.dropDownValueAccessor,
  });

  @override
  V? modelToViewValue(T? modelValue) {
    final result = items?.call('', null) ?? [];
    if (result is List<V>) {
      return dropDownValueAccessor.modelToViewValue(result, modelValue);
    }

    throw UnsupportedError('Asynchronously fetched values are not supported');
  }

  @override
  T? viewToModelValue(V? viewValue) {
    final result = items?.call('', null) ?? [];

    if (result is List<V>) {
      return dropDownValueAccessor.viewToModelValue(result, viewValue);
    }

    throw UnsupportedError('Asynchronously fetched values are not supported');
  }
}

/// A [ReactiveDropdownSearch] that contains a [DropdownSearch].
///
/// This is a convenience widget that wraps a [DropdownSearch] widget in a
/// [ReactiveDropdownSearch].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveDropdownSearch<T, V> extends ReactiveFormField<T, V> {
  /// Creates a [ReactiveDropdownSearch] that contains a [DropdownSearch].
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
  /// ReactiveDropdownSearch(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveDropdownSearch(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveDropdownSearch(
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
  /// ReactiveDropdownSearch(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [DropdownSearch] class
  /// and [DropdownSearch], the constructor.
  ReactiveDropdownSearch({
    super.key,
    Key? widgetKey,
    super.formControlName,
    super.formControl,
    super.validationMessages,
    DropDownSearchValueAccessor<T, V>? valueAccessor,
    super.showErrors,

    ////////////////////////////////////////////////////////////////////////////
    DropdownSearchOnFind<V>? items,
    PopupProps<V> popupProps = const PopupProps.menu(),
    DropdownSearchBuilder<V>? dropdownBuilder,
    DropdownSearchFilterFn<V>? filterFn,
    DropdownSearchItemAsString<V>? itemAsString,
    DropdownSearchCompareFn<V>? compareFn,
    Mode mode = Mode.form,
    DropdownSuffixProps suffixProps = const DropdownSuffixProps(),
    ClickProps clickProps = const ClickProps(),
    BeforeChange<V?>? onBeforeChange,
    FormFieldSetter<V>? onSaved,
    DropDownDecoratorProps dropdownDecoratorProps =
        const DropDownDecoratorProps(),
    BeforePopupOpening<V>? onBeforePopupOpening,
    Widget Function(BuildContext context, String error)? errorBuilder,
  }) : super(
          valueAccessor: valueAccessor != null
              ? _DropDownSearchValueAccessor(
                  items: items,
                  dropDownValueAccessor: valueAccessor,
                )
              : null,
          builder: (field) {
            final effectiveDecoration = dropdownDecoratorProps.decoration
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);

            final errorText = field.errorText;

            return DropdownSearch<V>(
              key: widgetKey,
              onChanged: field.didChange,
              popupProps: popupProps,
              selectedItem: field.value,
              dropdownBuilder: dropdownBuilder,
              enabled: field.control.enabled,
              filterFn: filterFn,
              itemAsString: itemAsString,
              compareFn: compareFn,
              mode: mode,
              onSaved: onSaved,
              onBeforeChange: onBeforeChange,
              onBeforePopupOpening: onBeforePopupOpening,
              decoratorProps: DropDownDecoratorProps(
                decoration: effectiveDecoration.copyWith(
                  errorText: errorBuilder == null ? errorText : null,
                  error: errorBuilder != null && errorText != null
                      ? DefaultTextStyle.merge(
                          style: Theme.of(field.context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                color:
                                    Theme.of(field.context).colorScheme.error,
                              )
                              .merge(effectiveDecoration.errorStyle),
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
              suffixProps: suffixProps,
              clickProps: clickProps,
              items: items,
            );
          },
        );
}
