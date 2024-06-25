// import 'package:fluent_ui/fluent_ui.dart';
//
// import 'package:reactive_forms/reactive_forms.dart';
//
// /// A [ReactiveFluentDropdownButton] that contains a [FluentUi].
// ///
// /// This is a convenience widget that wraps a [FluentUi] widget in a
// /// [ReactiveFluentDropdownButton].
// ///
// /// A [ReactiveForm] ancestor is required.
// ///
// class ReactiveFluentDropdownButton<T, V>
//     extends ReactiveFocusableFormField<T, V> {
//   /// Creates a [ReactiveFluentDropdownButton] that contains a [FluentUi].
//   ///
//   /// Can optionally provide a [formControl] to bind this widget to a control.
//   ///
//   /// Can optionally provide a [formControlName] to bind this ReactiveFormField
//   /// to a [FormControl].
//   ///
//   /// Must provide one of the arguments [formControl] or a [formControlName],
//   /// but not both at the same time.
//   ///
//   /// Can optionally provide a [validationMessages] argument to customize a
//   /// message for different kinds of validation errors.
//   ///
//   /// Can optionally provide a [valueAccessor] to set a custom value accessors.
//   /// See [ControlValueAccessor].
//   ///
//   /// Can optionally provide a [showErrors] function to customize when to show
//   /// validation messages. Reactive Widgets make validation messages visible
//   /// when the control is INVALID and TOUCHED, this behavior can be customized
//   /// in the [showErrors] function.
//   ///
//   /// ### Example:
//   /// Binds a text field.
//   /// ```
//   /// final form = fb.group({'email': Validators.required});
//   ///
//   /// ReactiveFluentDropdownButton(
//   ///   formControlName: 'email',
//   /// ),
//   ///
//   /// ```
//   ///
//   /// Binds a text field directly with a *FormControl*.
//   /// ```
//   /// final form = fb.group({'email': Validators.required});
//   ///
//   /// ReactiveFluentDropdownButton(
//   ///   formControl: form.control('email'),
//   /// ),
//   ///
//   /// ```
//   ///
//   /// Customize validation messages
//   /// ```dart
//   /// ReactiveFluentDropdownButton(
//   ///   formControlName: 'email',
//   ///   validationMessages: {
//   ///     ValidationMessage.required: 'The email must not be empty',
//   ///     ValidationMessage.email: 'The email must be a valid email',
//   ///   }
//   /// ),
//   /// ```
//   ///
//   /// Customize when to show up validation messages.
//   /// ```dart
//   /// ReactiveFluentDropdownButton(
//   ///   formControlName: 'email',
//   ///   showErrors: (control) => control.invalid && control.touched && control.dirty,
//   /// ),
//   /// ```
//   ///
//   /// For documentation about the various parameters, see the [FluentUi] class
//   /// and [FluentUi], the constructor.
//   ReactiveFluentDropdownButton({
//     super.key,
//     Key? comboBoxKey,
//     super.formControlName,
//     super.formControl,
//     super.validationMessages,
//     super.valueAccessor,
//     super.showErrors,
//     super.focusNode,
//
//     //////////////////////////////////////////////////////////////////////////
//     DropDownButtonBuilder? buttonBuilder,
//     Widget? leading,
//     Widget? title,
//     Widget trailing = const ChevronDown(),
//     double verticalOffset = 6.0,
//     required List<MenuFlyoutItemBase> items,
//     bool closeAfterClick = true,
//     bool disabled = false,
//     bool autofocus = false,
//     FlyoutPlacementMode placement = FlyoutPlacementMode.bottomCenter,
//     ShapeBorder? menuShape,
//     Color? menuColor,
//     VoidCallback? onOpen,
//     VoidCallback? onClose,
//     FlyoutTransitionBuilder transitionBuilder = _defaultTransitionBuilder,
//   }) : super(
//           builder: (field) {
//             return DropDownButton(
//               buttonBuilder: buttonBuilder,
//               items: items,
//               leading: leading,
//               title: title,
//               trailing: trailing,
//               verticalOffset: verticalOffset,
//               closeAfterClick: closeAfterClick,
//               disabled: disabled,
//               focusNode: field.focusNode,
//               autofocus: autofocus = false,
//               placement: placement,
//               menuShape: menuShape,
//               menuColor: menuColor,
//               onOpen: onOpen,
//               onClose: onClose,
//               transitionBuilder: transitionBuilder,
//             );
//             // <V>(
//             //   key: comboBoxKey,
//             //   items: items,
//             //   focusNode: field.focusNode,
//             //   value: field.value,
//             //   selectedItemBuilder: selectedItemBuilder,
//             //   placeholder: placeholder,
//             //   disabledPlaceholder: disabledPlaceholder,
//             //   onChanged: field.didChange,
//             //   onTap: onTap,
//             //   elevation: elevation,
//             //   style: style,
//             //   icon: icon,
//             //   iconDisabledColor: iconDisabledColor,
//             //   iconEnabledColor: iconEnabledColor,
//             //   iconSize: iconSize,
//             //   isExpanded: isExpanded,
//             //   focusColor: focusColor,
//             //   autofocus: autofocus,
//             //   popupColor: popupColor,
//             //   validator: (_) => field.errorText,
//             //   autovalidateMode: AutovalidateMode.always,
//             //   menuMaxHeight: menuMaxHeight,
//             //   enableFeedback: enableFeedback,
//             //   alignment: alignment,
//             //   borderRadius: borderRadius,
//             // );
//           },
//         );
// }
//
// Widget _defaultTransitionBuilder(
//   BuildContext context,
//   Animation<double> animation,
//   FlyoutPlacementMode placement,
//   Widget flyout,
// ) {
//   assert(debugCheckHasFluentTheme(context));
//   assert(debugCheckHasDirectionality(context));
//   final textDirection = Directionality.of(context);
//
//   return AnimatedBuilder(
//     animation: animation,
//     builder: (context, child) {
//       /// On the slide animation, we make use of a [ClipRect] to ensure
//       /// only the necessary parts of the widgets will be visible. Altough,
//       /// [ClipRect] clips all the borders of the widget, not only the necessary
//       /// parts, hiding any shadow the [flyout] may have. To avoid this issue,
//       /// we show the flyout independent when the animation is complated (1.0)
//       /// or dismissed (0.0)
//       if (animation.isCompleted || animation.isDismissed) return child!;
//
//       if (animation.status == AnimationStatus.reverse) {
//         return FadeTransition(opacity: animation, child: child!);
//       }
//
//       switch (placement) {
//         case FlyoutPlacementMode.bottomCenter:
//         case FlyoutPlacementMode.bottomLeft:
//         case FlyoutPlacementMode.bottomRight:
//           return ClipRect(
//             child: SlideTransition(
//               textDirection: textDirection,
//               position: Tween<Offset>(
//                 begin: const Offset(0, -1),
//                 end: const Offset(0, 0),
//               ).animate(CurvedAnimation(
//                 parent: animation,
//                 curve: FluentTheme.of(context).animationCurve,
//               )),
//               child: child,
//             ),
//           );
//         case FlyoutPlacementMode.topCenter:
//         case FlyoutPlacementMode.topLeft:
//         case FlyoutPlacementMode.topRight:
//           return ClipRect(
//             child: SlideTransition(
//               textDirection: textDirection,
//               position: Tween<Offset>(
//                 begin: const Offset(0, 1),
//                 end: const Offset(0, 0),
//               ).animate(CurvedAnimation(
//                 parent: animation,
//                 curve: FluentTheme.of(context).animationCurve,
//               )),
//               child: child,
//             ),
//           );
//         default:
//           return child!;
//       }
//     },
//     child: flyout,
//   );
// }
