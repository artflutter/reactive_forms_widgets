import 'package:flutter/widgets.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms_lbc/src/reactive_form_control_value_listener.dart';
import 'package:reactive_forms_lbc/src/state_streamable.dart';

typedef ReactiveWidgetBuilder<T> = Widget Function(BuildContext context, AbstractControl<T> control);

typedef ReactiveBuilderCondition<T> = bool Function(AbstractControl<T> control, T? previousValue, T? currentValue);

class ReactiveFormControlValueBuilder<B extends StateStreamable<T>, T>
    extends BlocBuilderBase<B, T> {
  /// {@macro bloc_builder}
  /// {@macro bloc_builder_build_when}
  const ReactiveFormControlValueBuilder({
    Key? key,
    required this.builder,
    String? formControlName,
    AbstractControl<T>? formControl,
    ReactiveBuilderCondition<T>? buildWhen,
  }) : assert(
  (formControlName != null && formControl == null) ||
      (formControlName == null && formControl != null),
  'Must provide a formControlName or a formControl, but not both at the same time.'), super(key: key, formControl: formControl,
      formControlName: formControlName, buildWhen: buildWhen,);

  /// The [builder] function which will be invoked on each widget build.
  /// The [builder] takes the `BuildContext` and current `state` and
  /// must return a widget.
  /// This is analogous to the [builder] function in [StreamBuilder].
  final ReactiveWidgetBuilder<T> builder;

  @override
  Widget build(BuildContext context, AbstractControl<T> control) => builder(context, control);

  // @override
  // Widget build(BuildContext context, T state) => builder(context, state);
}

/// {@template bloc_builder_base}
/// Base class for widgets that build themselves based on interaction with
/// a specified [bloc].
///
/// A [BlocBuilderBase] is stateful and maintains the state of the interaction
/// so far. The type of the state and how it is updated with each interaction
/// is defined by sub-classes.
/// {@endtemplate}
abstract class BlocBuilderBase<B extends StateStreamable<T>, T>
    extends StatefulWidget {
  /// {@macro bloc_builder_base}
  const BlocBuilderBase({Key? key, this.formControl,
  this.formControlName, this.buildWhen,})
      : super(key: key);

  final String? formControlName;


  final AbstractControl<T>? formControl;

  /// {@macro bloc_builder_build_when}
  final ReactiveBuilderCondition<T>? buildWhen;

  /// Returns a widget based on the `BuildContext` and current [state].
  Widget build(BuildContext context, AbstractControl<T> control);

  AbstractControl<T> control(BuildContext context) {
    if (formControl != null) {
      return formControl!;
    }

    final parent = ReactiveForm.of(context, listen: false);

    if (parent == null || parent is! FormControlCollection) {
      throw FormControlParentNotFoundException(this);
    }

    final collection = parent as FormControlCollection;
    final control = collection.control(formControlName!);

    if (control is! AbstractControl<T>) {
      throw FormControlNotFoundException(controlName: formControlName!);
    }

    return control;
  }

  @override
  State<BlocBuilderBase<B, T>> createState() => ReactiveFormControlValueBuilderBaseState<B, T>();
}

class ReactiveFormControlValueBuilderBaseState<B extends StateStreamable<T>, T>
    extends State<BlocBuilderBase<B, T>> {
  late AbstractControl<T> _formControl;
  // late T? _previousState;

  @override
  void initState() {
    super.initState();
    _formControl = widget.control(context);

    // _previousState = _formControl.value;
  }

  @override
  void didUpdateWidget(BlocBuilderBase<B, T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldControl = oldWidget.control(context);
    final currentControl = widget.control(context);
    if (oldControl != currentControl) {
      _formControl = currentControl;
      // _previousState = _formControl.value;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final control = widget.control(context);
    if (_formControl != control) {
      _formControl = widget.control(context);
      // _previousState = _formControl.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveFormControlValueListener<T>(
      listenWhen: widget.buildWhen,
      formControl: widget.control(context),
      listener: (context, control) => setState(() => _formControl = control),
      child: widget.build(context, _formControl),
    );
  }
}
