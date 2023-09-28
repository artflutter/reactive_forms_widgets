part of 'reactive_animated_toggle_switch_rolling.dart';

/// A [ReactiveAnimatedToggleSwitch] that contains a [AnimatedToggleSwitch].
///
/// This is a convenience widget that wraps a [AnimatedToggleSwitch] widget in a
/// [ReactiveAnimatedToggleSwitch].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveCustomAnimatedToggleSwitch<T, V> extends ReactiveFormField<T, V> {
  /// Creates a [ReactiveAnimatedToggleSwitch] that contains a [AnimatedToggleSwitch].
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
  /// ReactiveAnimatedToggleSwitch(
  ///   formControlName: 'email',
  /// ),
  ///
  /// ```
  ///
  /// Binds a text field directly with a *FormControl*.
  /// ```
  /// final form = fb.group({'email': Validators.required});
  ///
  /// ReactiveAnimatedToggleSwitch(
  ///   formControl: form.control('email'),
  /// ),
  ///
  /// ```
  ///
  /// Customize validation messages
  /// ```dart
  /// ReactiveAnimatedToggleSwitch(
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
  /// ReactiveAnimatedToggleSwitch(
  ///   formControlName: 'email',
  ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
  /// ),
  /// ```
  ///
  /// For documentation about the various parameters, see the [AnimatedToggleSwitch] class
  /// and [AnimatedToggleSwitch], the constructor.
  ReactiveCustomAnimatedToggleSwitch({
    Key? key,
    Key? widgetKey,
    String? formControlName,
    FormControl<T>? formControl,
    Map<String, ValidationMessageFunction>? validationMessages,
    ControlValueAccessor<T, V>? valueAccessor,
    ShowErrorsFunction<T>? showErrors,

    //////////////////////////////////////////////////////////////////////////
    required List<V> values,
    required CustomIconBuilder<V> iconBuilder,
    Duration animationDuration = const Duration(milliseconds: 500),
    Curve animationCurve = Curves.easeInOutCirc,
    Size indicatorSize = const Size.fromWidth(46.0),
    double spacing = 0.0,
    double height = 50,
    TapCallback<V>? onTap,
    ToggleCursors cursors = const ToggleCursors(),
    FittingMode fittingMode = FittingMode.preventHorizontalOverlapping,
    bool iconsTappable = true,
    double minTouchTargetSize = 48,
    TextDirection? textDirection,
    bool? loading,
    Duration? loadingAnimationDuration,
    Curve? loadingAnimationCurve,
    bool allowUnlistedValues = false,
    IndicatorAppearingBuilder indicatorAppearingBuilder =
        _defaultIndicatorAppearingBuilder,
    Duration indicatorAppearingDuration =
        _defaultIndicatorAppearingAnimationDuration,
    Curve indicatorAppearingCurve = _defaultIndicatorAppearingAnimationCurve,
    CustomSeparatorBuilder<V>? separatorBuilder,
    ForegroundIndicatorTransition indicatorTransition =
        const ForegroundIndicatorTransition.rolling(),
    double indicatorIconScale = 1.0,
    CustomWrapperBuilder<V>? wrapperBuilder,
    IconArrangement iconArrangement = IconArrangement.row,
    EdgeInsets padding = EdgeInsets.zero,
    Duration dragStartDuration = const Duration(milliseconds: 200),
    Curve dragStartCurve = Curves.easeInOutCirc,
    CustomIndicatorBuilder<V>? foregroundIndicatorBuilder,
    CustomIndicatorBuilder<V>? backgroundIndicatorBuilder,
  }) : super(
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          valueAccessor: valueAccessor,
          validationMessages: validationMessages,
          showErrors: showErrors,
          builder: (field) {
            return CustomAnimatedToggleSwitch<V>(
              key: widgetKey,
              current: field.value ?? values.first,
              values: values,
              iconBuilder: iconBuilder,
              animationDuration: animationDuration,
              animationCurve: animationCurve,
              indicatorSize: indicatorSize,
              onChanged: field.didChange,
              spacing: spacing,
              height: height,
              onTap: onTap,
              fittingMode: fittingMode,
              wrapperBuilder: wrapperBuilder,
              minTouchTargetSize: minTouchTargetSize,
              textDirection: textDirection,
              iconsTappable: iconsTappable,
              cursors: cursors,
              allowUnlistedValues: allowUnlistedValues,
              indicatorAppearingBuilder: indicatorAppearingBuilder,
              indicatorAppearingDuration: indicatorAppearingDuration,
              indicatorAppearingCurve: indicatorAppearingCurve,
              separatorBuilder: separatorBuilder,
              foregroundIndicatorBuilder: foregroundIndicatorBuilder,
              backgroundIndicatorBuilder: backgroundIndicatorBuilder,
              iconArrangement: iconArrangement,
              padding: padding,
              dragStartDuration: dragStartDuration,
              dragStartCurve: dragStartCurve,
            );
          },
        );
}
