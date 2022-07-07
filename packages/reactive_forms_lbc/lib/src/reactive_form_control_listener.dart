import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';
import 'package:reactive_forms/reactive_forms.dart';

mixin ReactiveFormControlListenerSingleChildWidget on SingleChildWidget {}

typedef ReactiveFormControlWidgetListener<T> = void Function(BuildContext context, T? value);

typedef ReactiveFormControlListenerCondition<T> = bool Function(T? previous, T? current);

class ReactiveFormControlListener<T> extends ReactiveFormControlListenerBase<T> {
  const ReactiveFormControlListener({
    Key? key,
    required ReactiveFormControlWidgetListener listener,
    String? formControlName,
    AbstractControl<T>? formControl,
    ReactiveFormControlListenerCondition? listenWhen,
    Widget? child,
  }) : assert(
  (formControlName != null && formControl == null) ||
      (formControlName == null && formControl != null),
  'Must provide a formControlName or a formControl, but not both at the same time.'),super(
    key: key,
    child: child,
    listener: listener,
    formControl: formControl,
    formControlName: formControlName,
    listenWhen: listenWhen,
  );
}

abstract class ReactiveFormControlListenerBase<T>
    extends SingleChildStatefulWidget {
  const ReactiveFormControlListenerBase({
    Key? key,
    required this.listener,
    this.formControl,
    this.formControlName,
    this.child,
    this.listenWhen,
  }) : super(key: key, child: child);

  final String? formControlName;

  final Widget? child;

  final AbstractControl<T>? formControl;

  final ReactiveFormControlWidgetListener<T> listener;

  final ReactiveFormControlListenerCondition<T>? listenWhen;

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
  SingleChildState<ReactiveFormControlListenerBase<T>> createState() =>
      ReactiveFormControlListenerBaseState<T>();
}

class ReactiveFormControlListenerBaseState<T>
    extends SingleChildState<ReactiveFormControlListenerBase<T>> {
  StreamSubscription? _subscription;
  late AbstractControl<T> _formControl;
  late T? _previousState;

  @override
  void initState() {
    super.initState();

    _formControl = widget.control(context);

    _previousState = _formControl.value;
    _subscribe();
  }


  @override
  void didUpdateWidget(ReactiveFormControlListenerBase<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldControl = oldWidget.control(context);
    final currentControl = widget.control(context);

    if (oldControl != currentControl) {
      if (_subscription != null) {
        _unsubscribe();
        _formControl = currentControl;
        _previousState = _formControl.value;
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
        _previousState = _formControl.value;
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
    print('_Subscribe');
    _subscription = _formControl.valueChanges.listen((state) {
      if (widget.listenWhen?.call(_previousState, state) ?? true) {
        widget.listener(context, state);
      }
      _previousState = state;
    });
  }

  void _unsubscribe() {
    print('_Unsubscribe');
    _subscription?.cancel();
    _subscription = null;
  }
}
