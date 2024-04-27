import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms_lbc/src/typedef.dart';

typedef ReactiveFormControlStatusListenerCondition<T> = bool Function(
  AbstractControl<T> control,
  ControlStatus previousValue,
  ControlStatus currentValue,
);

class ReactiveFormControlStatusListener<T>
    extends ReactiveFormControlStatusListenerBase<T> {
  const ReactiveFormControlStatusListener({
    super.key,
    required super.listener,
    super.formControlName,
    super.formControl,
    super.listenWhen,
    super.child,
  }) : assert(
            (formControlName != null && formControl == null) ||
                (formControlName == null && formControl != null),
            'Must provide a formControlName or a formControl, but not both at the same time.');
}

abstract class ReactiveFormControlStatusListenerBase<T>
    extends SingleChildStatefulWidget {
  const ReactiveFormControlStatusListenerBase({
    super.key,
    required this.listener,
    this.formControl,
    this.formControlName,
    this.child,
    this.listenWhen,
  }) : super(child: child);

  final String? formControlName;

  final Widget? child;

  final AbstractControl<T>? formControl;

  final ReactiveFormControlWidgetListener<T> listener;

  final ReactiveFormControlStatusListenerCondition<T>? listenWhen;

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
  SingleChildState<ReactiveFormControlStatusListenerBase<T>> createState() =>
      ReactiveFormControlStatusListenerBaseState<T>();
}

class ReactiveFormControlStatusListenerBaseState<T>
    extends SingleChildState<ReactiveFormControlStatusListenerBase<T>> {
  StreamSubscription<ControlStatus>? _subscription;
  late AbstractControl<T> _formControl;
  late ControlStatus _previousState;

  @override
  void initState() {
    super.initState();

    _formControl = widget.control(context);

    _previousState = _formControl.status;
    _subscribe();
  }

  @override
  void didUpdateWidget(ReactiveFormControlStatusListenerBase<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldControl = oldWidget.control(context);
    final currentControl = widget.control(context);

    if (oldControl != currentControl) {
      if (_subscription != null) {
        _unsubscribe();
        _formControl = currentControl;
        _previousState = _formControl.status;
      }
      _subscribe();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final control = widget.control(context);
    if (_formControl != control) {
      if (_subscription != null) {
        _unsubscribe();
        _formControl = widget.control(context);
        _previousState = _formControl.status;
      }
      _subscribe();
    }
  }

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return child ?? const SizedBox.shrink();
  }

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }

  void _subscribe() {
    _subscription = _formControl.statusChanged.listen((state) {
      if (widget.listenWhen?.call(_formControl, _previousState, state) ??
          true) {
        widget.listener(context, _formControl);
      }
      _previousState = state;
    });
  }

  void _unsubscribe() {
    _subscription?.cancel();
    _subscription = null;
  }
}
