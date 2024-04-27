import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// A [ReactiveMultiSelectChipField] that contains a [MultiSelectChipField].
///
/// This is a convenience widget that wraps a [MultiSelectChipField] widget in a
/// [ReactiveMultiSelectChipField].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveMultiSelectChipField<T, V>
    extends ReactiveFormField<List<T>, List<V>> {
  /// Creates a [ReactiveMultiSelectChipField] that contains a [MultiSelectChipField].
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
  /// ReactiveMultiSelectChipField(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveMultiSelectChipField(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveMultiSelectChipField(
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
  /// ReactiveMultiSelectChipField(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [MultiSelectChipField] class
  /// and [MultiSelectChipField], the constructor.
  ReactiveMultiSelectChipField({
    super.key,
    GlobalKey<FormFieldState<dynamic>>? widgetKey,
    super.formControlName,
    super.formControl,
    super.validationMessages,
    super.valueAccessor,
    super.showErrors,

    //////////////////////////////////////////////////////////////////////////
    Text? title,
    required List<MultiSelectItem<V>> items,
    void Function(List<V>)? onSelectionChanged,
    MultiSelectChipDisplay<V>? chipDisplay,
    bool searchable = false,
    Text? confirmText,
    Text? cancelText,
    Color? barrierColor,
    Color? selectedColor,
    double? dialogHeight,
    double? dialogWidth,
    String? searchHint,
    Color Function(V?)? colorator,
    Color? backgroundColor,
    Color? unselectedColor,
    Icon? searchIcon,
    Icon? closeSearchIcon,
    TextStyle? itemsTextStyle,
    TextStyle? selectedItemsTextStyle,
    TextStyle? searchTextStyle,
    TextStyle? searchHintStyle,
    bool separateSelectedItems = false,
    Color? checkColor,
    bool isDismissible = false,
    BoxDecoration? decoration,
    Text? buttonText,
    Icon? buttonIcon,
    MultiSelectListType? listType,
    InputDecoration inputDecoration = const InputDecoration(
      border: InputBorder.none,
      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      isDense: true,
      isCollapsed: true,
    ),
    Color? chipColor,
    Color? selectedChipColor,
    TextStyle? textStyle,
    TextStyle? selectedTextStyle,
    Icon? icon,
    ShapeBorder? chipShape,
    bool scroll = true,
    Color? headerColor,
    Widget Function(MultiSelectItem<V?>, FormFieldState<List<V?>>)? itemBuilder,
    double? height,
    Function(ScrollController)? scrollControl,
    HorizontalScrollBar? scrollBar,
    bool showHeader = true,
    double? chipWidth,
  }) : super(
          builder: (field) {
            final effectiveDecoration = inputDecoration
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);

            return InputDecorator(
              decoration: effectiveDecoration.copyWith(
                errorText: field.errorText,
                enabled: field.control.enabled,
              ),
              child: MultiSelectChipField<V?>(
                key: widgetKey,
                items: items,
                onTap: (values) =>
                    field.didChange(values.whereType<V>().toList()),
                title: title,
                decoration: decoration,
                searchable: searchable,
                searchHint: searchHint,
                colorator: colorator,
                searchIcon: searchIcon,
                closeSearchIcon: closeSearchIcon,
                searchTextStyle: searchTextStyle,
                searchHintStyle: searchHintStyle,
                initialValue: field.value ?? [],
                chipColor: chipColor,
                selectedChipColor: selectedChipColor,
                textStyle: textStyle,
                selectedTextStyle: selectedTextStyle,
                icon: icon,
                chipShape: chipShape,
                scroll: scroll,
                headerColor: headerColor,
                itemBuilder: itemBuilder,
                height: height,
                scrollControl: scrollControl,
                scrollBar: scrollBar,
                showHeader: showHeader,
                chipWidth: chipWidth,
              ),
            );
          },
        );
}
