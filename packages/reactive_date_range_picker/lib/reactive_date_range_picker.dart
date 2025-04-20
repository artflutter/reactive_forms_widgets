library;

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'datetime_range_value_accessor.dart';

/// A builder that builds a widget responsible to decide when to show
/// the picker dialog.
///
/// It has a property to access the [FormControl]
/// that is bound to [ReactiveDateRangePickerField].

/// This is a convenience widget that wraps the function
/// [showDatePicker] and [showTimePicker] in a [ReactiveDateRangePickerField].
///
/// The [formControlName] is required to bind this [ReactiveDateRangePickerField]
/// to a [FormControl].
///
/// For documentation about the various parameters, see the [showDatePicker]
/// and [showTimePicker] function parameters.
///
/// ## Example:
///
/// ```dart
/// ReactiveDateRangePickerField(
///   formControlName: 'birthday',
/// )
/// ```
class ReactiveDateRangePicker extends ReactiveFormField<DateTimeRange, String> {
  /// Creates a [ReactiveDateRangePickerField] that wraps the function [showDateRangePicker].
  ///
  /// Can optionally provide a [formControl] to bind this widget to a control.
  ///
  /// Can optionally provide a [formControlName] to bind this ReactiveFormField
  /// to a [FormControl].
  ///
  /// Must provide one of the arguments [formControl] or a [formControlName],
  /// but not both at the same time.
  ///
  /// The parameter [transitionBuilder] is the equivalent of [builder]
  /// parameter in the [showTimePicker].
  ///
  /// For documentation about the various parameters, see the [showDateRangePicker]
  /// function parameters.
  ReactiveDateRangePicker({
    super.key,
    super.formControlName,
    super.formControl,
    ControlValueAccessor<DateTimeRange, String>? valueAccessor,
    super.validationMessages,
    super.showErrors,

    ////////////////////////////////////////////////////////////////////////////
    InputDecoration? decoration,
    bool showClearIcon = true,
    Widget clearIcon = const Icon(Icons.clear),
    TextStyle? style,
    TransitionBuilder? builder,
    bool useRootNavigator = true,
    String? cancelText,
    String? confirmText,
    String? helpText,
    String? saveText,
    String? errorFormatText,
    String? errorInvalidText,
    String? errorInvalidRangeText,
    String? fieldStartHintText,
    String? fieldEndHintText,
    String? fieldStartLabelText,
    String? fieldEndLabelText,
    DateTime? firstDate,
    DateTime? lastDate,
    DateTime? currentDate,
    DatePickerEntryMode initialEntryMode = DatePickerEntryMode.calendar,
    Locale? locale,
    TextDirection? textDirection,
    RouteSettings? routeSettings,
    bool barrierDismissible = true,
    Color? barrierColor,
    Offset? anchorPoint,
    TextInputType keyboardType = TextInputType.datetime,
    Icon? switchToInputEntryModeIcon,
    Icon? switchToCalendarEntryModeIcon,
    Widget Function(BuildContext context, String error)? errorBuilder,
    // input decorator props
    TextStyle? baseStyle,
    TextAlign? textAlign,
    TextAlignVertical? textAlignVertical,
    bool expands = false,
    MouseCursor cursor = SystemMouseCursors.click,
    Future<DateTimeRange?> Function(
      BuildContext context,
      DateTimeRange? value,
    )? onTap,
    Widget Function(BuildContext context, String? value)? valueBuilder,
  }) : super(
          valueAccessor: valueAccessor ?? DateTimeRangeValueAccessor(),
          builder: (field) {
            Widget? suffixIcon = decoration?.suffixIcon;
            final isEmptyValue =
                field.value == null || field.value.toString().isEmpty;

            if (showClearIcon && !isEmptyValue) {
              suffixIcon = InkWell(
                borderRadius: BorderRadius.circular(25),
                child: clearIcon,
                onTap: () {
                  field.control.markAsTouched();
                  field.didChange(null);
                },
              );
            }

            final InputDecoration effectiveDecoration =
                (decoration ?? const InputDecoration())
                    .applyDefaults(Theme.of(field.context).inputDecorationTheme)
                    .copyWith(suffixIcon: suffixIcon);

            final effectiveValueAccessor =
                valueAccessor ?? DateTimeRangeValueAccessor();

            final errorText = field.errorText;

            final effectiveLastDate = lastDate ?? DateTime(2100);

            return IgnorePointer(
              ignoring: !field.control.enabled,
              child: HoverBuilder(builder: (context, isHovered) {
                return MouseRegion(
                  cursor: cursor,
                  child: GestureDetector(
                    onTap: () async {
                      field.control.focus();
                      field.control.updateValueAndValidity();
                      if (onTap != null) {
                        field.didChange(
                          effectiveValueAccessor.modelToViewValue(
                            await onTap(
                              field.context,
                              field.control.value,
                            ),
                          ),
                        );
                      } else {
                        final dateRange = await showDateRangePicker(
                          context: field.context,
                          initialDateRange: field.control.value,
                          firstDate: firstDate ?? DateTime(1900),
                          lastDate: effectiveLastDate,
                          currentDate: currentDate,
                          initialEntryMode: initialEntryMode,
                          helpText: helpText,
                          cancelText: cancelText,
                          confirmText: confirmText,
                          saveText: saveText,
                          errorFormatText: errorFormatText,
                          errorInvalidText: errorInvalidText,
                          errorInvalidRangeText: errorInvalidRangeText,
                          fieldStartHintText: fieldStartHintText,
                          fieldEndHintText: fieldEndHintText,
                          fieldStartLabelText: fieldStartLabelText,
                          fieldEndLabelText: fieldEndLabelText,
                          locale: locale,
                          useRootNavigator: useRootNavigator,
                          routeSettings: routeSettings,
                          textDirection: textDirection,
                          builder: builder,
                          barrierDismissible: barrierDismissible,
                          barrierColor: barrierColor,
                          anchorPoint: anchorPoint,
                          keyboardType: keyboardType,
                          switchToInputEntryModeIcon:
                              switchToInputEntryModeIcon,
                          switchToCalendarEntryModeIcon:
                              switchToCalendarEntryModeIcon,
                        );

                        if (dateRange == null) {
                          return;
                        }
                        field.didChange(
                          effectiveValueAccessor.modelToViewValue(dateRange),
                        );
                      }

                      field.control.unfocus();
                      field.control.updateValueAndValidity();
                      field.control.markAsTouched();
                    },
                    child: InputDecorator(
                      isFocused: field.control.hasFocus,
                      isEmpty: isEmptyValue,
                      isHovering: isHovered,
                      baseStyle: baseStyle,
                      textAlign: textAlign,
                      textAlignVertical: textAlignVertical,
                      expands: expands,
                      decoration: effectiveDecoration.copyWith(
                        enabled: field.control.enabled,
                        errorText:
                            errorBuilder == null ? field.errorText : null,
                        error: errorBuilder != null && errorText != null
                            ? DefaultTextStyle.merge(
                                style: Theme.of(field.context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: Theme.of(field.context)
                                          .colorScheme
                                          .error,
                                    )
                                    .merge(effectiveDecoration.errorStyle),
                                child: errorBuilder.call(
                                  field.context,
                                  errorText,
                                ),
                              )
                            : null,
                      ),
                      child: DefaultTextStyle.merge(
                        style: Theme.of(field.context)
                            .textTheme
                            .titleMedium
                            ?.merge(style)
                            .copyWith(
                              color: !field.control.enabled
                                  ? Theme.of(field.context).disabledColor
                                  : null,
                            ),
                        child: valueBuilder?.call(field.context, field.value) ??
                            Text(
                              field.value ?? '',
                            ),
                      ),
                    ),
                  ),
                );
              }),
            );
          },
        );
}

class HoverBuilder extends StatefulWidget {
  const HoverBuilder({
    required this.builder,
    super.key,
  });

  final Widget Function(BuildContext context, bool isHovered) builder;

  @override
  _HoverBuilderState createState() => _HoverBuilderState();
}

class _HoverBuilderState extends State<HoverBuilder> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => _onHoverChanged(enabled: true),
      onExit: (event) => _onHoverChanged(enabled: false),
      child: widget.builder(context, _isHovered),
    );
  }

  void _onHoverChanged({required bool enabled}) {
    setState(() {
      _isHovered = enabled;
    });
  }
}
