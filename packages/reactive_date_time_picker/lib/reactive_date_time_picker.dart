// ignore_for_file: use_build_context_synchronously

library reactive_date_time_picker;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:reactive_forms/reactive_forms.dart';

enum ReactiveDatePickerFieldType {
  date,
  time,
  dateTime,
}

typedef GetInitialDate = DateTime Function(
    DateTime? fieldValue, DateTime lastDate);

typedef GetInitialTime = TimeOfDay Function(DateTime? fieldValue);

/// A builder that builds a widget responsible to decide when to show
/// the picker dialog.
///
/// It has a property to access the [FormControl]
/// that is bound to [ReactiveDatePickerField].

/// This is a convenience widget that wraps the function
/// [showDatePicker] and [showTimePicker] in a [ReactiveDatePickerField].
///
/// The [formControlName] is required to bind this [ReactiveDatePickerField]
/// to a [FormControl].
///
/// For documentation about the various parameters, see the [showDatePicker]
/// and [showTimePicker] function parameters.
///
/// ## Example:
///
/// ```dart
/// ReactiveDatePickerField(
///   formControlName: 'birthday',
/// )
/// ```
class ReactiveDateTimePicker
    extends ReactiveFocusableFormField<DateTime, String> {
  /// Creates a [ReactiveDatePickerField] that wraps the function [showDatePicker].
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
  /// For documentation about the various parameters, see the [showTimePicker]
  /// function parameters.
  ReactiveDateTimePicker({
    super.key,
    super.formControlName,
    super.formControl,
    ControlValueAccessor<DateTime, String>? valueAccessor,
    super.validationMessages,
    super.showErrors,

    ////////////////////////////////////////////////////////////////////////////
    TextStyle? style,
    ReactiveDatePickerFieldType type = ReactiveDatePickerFieldType.date,
    InputDecoration? decoration,
    bool showClearIcon = true,
    Widget clearIcon = const Icon(Icons.clear),

    // common params
    TransitionBuilder? builder,
    bool useRootNavigator = true,
    String? cancelText,
    String? confirmText,
    String? helpText,
    GetInitialDate? getInitialDate,
    GetInitialTime? getInitialTime,
    DateFormat? dateFormat,
    @Deprecated('Text now inherits disabled color from Theme')
    double disabledOpacity = 0.5,

    // date picker params
    DateTime? firstDate,
    DateTime? lastDate,
    DatePickerEntryMode datePickerEntryMode = DatePickerEntryMode.calendar,
    SelectableDayPredicate? selectableDayPredicate,
    Locale? locale,
    TextDirection? textDirection,
    DatePickerMode initialDatePickerMode = DatePickerMode.day,
    String? errorFormatText,
    String? errorInvalidText,
    String? fieldHintText,
    String? fieldLabelText,
    RouteSettings? datePickerRouteSettings,
    TextInputType? keyboardType,
    Offset? anchorPoint,
    DateTime? currentDate,
    bool barrierDismissible = true,
    Color? barrierColor,
    String? barrierLabel,
    ValueChanged<DatePickerEntryMode>? onDatePickerModeChange,

    // time picker params
    TimePickerEntryMode timePickerEntryMode = TimePickerEntryMode.dial,
    RouteSettings? timePickerRouteSettings,
    bool timePickerBarrierDismissible = true,
    Color? timePickerBarrierColor,
    String? timePickerBarrierLabel,
    String? hourLabelText,
    String? minuteLabelText,
    String? timePickerErrorInvalidText,
    EntryModeChangeCallback? onEntryModeChanged,
    Offset? timePickerAnchorPoint,
    Orientation? timePickerOrientation,
    Future<DateTime?> Function(
      BuildContext context,
      DateTime? value,
    )? onTap,
    Widget Function(BuildContext context, String error)? errorBuilder,

    // input decorator props
    TextStyle? baseStyle,
    TextAlign? textAlign,
    TextAlignVertical? textAlignVertical,
    bool expands = false,
    MouseCursor cursor = SystemMouseCursors.click,
    Widget Function(BuildContext context, String? value)? valueBuilder,
    Icon? switchToInputEntryModeIcon,
    Icon? switchToCalendarEntryModeIcon,
  }) : super(
          valueAccessor:
              valueAccessor ?? _effectiveValueAccessor(type, dateFormat),
          builder: (field) {
            Widget? suffixIcon = decoration?.suffixIcon;
            final isEmptyValue =
                field.value == null || field.value?.isEmpty == true;

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
                valueAccessor ?? _effectiveValueAccessor(type, dateFormat);

            final errorText = field.errorText;

            final effectiveLastDate = lastDate ?? DateTime(2100);

            return HoverBuilder(builder: (context, isHovered) {
              return IgnorePointer(
                ignoring: !field.control.enabled,
                child: Opacity(
                  opacity: field.control.enabled ? 1 : disabledOpacity,
                  child: MouseRegion(
                    cursor: cursor,
                    child: GestureDetector(
                      onTap: () async {
                        DateTime? date;
                        TimeOfDay? time;
                        field.control.focus();
                        field.control.updateValueAndValidity();

                        final initialDate = (getInitialDate ?? _getInitialDate)(
                          field.control.value,
                          effectiveLastDate,
                        );

                        if (onTap != null) {
                          field.didChange(
                            effectiveValueAccessor.modelToViewValue(
                              await onTap(
                                field.context,
                                initialDate,
                              ),
                            ),
                          );
                        } else {
                          if (type == ReactiveDatePickerFieldType.date ||
                              type == ReactiveDatePickerFieldType.dateTime) {
                            date = await showDatePicker(
                              context: field.context,
                              initialDate: initialDate,
                              currentDate: currentDate,
                              firstDate: firstDate ?? DateTime(1900),
                              lastDate: effectiveLastDate,
                              initialEntryMode: datePickerEntryMode,
                              selectableDayPredicate: selectableDayPredicate,
                              helpText: helpText,
                              cancelText: cancelText,
                              confirmText: confirmText,
                              locale: locale,
                              useRootNavigator: useRootNavigator,
                              routeSettings: datePickerRouteSettings,
                              textDirection: textDirection,
                              builder: builder,
                              initialDatePickerMode: initialDatePickerMode,
                              errorFormatText: errorFormatText,
                              errorInvalidText: errorInvalidText,
                              fieldHintText: fieldHintText,
                              fieldLabelText: fieldLabelText,
                              keyboardType: keyboardType,
                              anchorPoint: anchorPoint,
                              barrierDismissible: barrierDismissible,
                              barrierColor: barrierColor,
                              barrierLabel: barrierLabel,
                              onDatePickerModeChange: onDatePickerModeChange,
                              switchToInputEntryModeIcon:
                                  switchToInputEntryModeIcon,
                              switchToCalendarEntryModeIcon:
                                  switchToCalendarEntryModeIcon,
                            );
                          }

                          if (type == ReactiveDatePickerFieldType.time ||
                              (type == ReactiveDatePickerFieldType.dateTime &&
                                  // there is no need to show timepicker if cancel was pressed on datepicker
                                  date != null)) {
                            time = await showTimePicker(
                              context: field.context,
                              initialTime: (getInitialTime ??
                                  _getInitialTime)(field.control.value),
                              builder: builder,
                              useRootNavigator: useRootNavigator,
                              initialEntryMode: timePickerEntryMode,
                              cancelText: cancelText,
                              confirmText: confirmText,
                              helpText: helpText,
                              routeSettings: timePickerRouteSettings,
                              barrierDismissible: timePickerBarrierDismissible,
                              barrierColor: timePickerBarrierColor,
                              barrierLabel: timePickerBarrierLabel,
                              errorInvalidText: timePickerErrorInvalidText,
                              hourLabelText: hourLabelText,
                              minuteLabelText: minuteLabelText,
                              onEntryModeChanged: onEntryModeChanged,
                              anchorPoint: timePickerAnchorPoint,
                              orientation: timePickerOrientation,
                            );
                          }

                          if (
                              // if `date` and `time` in `dateTime` mode is not empty...
                              (type == ReactiveDatePickerFieldType.dateTime &&
                                      (date != null && time != null)) ||
                                  // ... or if `date` in `date` mode is not empty ...
                                  (type == ReactiveDatePickerFieldType.date &&
                                      date != null) ||
                                  // ... or if `time` in `time` mode is not empty ...
                                  (type == ReactiveDatePickerFieldType.time &&
                                      time != null)) {
                            final dateTime = _combine(date, time);

                            final value = field.control.value;
                            // ... and new value is not the same as was before...
                            if (value == null ||
                                dateTime.compareTo(value) != 0) {
                              // ... this means that cancel was not pressed at any moment
                              // so we can update the field
                              field.didChange(
                                effectiveValueAccessor.modelToViewValue(
                                  _combine(date, time),
                                ),
                              );
                            }
                          }
                        }

                        field.control.unfocus();
                        field.control.updateValueAndValidity();
                        field.control.markAsTouched();
                      },
                      behavior: HitTestBehavior.opaque,
                      child: InputDecorator(
                        isHovering: isHovered,
                        isFocused: field.control.hasFocus,
                        isEmpty: isEmptyValue,
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
                          child:
                              valueBuilder?.call(field.context, field.value) ??
                                  Text(
                                    field.value ?? '',
                                  ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            });
          },
        );

  static DateTimeValueAccessor _effectiveValueAccessor(
      ReactiveDatePickerFieldType fieldType, DateFormat? dateFormat) {
    switch (fieldType) {
      case ReactiveDatePickerFieldType.date:
        return DateTimeValueAccessor(
          dateTimeFormat: dateFormat ?? DateFormat('yyyy/MM/dd'),
        );
      case ReactiveDatePickerFieldType.time:
        return DateTimeValueAccessor(
          dateTimeFormat: dateFormat ?? DateFormat('HH:mm'),
        );
      case ReactiveDatePickerFieldType.dateTime:
        return DateTimeValueAccessor(
          dateTimeFormat: dateFormat ?? DateFormat('yyyy/MM/dd HH:mm'),
        );
    }
  }

  static DateTime _combine(DateTime? date, TimeOfDay? time) {
    return DateTime(
      date?.year ?? 0,
      date?.month ?? 1,
      date?.day ?? 1,
      time?.hour ?? 0,
      time?.minute ?? 0,
    );
  }

  static DateTime _getInitialDate(DateTime? fieldValue, DateTime lastDate) {
    if (fieldValue != null) {
      return fieldValue;
    }

    final now = DateTime.now();
    return now.compareTo(lastDate) > 0 ? lastDate : now;
  }

  static TimeOfDay _getInitialTime(dynamic fieldValue) {
    if (fieldValue != null && fieldValue is DateTime) {
      return TimeOfDay(hour: fieldValue.hour, minute: fieldValue.minute);
    }

    return TimeOfDay.now();
  }
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
