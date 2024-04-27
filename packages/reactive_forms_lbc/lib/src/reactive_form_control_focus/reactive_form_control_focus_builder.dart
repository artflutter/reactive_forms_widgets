import 'package:flutter/widgets.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms_lbc/reactive_forms_lbc.dart';

typedef ReactiveFormControlFocusBuilderCondition<T> = bool Function(
  FormControl<T> control,
  bool previousValue,
  bool currentValue,
);

class ReactiveFormControlFocusBuilder<T>
    extends ReactiveFormControlFocusBuilderBase<T> {
  const ReactiveFormControlFocusBuilder({
    super.key,
    required this.builder,
    super.formControlName,
    super.formControl,
    super.buildWhen,
  }) : assert(
            (formControlName != null && formControl == null) ||
                (formControlName == null && formControl != null),
            'Must provide a formControlName or a formControl, but not both at the same time.');

  final ReactiveFormControlWidgetBuilder<T> builder;

  @override
  Widget build(BuildContext context, AbstractControl<T> control) =>
      builder(context, control);
}

abstract class ReactiveFormControlFocusBuilderBase<T> extends StatefulWidget {
  const ReactiveFormControlFocusBuilderBase({
    super.key,
    this.formControl,
    this.formControlName,
    this.buildWhen,
  });

  final String? formControlName;

  final FormControl<T>? formControl;

  final ReactiveFormControlFocusBuilderCondition<T>? buildWhen;

  Widget build(BuildContext context, FormControl<T> control);

  FormControl<T> control(BuildContext context) {
    if (formControl != null) {
      return formControl!;
    }

    final parent = ReactiveForm.of(context, listen: false);

    if (parent == null || parent is! FormControlCollection) {
      throw FormControlParentNotFoundException(this);
    }

    final collection = parent as FormControlCollection;
    final control = collection.control(formControlName!);

    if (control is! FormControl<T>) {
      throw FormControlNotFoundException(controlName: formControlName!);
    }

    return control;
  }

  @override
  State<ReactiveFormControlFocusBuilderBase<T>> createState() =>
      ReactiveFormControlFocusBuilderBaseState<T>();
}

class ReactiveFormControlFocusBuilderBaseState<T>
    extends State<ReactiveFormControlFocusBuilderBase<T>> {
  late FormControl<T> _formControl;

  @override
  void initState() {
    super.initState();
    _formControl = widget.control(context);
  }

  @override
  void didUpdateWidget(ReactiveFormControlFocusBuilderBase<T> oldWidget) {
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
    return ReactiveFormControlFocusListener<T>(
      listenWhen: widget.buildWhen,
      formControl: widget.control(context),
      listener: (context, control) => setState(() => _formControl = control),
      child: widget.build(context, _formControl),
    );
  }
}
