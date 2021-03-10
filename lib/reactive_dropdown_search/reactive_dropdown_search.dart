// Copyright 2020 Joan Pablo Jiménez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

enum ReactiveDropdownSearchMode { DIALOG, BOTTOM_SHEET, MENU }

extension ReactiveDropdownSearchModeExt on ReactiveDropdownSearchMode {
  Mode get dropdownMode {
    switch (this) {
      case ReactiveDropdownSearchMode.DIALOG:
        return Mode.DIALOG;
      case ReactiveDropdownSearchMode.BOTTOM_SHEET:
        return Mode.BOTTOM_SHEET;
      case ReactiveDropdownSearchMode.MENU:
        return Mode.MENU;
    }

    return Mode.MENU;
  }
}

/// A [ReactiveDropdownSearch] that contains a [DropdownSearch].
///
/// This is a convenience widget that wraps a [DropdownSearch] widget in a
/// [ReactiveDropdownSearch].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveDropdownSearch<T> extends ReactiveFormField<T> {
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
  /// and [new DropdownSearch], the constructor.
  ReactiveDropdownSearch({
    Key key,
    String formControlName,
    FormControl formControl,
    ValidationMessagesFunction validationMessages,
    ControlValueAccessor valueAccessor,
    ShowErrorsFunction showErrors,
    ReactiveDropdownSearchMode mode = ReactiveDropdownSearchMode.DIALOG,
    String label,
    String hint,
    bool isFilteredOnline = false,
    Widget popupTitle,
    List<T> items,
    DropdownSearchOnFind<T> onFind,
    DropdownSearchBuilder<T> dropdownBuilder,
    DropdownSearchPopupItemBuilder<T> popupItemBuilder,
    bool showSearchBox = false,
    bool showClearButton = false,
    InputDecoration searchBoxDecoration,
    Color popupBackgroundColor,
    double maxHeight,
    DropdownSearchFilterFn<T> filterFn,
    DropdownSearchItemAsString<T> itemAsString,
    bool showSelectedItem = false,
    DropdownSearchCompareFn<T> compareFn,
    InputDecoration decoration,
    EmptyBuilder emptyBuilder,
    LoadingBuilder loadingBuilder,
    ErrorBuilder errorBuilder,
    bool showAsSuffixIcons = false,
    bool autoFocusSearchBox = false,
    double dialogMaxWidth,
    Widget clearButton,
    IconButtonBuilder clearButtonBuilder,
    Widget dropDownButton,
    IconButtonBuilder dropdownButtonBuilder,
    bool dropdownBuilderSupportsNullItem = false,
    ShapeBorder popupShape,
    VoidCallback onPopupDismissed,
    DropdownSearchPopupItemEnabled<T> popupItemDisabled,
    Color popupBarrierColor,
    TextEditingController searchBoxController,
    Duration searchDelay,
    BeforeChange<T> onBeforeChange,
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          valueAccessor: valueAccessor,
          validationMessages: validationMessages,
          showErrors: showErrors,
          builder: (ReactiveFormFieldState field) {
            final InputDecoration effectiveDecoration = (decoration ??
                    const InputDecoration())
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);

            return DropdownSearch<T>(
              onChanged: field.didChange,
              mode: mode.dropdownMode,
              label: label,
              hint: hint,
              isFilteredOnline: isFilteredOnline,
              popupTitle: popupTitle,
              items: items,
              selectedItem: field.value,
              onFind: onFind,
              dropdownBuilder: dropdownBuilder,
              popupItemBuilder: popupItemBuilder,
              showSearchBox: showSearchBox,
              showClearButton: showClearButton,
              searchBoxDecoration: searchBoxDecoration,
              popupBackgroundColor: popupBackgroundColor,
              enabled: field.control.enabled,
              maxHeight: maxHeight,
              filterFn: filterFn,
              itemAsString: itemAsString,
              showSelectedItem: showSelectedItem,
              compareFn: compareFn,
              dropdownSearchDecoration:
                  effectiveDecoration.copyWith(errorText: field.errorText),
              emptyBuilder: emptyBuilder,
              loadingBuilder: loadingBuilder,
              errorBuilder: errorBuilder,
              autoFocusSearchBox: autoFocusSearchBox,
              dialogMaxWidth: dialogMaxWidth,
              clearButton: clearButton,
              clearButtonBuilder: clearButtonBuilder,
              dropDownButton: dropDownButton,
              dropdownButtonBuilder: dropdownButtonBuilder,
              dropdownBuilderSupportsNullItem: dropdownBuilderSupportsNullItem,
              popupShape: popupShape,
              showAsSuffixIcons: showAsSuffixIcons,
              popupItemDisabled: popupItemDisabled,
              popupBarrierColor: popupBarrierColor,
              onPopupDismissed: () {
                field.control.markAsTouched();
                onPopupDismissed();
              },
              searchBoxController: searchBoxController,
              searchDelay: searchDelay,
              onBeforeChange: onBeforeChange,
            );
          },
        );
}
