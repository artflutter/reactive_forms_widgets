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
    Key? key,
    String? formControlName,
    FormControl<List<T>>? formControl,
    Map<String, ValidationMessageFunction>? validationMessages,
    ControlValueAccessor<List<T>, List<V>>? valueAccessor,
    ShowErrorsFunction<List<T>>? showErrors,

    ////////////////////////////////////////////////////////////////////////////
    List<V> items = const [],
    PopupPropsMultiSelection<V> popupProps =
        const PopupPropsMultiSelection.menu(),
    DropdownSearchOnFind<V>? asyncItems,
    DropdownSearchBuilderMultiSelection<V>? dropdownBuilder,
    bool showClearButton = false,
    DropdownSearchFilterFn<V>? filterFn,
    DropdownSearchItemAsString<V>? itemAsString,
    DropdownSearchCompareFn<V>? compareFn,
    ClearButtonProps clearButtonProps = const ClearButtonProps(),
    DropdownButtonProps dropdownButtonProps = const DropdownButtonProps(),
    BeforeChangeMultiSelection<V?>? onBeforeChange,
    TextAlign? dropdownSearchTextAlign,
    TextAlignVertical? dropdownSearchTextAlignVertical,
    FocusNode? focusNode,
    FormFieldSetter<List<V>>? onSaved,
    TextStyle? dropdownSearchTextStyle,
    DropDownDecoratorProps dropdownDecoratorProps =
        const DropDownDecoratorProps(),
    BeforePopupOpeningMultiSelection<V>? onBeforePopupOpening,
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          valueAccessor: valueAccessor,
          validationMessages: validationMessages,
          showErrors: showErrors,
          builder: (field) {
            final effectiveDecoration = (dropdownDecoratorProps
                        .dropdownSearchDecoration ??
                    const InputDecoration())
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);

            final state = field
                as _ReactiveDropdownSearchMultiSelectionState<List<T>, List<V>>;

            state._setFocusNode(focusNode);

            return DropdownSearch<V>.multiSelection(
              onChanged: (value) =>
                  field.didChange(value.isEmpty ? null : value),
              popupProps: popupProps,
              selectedItems: field.value ?? [],
              items: items,
              asyncItems: asyncItems,
              dropdownBuilder: dropdownBuilder,
              enabled: field.control.enabled,
              filterFn: filterFn,
              itemAsString: itemAsString,
              compareFn: compareFn,
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration:
                    effectiveDecoration.copyWith(errorText: field.errorText),
                baseStyle: dropdownDecoratorProps.baseStyle,
                textAlign: dropdownDecoratorProps.textAlign,
                textAlignVertical: dropdownDecoratorProps.textAlignVertical,
              ),
              clearButtonProps: clearButtonProps,
              dropdownButtonProps: dropdownButtonProps,
              onBeforeChange: onBeforeChange,
              onSaved: onSaved,
              onBeforePopupOpening: onBeforePopupOpening,
            );
          },
        );

  @override
  ReactiveFormFieldState<List<T>, List<V>> createState() =>
      _ReactiveDropdownSearchMultiSelectionState<List<T>, List<V>>();
}

class _ReactiveDropdownSearchMultiSelectionState<T, V>
    extends ReactiveFormFieldState<T, V> {
  FocusNode? _focusNode;
  late FocusController _focusController;

  @override
  FocusNode get focusNode => _focusNode ?? _focusController.focusNode;

  @override
  void subscribeControl() {
    _registerFocusController(FocusController());
    super.subscribeControl();
  }

  @override
  void unsubscribeControl() {
    _unregisterFocusController();
    super.unsubscribeControl();
  }

  void _registerFocusController(FocusController focusController) {
    _focusController = focusController;
    control.registerFocusController(focusController);
  }

  void _unregisterFocusController() {
    control.unregisterFocusController(_focusController);
    _focusController.dispose();
  }

  void _setFocusNode(FocusNode? focusNode) {
    if (_focusNode != focusNode) {
      _focusNode = focusNode;
      _unregisterFocusController();
      _registerFocusController(FocusController(focusNode: _focusNode));
    }
  }
}
