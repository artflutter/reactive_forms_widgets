library reactive_dropdown_search;

// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

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
    Key? key,
    String? formControlName,
    FormControl<T>? formControl,
    ValidationMessagesFunction? validationMessages,
    ControlValueAccessor<T, V>? valueAccessor,
    ShowErrorsFunction? showErrors,

    ////////////////////////////////////////////////////////////////////////////
    List<V> items = const [],
    PopupProps<V> popupProps = const PopupProps.menu(),
    DropdownSearchOnFind<V>? asyncItems,
    DropdownSearchBuilder<V>? dropdownBuilder,
    bool showClearButton = false,
    DropdownSearchFilterFn<V>? filterFn,
    DropdownSearchItemAsString<V>? itemAsString,
    DropdownSearchCompareFn<V>? compareFn,
    // InputDecoration? decoration,
    ClearButtonProps clearButtonProps = const ClearButtonProps(),
    DropdownButtonProps dropdownButtonProps = const DropdownButtonProps(),
    BeforeChange<V?>? onBeforeChange,
    TextAlign? dropdownSearchTextAlign,
    TextAlignVertical? dropdownSearchTextAlignVertical,
    FocusNode? focusNode,
    FormFieldSetter<V>? onSaved,
    TextStyle? dropdownSearchTextStyle,
    DropDownDecoratorProps dropdownDecoratorProps =
        const DropDownDecoratorProps(),
    BeforePopupOpening<V>? onBeforePopupOpening,
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

            final state = field as _ReactiveDropdownSearchState<T, V>;

            state._setFocusNode(focusNode);

            return DropdownSearch<V>(
              onChanged: field.didChange,
              popupProps: popupProps,
              selectedItem: field.value,
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
  ReactiveFormFieldState<T, V> createState() =>
      _ReactiveDropdownSearchState<T, V>();
}

class _ReactiveDropdownSearchState<T, V> extends ReactiveFormFieldState<T, V> {
  FocusNode? _focusNode;
  late FocusController _focusController;

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
