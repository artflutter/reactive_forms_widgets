import 'package:flutter/widgets.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms_lbc/reactive_forms_lbc.dart';

typedef ReactiveBuilderCondition<T> = bool Function(
  AbstractControl<T> control,
  T? previousValue,
  T? currentValue,
);

class ReactiveFormControlValueBuilder<T>
    extends ReactiveFormControlValueBuilderBase<T> {
  const ReactiveFormControlValueBuilder({
    super.key,
    required this.builder,
    super.formControlName,
    super.formControl,
    super.buildWhen,
    super.listenOnInit,
  }) : assert(
            (formControlName != null && formControl == null) ||
                (formControlName == null && formControl != null),
            'Must provide a formControlName or a formControl, but not both at the same time.');

  final ReactiveFormControlWidgetBuilder<T> builder;

  @override
  Widget build(BuildContext context, AbstractControl<T> control) =>
      builder(context, control);
}

abstract class ReactiveFormControlValueBuilderBase<T> extends StatefulWidget {
  const ReactiveFormControlValueBuilderBase({
    super.key,
    this.formControl,
    this.formControlName,
    this.buildWhen,
    this.listenOnInit = false,
  });

  final String? formControlName;

  final AbstractControl<T>? formControl;

  final ReactiveBuilderCondition<T>? buildWhen;
  final bool listenOnInit;

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
  State<ReactiveFormControlValueBuilderBase<T>> createState() =>
      ReactiveFormControlValueBuilderBaseState<T>();
}

class ReactiveFormControlValueBuilderBaseState<T>
    extends State<ReactiveFormControlValueBuilderBase<T>> {
  late AbstractControl<T> _formControl;

  @override
  void initState() {
    super.initState();
    _formControl = widget.control(context);
  }

  @override
  void didUpdateWidget(ReactiveFormControlValueBuilderBase<T> oldWidget) {
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
    return ReactiveFormControlValueListener<T>(
      listenOnInit: widget.listenOnInit,
      listenWhen: widget.buildWhen,
      formControl: widget.control(context),
      listener: (context, control) => setState(() => _formControl = control),
      child: widget.build(context, _formControl),
    );
  }
}
