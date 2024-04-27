part of 'reactive_animated_toggle_switch_rolling.dart';

/// A [ReactiveAnimatedToggleSwitch] that contains a [AnimatedToggleSwitch].
///
/// This is a convenience widget that wraps a [AnimatedToggleSwitch] widget in a
/// [ReactiveAnimatedToggleSwitch].
///
/// A [ReactiveForm] ancestor is required.
///
class ReactiveAnimatedToggleSwitchDual<T, V> extends ReactiveFormField<T, V> {
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
  ReactiveAnimatedToggleSwitchDual({
    super.key,
    Key? widgetKey,
    super.formControlName,
    super.formControl,
    super.validationMessages,
    super.valueAccessor,
    super.showErrors,

    //////////////////////////////////////////////////////////////////////////
    required V first,
    required V second,
    SimpleIconBuilder<V>? iconBuilder,
    IconBuilder<V>? customIconBuilder,
    SimpleIconBuilder<V>? textBuilder,
    AnimatedIconBuilder<V>? customTextBuilder,
    Duration animationDuration = const Duration(milliseconds: 500),
    Curve animationCurve = Curves.easeInOutCirc,
    Size indicatorSize = const Size.fromWidth(46.0),
    double borderWidth = 2.0,
    ToggleStyle style = const ToggleStyle(),
    StyleBuilder<V>? styleBuilder,
    CustomStyleBuilder<V>? customStyleBuilder,
    List<ToggleStyle>? styleList,
    double spacing = 40.0,
    double height = 50.0,
    Duration iconAnimationDuration = const Duration(milliseconds: 500),
    Curve iconAnimationCurve = Curves.easeInOut,
    AnimationType styleAnimationType = AnimationType.onHover,
    AnimationType indicatorAnimationType = AnimationType.onHover,
    FittingMode fittingMode = FittingMode.preventHorizontalOverlapping,
    TapCallback<V>? onTap,
    double minTouchTargetSize = 48.0,
    TextDirection? textDirection,
    ToggleCursors cursors =
        const ToggleCursors(defaultCursor: SystemMouseCursors.click),
    EdgeInsetsGeometry textMargin = const EdgeInsets.symmetric(horizontal: 8.0),
    Offset animationOffset = const Offset(20.0, 0),
    bool clipAnimation = true,
    bool opacityAnimation = true,
    LoadingIconBuilder<V> loadingIconBuilder = _defaultLoadingIconBuilder,
    bool loading = false,
    Duration? loadingAnimationDuration,
    Curve? loadingAnimationCurve,
    ForegroundIndicatorTransition indicatorTransition =
        const ForegroundIndicatorTransition.rolling(),
    bool active = true,
    double inactiveOpacity = 0.6,
    Curve inactiveOpacityCurve = Curves.easeInOut,
    Duration inactiveOpacityDuration = const Duration(milliseconds: 350),
  }) : super(
          builder: (field) {
            return AnimatedToggleSwitch<V>.dual(
              key: widgetKey,
              onChanged: field.didChange,
              current: field.value ?? first,
              first: first,
              second: second,
              iconBuilder: iconBuilder,
              customIconBuilder: customIconBuilder,
              textBuilder: textBuilder,
              customTextBuilder: customTextBuilder,
              animationDuration: animationDuration,
              animationCurve: animationCurve,
              indicatorSize: indicatorSize,
              borderWidth: borderWidth,
              style: style,
              styleBuilder: styleBuilder,
              customStyleBuilder: customStyleBuilder,
              styleList: styleList,
              spacing: spacing,
              height: height,
              iconAnimationDuration: iconAnimationDuration,
              iconAnimationCurve: iconAnimationCurve,
              styleAnimationType: styleAnimationType,
              indicatorAnimationType: indicatorAnimationType,
              fittingMode: fittingMode,
              onTap: onTap,
              minTouchTargetSize: minTouchTargetSize,
              textDirection: textDirection,
              cursors: cursors,
              textMargin: textMargin,
              animationOffset: animationOffset,
              clipAnimation: clipAnimation,
              opacityAnimation: opacityAnimation,
              loadingIconBuilder: loadingIconBuilder,
              loading: loading,
              loadingAnimationDuration: loadingAnimationDuration,
              loadingAnimationCurve: loadingAnimationCurve,
              indicatorTransition: indicatorTransition,
              active: active,
              inactiveOpacity: inactiveOpacity,
              inactiveOpacityCurve: inactiveOpacityCurve,
              inactiveOpacityDuration: inactiveOpacityDuration,

              // values: values,
              // iconBuilder: iconBuilder,
              // customIconBuilder: customIconBuilder,
              // iconList: iconList,
              // animationDuration: animationDuration,
              // animationCurve: animationCurve,
              // indicatorSize: indicatorSize,
              // onChanged: field.didChange,
              // borderWidth: borderWidth,
              // style: style,
              // styleBuilder: styleBuilder,
              // customStyleBuilder: customStyleBuilder,
              // styleList: styleList,
              // iconOpacity: iconOpacity,
              // spacing: spacing,
              // height: height,
              // styleAnimationType: styleAnimationType,
              // indicatorAnimationType: indicatorAnimationType,
              // onTap: onTap,
              // fittingMode: fittingMode,
              // minTouchTargetSize: minTouchTargetSize,
              // textDirection: textDirection,
              // iconsTappable: iconsTappable,
              // cursors: cursors,
              // loadingIconBuilder: loadingIconBuilder,
              // loading: loading,
              // loadingAnimationDuration: loadingAnimationDuration,
              // loadingAnimationCurve: loadingAnimationCurve,
              // indicatorTransition: indicatorTransition,
              // allowUnlistedValues: allowUnlistedValues,
              // indicatorAppearingBuilder: indicatorAppearingBuilder,
              // indicatorAppearingDuration: indicatorAppearingDuration,
              // indicatorAppearingCurve: indicatorAppearingCurve,
              // separatorBuilder: separatorBuilder,
              // customSeparatorBuilder: customSeparatorBuilder,
              // active: field.control.enabled,
              // inactiveOpacity: inactiveOpacity,
              // inactiveOpacityCurve: inactiveOpacityCurve,
              // inactiveOpacityDuration: inactiveOpacityDuration,
              // indicatorIconScale: indicatorIconScale,
            );
          },
        );
}
