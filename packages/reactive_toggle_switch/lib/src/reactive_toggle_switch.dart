import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:toggle_switch/toggle_switch.dart';

/// A [ReactiveToggleSwitch] that contains a [ToggleSwitch].
///
/// This is a convenience widget that wraps a [ToggleSwitch] widget in a
/// [ReactiveToggleSwitch].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveToggleSwitch<T> extends ReactiveFormField<T, int> {
  /// Creates a [ReactiveToggleSwitch] that contains a [ToggleSwitch].
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
  /// ReactiveToggleSwitch(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveToggleSwitch(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveToggleSwitch(
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
  /// ReactiveToggleSwitch(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [ToggleSwitch] class
  /// and [ToggleSwitch], the constructor.
  ReactiveToggleSwitch({
    super.key,
    super.formControlName,
    super.formControl,
    super.validationMessages,
    super.valueAccessor,
    super.showErrors,

    //////////////////////////////////////////////////////////////////////////
    List<Color>? borderColor,
    Color dividerColor = Colors.white30,
    List<Color>? activeBgColor,
    Color? activeFgColor,
    Color? inactiveBgColor,
    Color? inactiveFgColor,
    List<String>? labels,
    int? totalSwitches,
    List<IconData?>? icons,
    List<List<Color>?>? activeBgColors,
    List<TextStyle?>? customTextStyles,
    List<Icon?>? customIcons,
    List<double>? customWidths,
    List<double>? customHeights,
    double minWidth = 72,
    double minHeight = 40,
    double cornerRadius = 8.0,
    double fontSize = 13,
    double iconSize = 17,
    double dividerMargin = 8.0,
    double? borderWidth,
    // OnToggle? onToggle,
    bool changeOnTap = true,
    bool animate = false,
    int animationDuration = 800,
    bool radiusStyle = false,
    bool textDirectionRTL = false,
    Curve curve = Curves.easeIn,
    // this.initialLabelIndex = 0,
    bool doubleTapDisable = false,
    bool isVertical = false,
    List<Border?>? activeBorders,
    bool centerText = false,
    bool multiLineText = false,
    List<Widget>? customWidgets,
    CancelToggle? cancelToggle,
    List<bool>? states,
  }) : super(
          builder: (field) {
            return ToggleSwitch(
              borderColor: borderColor,
              dividerColor: dividerColor,
              activeBgColor: activeBgColor,
              activeFgColor: activeFgColor,
              inactiveBgColor: inactiveBgColor,
              inactiveFgColor: inactiveFgColor,
              labels: labels,
              totalSwitches: totalSwitches,
              icons: icons,
              activeBgColors: activeBgColors,
              customTextStyles: customTextStyles,
              customIcons: customIcons,
              customWidths: customWidths,
              customHeights: customHeights,
              minWidth: minWidth,
              minHeight: minHeight,
              cornerRadius: cornerRadius,
              fontSize: fontSize,
              iconSize: iconSize,
              dividerMargin: dividerMargin,
              borderWidth: borderWidth,
              onToggle: field.didChange,
              changeOnTap: changeOnTap,
              animate: animate,
              animationDuration: animationDuration,
              radiusStyle: radiusStyle,
              textDirectionRTL: textDirectionRTL,
              curve: curve,
              initialLabelIndex: field.value,
              doubleTapDisable: doubleTapDisable,
              isVertical: isVertical,
              activeBorders: activeBorders,
              states: states,
              cancelToggle: cancelToggle,
              centerText: centerText,
              multiLineText: multiLineText,
              customWidgets: customWidgets,
            );
          },
        );
}
