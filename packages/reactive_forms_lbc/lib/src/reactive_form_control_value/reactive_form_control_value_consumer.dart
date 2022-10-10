import 'package:flutter/widgets.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms_lbc/reactive_forms_lbc.dart';

class ReactiveFormControlValueConsumer<T> extends StatefulWidget {
  const ReactiveFormControlValueConsumer({
    Key? key,
    required this.builder,
    required this.listener,
    this.formControlName,
    this.formControl,
    this.buildWhen,
    this.listenWhen,
  })  : assert(
            (formControlName != null && formControl == null) ||
                (formControlName == null && formControl != null),
            'Must provide a formControlName or a formControl, but not both at the same time.'),
        super(key: key);

  final String? formControlName;

  final AbstractControl<T>? formControl;

  final ReactiveFormControlWidgetBuilder<T> builder;

  final ReactiveFormControlWidgetListener<T> listener;

  final ReactiveBuilderCondition<T>? buildWhen;

  final ReactiveFormControlValueListenerCondition<T>? listenWhen;

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
  State<ReactiveFormControlValueConsumer<T>> createState() => _ReactiveFormControlValueConsumerState<T>();
}

class _ReactiveFormControlValueConsumerState<T> extends State<ReactiveFormControlValueConsumer<T>> {
  late AbstractControl<T> _formControl;

  @override
  void initState() {
    super.initState();
    _formControl = widget.control(context);
  }

  @override
  void didUpdateWidget(ReactiveFormControlValueConsumer<T> oldWidget) {
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
    return ReactiveFormControlValueBuilder<T>(
      formControl: widget.control(context),
      builder: widget.builder,
      buildWhen: (control, previous, current) {
        if (widget.listenWhen?.call(control, previous, current) ?? true) {
          widget.listener(context, _formControl);
        }
        return widget.buildWhen?.call(_formControl, previous, current) ?? true;
      },
    );
  }
}
