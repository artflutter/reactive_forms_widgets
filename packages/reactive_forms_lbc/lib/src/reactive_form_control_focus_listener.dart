import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms_lbc/src/typedef.dart';


typedef ReactiveFormControlFocusListenerCondition<T> = bool Function(FormControl<T> control, bool previousValue, bool currentValue);

class ReactiveFormControlFocusListener<T> extends ReactiveFormControlFocusListenerBase<T> {
  const ReactiveFormControlFocusListener({
    Key? key,
    required ReactiveFormControlWidgetListener listener,
    String? formControlName,
    FormControl<T>? formControl,
    ReactiveFormControlFocusListenerCondition? listenWhen,
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

abstract class ReactiveFormControlFocusListenerBase<T>
    extends SingleChildStatefulWidget {
  const ReactiveFormControlFocusListenerBase({
    Key? key,
    required this.listener,
    this.formControl,
    this.formControlName,
    this.child,
    this.listenWhen,
  }) : super(key: key, child: child);

  final String? formControlName;

  final Widget? child;

  final FormControl<T>? formControl;

  final ReactiveFormControlWidgetListener<T> listener;

  final ReactiveFormControlFocusListenerCondition? listenWhen;

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
  SingleChildState<ReactiveFormControlFocusListenerBase<T>> createState() =>
      ReactiveFormControlFocusListenerBaseState<T>();
}

class ReactiveFormControlFocusListenerBaseState<T>
    extends SingleChildState<ReactiveFormControlFocusListenerBase<T>> {
  StreamSubscription? _subscription;
  late FormControl<T> _formControl;
  late bool _previousState;

  @override
  void initState() {
    super.initState();

    _formControl = widget.control(context);

    _previousState = _formControl.touched;
    _subscribe();
  }


  @override
  void didUpdateWidget(ReactiveFormControlFocusListenerBase<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldControl = oldWidget.control(context);
    final currentControl = widget.control(context);

    if (oldControl != currentControl) {
      if (_subscription != null) {
        _unsubscribe();
        _formControl = currentControl;
        _previousState = _formControl.touched;
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
        _previousState = _formControl.touched;
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
    _subscription = _formControl.focusChanges.listen((state) {
      if (widget.listenWhen?.call(_formControl, _previousState, state) ?? true) {
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
