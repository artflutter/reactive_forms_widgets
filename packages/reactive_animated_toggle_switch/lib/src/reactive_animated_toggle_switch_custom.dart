part of 'reactive_animated_toggle_switch_rolling.dart';

/// A [ReactiveAnimatedToggleSwitch] that contains a [AnimatedToggleSwitch].
///
/// This is a convenience widget that wraps a [AnimatedToggleSwitch] widget in a
/// [ReactiveAnimatedToggleSwitch].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveAnimatedToggleSwitchCustom<T, V> extends ReactiveFormField<T, V> {
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
  ReactiveAnimatedToggleSwitchCustom(
      {super.key,
      Key? widgetKey,
      super.formControlName,
      super.formControl,
      super.validationMessages,
      super.valueAccessor,
      super.showErrors,

      //////////////////////////////////////////////////////////////////////////
      required List<V> values,
      AnimatedIconBuilder<V>? animatedIconBuilder,
      ToggleStyle style = const ToggleStyle(),
      StyleBuilder<V>? styleBuilder,
      CustomStyleBuilder<V>? customStyleBuilder,
      List<ToggleStyle>? styleList,
      Duration animationDuration = const Duration(milliseconds: 500),
      Duration? iconAnimationDuration,
      Curve animationCurve = Curves.easeInOutCirc,
      Curve iconAnimationCurve = Curves.linear,
      Size indicatorSize = const Size.fromWidth(46.0),
      double borderWidth = 2.0,
      double iconOpacity = 0.5,
      double spacing = 0.0,
      double height = 50,
      CustomIndicatorBuilder<V>? foregroundIndicatorIconBuilder,
      AnimationType styleAnimationType = AnimationType.onSelected,
      AnimationType indicatorAnimationType = AnimationType.onHover,
      TapCallback<V>? onTap,
      ToggleCursors cursors = const ToggleCursors(),
      FittingMode fittingMode = FittingMode.preventHorizontalOverlapping,
      bool iconsTappable = true,
      double minTouchTargetSize = 48,
      TextDirection? textDirection,
      LoadingIconBuilder<dynamic> loadingIconBuilder =
          _defaultLoadingIconBuilder,
      bool? loading,
      Duration? loadingAnimationDuration,
      Curve? loadingAnimationCurve,
      bool allowUnlistedValues = false,
      IndicatorAppearingBuilder indicatorAppearingBuilder =
          _defaultIndicatorAppearingBuilder,
      Duration indicatorAppearingDuration =
          _defaultIndicatorAppearingAnimationDuration,
      Curve indicatorAppearingCurve = _defaultIndicatorAppearingAnimationCurve,
      SeparatorBuilder? separatorBuilder,
      CustomSeparatorBuilder<V>? customSeparatorBuilder,
      double inactiveOpacity = 0.6,
      Curve inactiveOpacityCurve = Curves.easeInOut,
      Duration inactiveOpacityDuration = const Duration(milliseconds: 350),
      ForegroundIndicatorTransition indicatorTransition =
          const ForegroundIndicatorTransition.rolling(),
      double indicatorIconScale = 1.0,
      double selectedIconOpacity = 1.0,
      AnimationType iconAnimationType = AnimationType.onSelected})
      : super(
          builder: (field) {
            return AnimatedToggleSwitch<V>.custom(
              key: widgetKey,
              current: field.value ?? values.first,
              values: values,
              animationDuration: animationDuration,
              animationCurve: animationCurve,
              indicatorSize: indicatorSize,
              onChanged: field.didChange,
              borderWidth: borderWidth,
              style: style,
              styleBuilder: styleBuilder,
              customStyleBuilder: customStyleBuilder,
              styleList: styleList,
              iconOpacity: iconOpacity,
              spacing: spacing,
              height: height,
              styleAnimationType: styleAnimationType,
              indicatorAnimationType: indicatorAnimationType,
              onTap: onTap,
              fittingMode: fittingMode,
              minTouchTargetSize: minTouchTargetSize,
              textDirection: textDirection,
              iconsTappable: iconsTappable,
              cursors: cursors,
              loadingIconBuilder: loadingIconBuilder,
              loading: loading,
              loadingAnimationDuration: loadingAnimationDuration,
              loadingAnimationCurve: loadingAnimationCurve,
              allowUnlistedValues: allowUnlistedValues,
              indicatorAppearingBuilder: indicatorAppearingBuilder,
              indicatorAppearingDuration: indicatorAppearingDuration,
              indicatorAppearingCurve: indicatorAppearingCurve,
              separatorBuilder: separatorBuilder,
              customSeparatorBuilder: customSeparatorBuilder,
              active: field.control.enabled,
              inactiveOpacity: inactiveOpacity,
              inactiveOpacityCurve: inactiveOpacityCurve,
              inactiveOpacityDuration: inactiveOpacityDuration,
              animatedIconBuilder: animatedIconBuilder,
              iconAnimationCurve: iconAnimationCurve,
              iconAnimationDuration: iconAnimationDuration,
              foregroundIndicatorIconBuilder: foregroundIndicatorIconBuilder,
              selectedIconOpacity: selectedIconOpacity,
              iconAnimationType: iconAnimationType,
            );
          },
        );
}
