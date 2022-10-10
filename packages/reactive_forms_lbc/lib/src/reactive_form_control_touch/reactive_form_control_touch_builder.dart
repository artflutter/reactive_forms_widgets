import 'package:flutter/widgets.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms_lbc/reactive_forms_lbc.dart';

typedef ReactiveFormControlTouchBuilderCondition<T> = bool Function(
    AbstractControl<T> control,
    bool previousValue,
    bool currentValue,
  );

class ReactiveFormControlTouchBuilder<T> extends ReactiveFormControlTouchBuilderBase<T> {
  const ReactiveFormControlTouchBuilder({
    Key? key,
    required this.builder,
    String? formControlName,
    AbstractControl<T>? formControl,
    ReactiveFormControlTouchBuilderCondition<T>? buildWhen,
  })  : assert(
  (formControlName != null && formControl == null) ||
      (formControlName == null && formControl != null),
  'Must provide a formControlName or a formControl, but not both at the same time.'),
        super(
        key: key,
        formControl: formControl,
        formControlName: formControlName,
        buildWhen: buildWhen,
      );

  final ReactiveFormControlWidgetBuilder<T> builder;

  @override
  Widget build(BuildContext context, AbstractControl<T> control) =>
      builder(context, control);
}

abstract class ReactiveFormControlTouchBuilderBase<T> extends StatefulWidget {
  const ReactiveFormControlTouchBuilderBase({
    Key? key,
    this.formControl,
    this.formControlName,
    this.buildWhen,
  }) : super(key: key);

  final String? formControlName;

  final AbstractControl<T>? formControl;

  final ReactiveFormControlTouchBuilderCondition<T>? buildWhen;

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
  State<ReactiveFormControlTouchBuilderBase<T>> createState() =>
      ReactiveFormControlTouchBuilderBaseState<T>();
}

class ReactiveFormControlTouchBuilderBaseState<T>
    extends State<ReactiveFormControlTouchBuilderBase<T>> {
  late AbstractControl<T> _formControl;

  @override
  void initState() {
    super.initState();
    _formControl = widget.control(context);
  }

  @override
  void didUpdateWidget(ReactiveFormControlTouchBuilderBase<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldControl = oldWidget.control(context);
    final currentControl = widget.control(context);
    if (oldControl != currentControl) {
      _formControl = currentControl;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final control = widget.control(context);
    if (_formControl != control) {
      _formControl = widget.control(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveFormControlTouchListener<T>(
      listenWhen: widget.buildWhen,
      formControl: widget.control(context),
      listener: (context, control) => setState(() => _formControl = control),
      child: widget.build(context, _formControl),
    );
  }
}
