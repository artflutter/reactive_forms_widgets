import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms_lbc/src/typedef.dart';

typedef ReactiveBuilderCondition<T> = bool Function(
  AbstractControl<T> control,
  T? previousValue,
  T? currentValue,
);


bool notEquals(AbstractControl<dynamic> control, dynamic a, dynamic b) =>
    a != b;

class ReactiveFormControlValueBuilder<T>
    extends ReactiveFormControlValueBuilderBase<T> {
  const ReactiveFormControlValueBuilder({
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

abstract class ReactiveFormControlValueBuilderBase<T> extends StatefulWidget {
  const ReactiveFormControlValueBuilderBase({
    super.key,
    this.formControl,
    this.formControlName,
    this.buildWhen,
  });

  final String? formControlName;

  final AbstractControl<T>? formControl;

  final ReactiveBuilderCondition<T>? buildWhen;

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
  StreamSubscription<T?>? _subscription;
  late AbstractControl<T> _formControl;
  late T? _previousValue;

  @override
  void initState() {
    super.initState();
    _formControl = widget.control(context);
    _previousValue = _formControl.value;
    _subscribe();
  }

  @override
  void didUpdateWidget(ReactiveFormControlValueBuilderBase<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldControl = oldWidget.control(context);
    final currentControl = widget.control(context);
    if (oldControl != currentControl) {
      _unsubscribe();
      _formControl = currentControl;
      _previousValue = _formControl.value;
      _subscribe();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final control = widget.control(context);
    if (_formControl != control) {
      _unsubscribe();
      _formControl = control;
      _previousValue = _formControl.value;
      _subscribe();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.build(context, _formControl);
  }

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }

  void _subscribe() {
    _subscription = _formControl.valueChanges.listen((value) {
      if (widget.buildWhen?.call(_formControl, _previousValue, value) ?? true) {
        setState(() {
          _formControl = widget.control(context);
        });
      }
      _previousValue = value;
    });
  }

  void _unsubscribe() {
    _subscription?.cancel();
    _subscription = null;
  }
}
