import 'package:flutter/widgets.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms_lbc/reactive_forms_lbc.dart';

class ReactiveFormControlValueConsumer<T> extends StatelessWidget {
  const ReactiveFormControlValueConsumer({
    super.key,
    required this.builder,
    this.listener,
    this.formControlName,
    this.formControl,
    this.buildWhen,
    this.listenWhen,
    this.listenerOnInit,
  }) : assert(
            (formControlName != null && formControl == null) ||
                (formControlName == null && formControl != null),
            'Must provide a formControlName or a formControl, but not both at the same time.');

  final String? formControlName;

  final AbstractControl<T>? formControl;

  final ReactiveFormControlWidgetBuilder<T> builder;

  final ReactiveFormControlWidgetListener<T>? listener;

  final ReactiveFormControlWidgetInitListener<T>? listenerOnInit;

  final ReactiveBuilderCondition<T>? buildWhen;

  final ReactiveFormControlValueListenerCondition<T>? listenWhen;

  @override
  Widget build(BuildContext context) {
    final builderWidget = ReactiveFormControlValueBuilder<T>(
      formControlName: formControlName,
      formControl: formControl,
      buildWhen: buildWhen,
      builder: builder,
    );

    if (listener == null && listenerOnInit == null) {
      return builderWidget;
    }

    return ReactiveFormControlValueListener<T>(
      formControlName: formControlName,
      formControl: formControl,
      listenWhen: listenWhen,
      listenerOnInit: listenerOnInit,
      listener: listener,
      child: builderWidget,
    );
  }
}
