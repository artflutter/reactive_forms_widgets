import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';
import 'package:reactive_forms/reactive_forms.dart';

mixin ReactiveFormControlListenerSingleChildWidget on SingleChildWidget {}

typedef ReactiveFormControlWidgetListener<T> = void Function(BuildContext context, AbstractControl<T> control);
