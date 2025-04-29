import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:flutter/widgets.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms_lbc/reactive_forms_lbc.dart';

class ReactiveFormControlFocusConsumer<T> extends StatefulWidget {
  const ReactiveFormControlFocusConsumer({
    super.key,
    required this.builder,
    this.listener,
    this.formControlName,
    this.formControl,
    this.buildWhen,
    this.listenWhen,
  }) : assert(
            (formControlName != null && formControl == null) ||
                (formControlName == null && formControl != null),
            'Must provide a formControlName or a formControl, but not both at the same time.');

  final String? formControlName;

  final FormControl<T>? formControl;

  final ReactiveFormControlWidgetBuilder<T> builder;

  final ReactiveFormControlWidgetListener<T>? listener;

  final ReactiveFormControlFocusBuilderCondition<T>? buildWhen;

  final ReactiveFormControlFocusListenerCondition<T>? listenWhen;

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
  State<ReactiveFormControlFocusConsumer<T>> createState() =>
      _ReactiveFormControlFocusConsumerState<T>();
}

class _ReactiveFormControlFocusConsumerState<T>
    extends State<ReactiveFormControlFocusConsumer<T>> {
  late FormControl<T> _formControl;

  @override
  void initState() {
    super.initState();
    _formControl = widget.control(context);
  }

  @override
  void didUpdateWidget(ReactiveFormControlFocusConsumer<T> oldWidget) {
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
    return ReactiveFormControlFocusBuilder<T>(
      formControl: widget.control(context),
      builder: widget.builder,
      buildWhen: (control, previous, current) {
        if (widget.listenWhen?.call(control, previous, current) ?? true) {
          widget.listener?.call(context, _formControl);
        }
        return widget.buildWhen?.call(_formControl, previous, current) ?? true;
      },
    );
  }
}
