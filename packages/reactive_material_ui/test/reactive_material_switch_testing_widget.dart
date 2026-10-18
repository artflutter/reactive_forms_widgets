import 'package:reactive_material_ui/reactive_material_ui.dart';
import 'package:reactive_forms/reactive_forms.dart';

final reactiveSwitchTestingName = 'switch';

class ReactiveSwitchTestingWidget extends StatelessWidget {
  final FormGroup form;
  final FocusNode? focusNode;
  final ReactiveFormFieldCallback<bool>? onChanged;
  final ReactiveFormFieldCallback<bool>? adaptativeOnChanged;

  const ReactiveSwitchTestingWidget({
    super.key,
    required this.form,
    this.focusNode,
    this.onChanged,
    this.adaptativeOnChanged,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: ReactiveForm(
          formGroup: form,
          child: Column(
            children: <Widget>[
              ReactiveMaterialSwitch(
                formControlName: reactiveSwitchTestingName,
                focusNode: focusNode,
                onChanged: onChanged,
              ),
              ReactiveMaterialSwitch.adaptive(
                formControlName: reactiveSwitchTestingName,
                focusNode: focusNode,
                onChanged: adaptativeOnChanged,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
